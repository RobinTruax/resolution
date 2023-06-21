--[[------------------- resolution v0.1.0 -----------------------

a prettier entry maker for grep functionality

---------------------------------------------------------------]]

-------------------- telescope dependencies ---------------------
local utils = require('telescope.utils')
local Path = require('plenary.path')

-------------------- local utility functions --------------------

local lookup_keys = {
    value = 1,
    ordinal = 1,
}

local handle_entry_index = function(opts, t, k)
    local override = ((opts or {}).entry_index or {})[k]
    if not override then
        return
    end

    local val, save = override(t, opts)
    if save then
        rawset(t, k, val)
    end
    return val
end

local parse_with_col = function(t)
    local _, _, filename, lnum, col, text = string.find(t.value, [[(..-):(%d+):(%d+):(.*)]])

    local ok
    ok, lnum = pcall(tonumber, lnum)
    if not ok then
        lnum = nil
    end

    ok, col = pcall(tonumber, col)
    if not ok then
        col = nil
    end

    t.filename = filename
    t.lnum = lnum
    t.col = col
    t.text = text

    return { filename, lnum, col, text }
end

-------------------------- entry maker --------------------------

local function grep_entry_maker(opts)
    opts = opts or {}

    local mt_vimgrep_entry
    local parse = parse_with_col
    local path_hidden = opts.path_hidden

    local execute_keys = {
        path = function(t)
            if Path:new(t.filename):is_absolute() then
                return t.filename, false
            else
                return Path:new({ t.cwd, t.filename }):absolute(), false
            end
        end,
        filename = function(t) return parse(t)[1], true end,
        lnum = function(t) return parse(t)[2], true end,
        col = function(t) return parse(t)[3], true end,
        text = function(t) return parse(t)[4], true end,
    }

    local display_string = '%s%s%s'

    mt_vimgrep_entry = {
        cwd = vim.fn.expand(vim.loop.cwd()),

        display = function(entry)
            local display_filename = ''
            local coordinates = ''
            if not path_hidden then
                display_filename = utils.transform_path(opts, entry.filename)
                coordinates = '  '
            end

            local text = opts.file_encoding and vim.iconv(entry.text, opts.file_encoding, 'utf8') or entry.text
            local display, _, _ = utils.transform_devicons(
                entry.filename,
                string.format(display_string, display_filename, coordinates, text),
                true
            )

            return display
        end,

        __index = function(t, k)
            local override = handle_entry_index(opts, t, k)
            if override then
                return override
            end

            local raw = rawget(mt_vimgrep_entry, k)
            if raw then
                return raw
            end

            local executor = rawget(execute_keys, k)
            if executor then
                local val, save = executor(t)
                if save then
                    rawset(t, k, val)
                end
                return val
            end

            return rawget(t, rawget(lookup_keys, k))
        end,
    }

    return function(line)
        return setmetatable({ line }, mt_vimgrep_entry)
    end
end

-----------------------------------------------------------------

return grep_entry_maker

-----------------------------------------------------------------
