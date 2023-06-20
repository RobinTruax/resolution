--[[------------------- resolution v0.1.0 -----------------------

new buffer entry maker

-------------------------------------------------------------]]

------------------ dependencies from telescope ------------------

local make_entry = require('telescope.make_entry')
local entry_display = require('telescope.pickers.entry_display')
local utils = require "telescope.utils"
local strings = require "plenary.strings"
local Path = require "plenary.path"

-------------------- overwriting entry maker --------------------

function make_entry.gen_from_buffer(opts)
    opts = opts or {}
    local icon_width = 0
    local icon, _ = utils.get_devicons("fname")
    icon_width = strings.strdisplaywidth(icon)

    local displayer = entry_display.create {
        separator = " ",
        items = {
            { width = icon_width },
            { remaining = true },
        },
    }

    local cwd = vim.fn.expand(opts.cwd or vim.loop.cwd())
    local make_display = function(entry)
        local display_bufname = utils.transform_path(opts, entry.filename)
        local icon, hl_group = utils.get_devicons(entry.filename)

        return displayer {
            { icon, hl_group },
            display_bufname .. ":" .. entry.lnum,
        }
    end

    return function(entry)
        local bufname = entry.info.name ~= "" and entry.info.name or "[No Name]"
        bufname = Path:new(bufname):normalize(cwd)

        local hidden = entry.info.hidden == 1 and "h" or "a"
        local readonly = vim.api.nvim_buf_get_option(entry.bufnr, "readonly") and "=" or " "
        local changed = entry.info.changed == 1 and "+" or " "
        local indicator = entry.flag .. hidden .. readonly .. changed
        local lnum = 1

        -- account for potentially stale lnum as getbufinfo might not be updated or from resuming buffers picker
        if entry.info.lnum ~= 0 then
            -- but make sure the buffer is loaded, otherwise line_count is 0
            if vim.api.nvim_buf_is_loaded(entry.bufnr) then
                local line_count = vim.api.nvim_buf_line_count(entry.bufnr)
                lnum = math.max(math.min(entry.info.lnum, line_count), 1)
            else
                lnum = entry.info.lnum
            end
        end

        return make_entry.set_default_entry_mt({
            value = bufname,
            ordinal = entry.bufnr .. " : " .. bufname,
            display = make_display,

            bufnr = entry.bufnr,
            filename = bufname,
            lnum = lnum,
            indicator = indicator,
        }, opts)
    end
end

-----------------------------------------------------------------
