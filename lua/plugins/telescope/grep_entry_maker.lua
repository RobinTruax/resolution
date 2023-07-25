--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file creates a prettier entry maker for grep-type telescopes. This is then
used to overwrite the included entry maker for these calls.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

-- sorry, this file is also arcane to me. it's essentially all telescope's code
-- which is added here so that it can be overwritten without including all of 
-- telescope or interfering with updates

---------------------------- telescope dependencies ----------------------------

local utils = require('telescope.utils')
local Path = require('plenary.path')
local make_entry = require('telescope.make_entry')

--------------------------- local utility functions ----------------------------

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

--------------------------------- entry maker ----------------------------------

-- overwriting the in-place file due to some behavioral inconsistencies
function make_entry.gen_from_vimgrep(opts)
    opts = opts or {}

    local mt_vimgrep_entry
    local parse = parse_with_col

    local disable_devicons = opts.disable_devicons
    local disable_coordinates = opts.disable_coordinates
    local only_sort_text = opts.only_sort_text

    local execute_keys = {
        path = function(t)
            if Path:new(t.filename):is_absolute() then
                return t.filename, false
            else
                return Path:new({ t.cwd, t.filename }):absolute(), false
            end
        end,

        filename = function(t)
            return parse(t)[1], true
        end,

        lnum = function(t)
            return parse(t)[2], true
        end,

        col = function(t)
            return parse(t)[3], true
        end,

        text = function(t)
            return parse(t)[4], true
        end,
    }

    -- For text search only, the ordinal value is actually the text.
    if only_sort_text then
        execute_keys.ordinal = function(t)
            return t.text
        end
    end

    local display_string = "%s%s%s"

    mt_vimgrep_entry = {
        cwd = vim.fn.expand(opts.cwd or vim.loop.cwd()),

        display = function(entry)
            local display_filename = ''
            local coordinates = entry.lnum
            if opts.hide_path == true then
                local to_pad = math.max(0, 6 - string.len(coordinates))
                coordinates = coordinates .. string.rep(' ', to_pad)
            else
                display_filename = utils.transform_path(opts, entry.filename)
                coordinates = ':' .. coordinates .. ' '
            end

            local display, hl_group, icon = utils.transform_devicons(
                entry.filename,
                string.format(display_string, display_filename, coordinates, string.gsub(entry.text, '^[%s]+', '')),
                disable_devicons
            )

            if hl_group then
                return display, { { { 0, #icon }, hl_group } }
            else
                return display
            end
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

--------------------------------------------------------------------------------
