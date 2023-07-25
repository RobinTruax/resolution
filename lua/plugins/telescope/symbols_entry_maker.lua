--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file creates a prettier entry maker to LSP symbol-type telescopes. This is
then used to overwrite the included entry maker for these calls.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

---------------------------- telescope dependencies ----------------------------

local make_entry    = require('telescope.make_entry')
local entry_display = require('telescope.pickers.entry_display')
local utils         = require('telescope.utils')

--------------------------- local utility functions ----------------------------

-- a function for robustly obtaining filenames
local get_filename_fn = function()
    local bufnr_name_cache = {}
    return function(bufnr)
        bufnr = vim.F.if_nil(bufnr, 0)
        local c = bufnr_name_cache[bufnr]
        if c then
            return c
        end

        local n = vim.api.nvim_buf_get_name(bufnr)
        bufnr_name_cache[bufnr] = n
        return n
    end
end

-- a modified list of highlights
local lsp_type_highlight = {
    ['Class'] = 'TelescopeResultsClass',
    ['Module'] = 'TelescopeResultsConstant',
    ['Field'] = 'TelescopeResultsField',
    ['Function'] = 'TelescopeResultsFunction',
    ['Variable'] = 'TelescopeResultsMethod',
    ['Property'] = 'TelescopeResultsOperator',
    ['Struct'] = 'TelescopeResultsStruct',
    ['Method'] = 'TelescopeResultsVariable',
}

--------------------------- overwriting entry maker ----------------------------

local function symbols_entry_maker(opts)
    opts = opts or {}
    local hidden = opts.path_hidden or false

    -- design structure of entry
    local display_items = {{ remaining = true }}
    if not hidden then
        table.insert(display_items, 1, { width = vim.F.if_nil(opts.fname_width, 30) })
    end

    -- create auxiliary function for making display
    local displayer = entry_display.create {
        separator = " ",
        hl_chars = { ["["] = "TelescopeBorder", ["]"] = "TelescopeBorder" },
        items = display_items,
    }

    -- create function for making the display
    local make_display = function(entry)
        if hidden then
            return displayer {
                { entry.symbol_name, lsp_type_highlight[entry.symbol_type] },
            }
        else
            return displayer {
                utils.transform_path(opts, entry.filename),
                { entry.symbol_name, lsp_type_highlight[entry.symbol_type] },
            }
        end
    end

    -- return the entry maker itself
    local get_filename = get_filename_fn()
    return function(entry)
        local filename = vim.F.if_nil(entry.filename, get_filename(entry.bufnr))
        local symbol_msg = entry.text
        local symbol_type, symbol_name = symbol_msg:match "%[(.+)%]%s+(.*)"
        local ordinal = ""
        if not hidden and filename then
            ordinal = filename .. " "
        end
        ordinal = ordinal .. symbol_name
        return make_entry.set_default_entry_mt({
            value = entry,
            ordinal = ordinal,
            display = make_display,
            filename = filename,
            lnum = entry.lnum,
            col = entry.col,
            symbol_name = symbol_name,
            symbol_type = symbol_type,
            start = entry.start,
            finish = entry.finish,
        }, opts)
    end
end

--------------------------------------------------------------------------------

return symbols_entry_maker

--------------------------------------------------------------------------------
