--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file sets the default options for individual telescope pickers.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

return {
    live_grep = {
        prompt_title = 'Grep in Buffer',
        entry_maker = require('plugins.telescope.grep_entry_maker')({
            path_hidden = true
        }),
    },
    grep_string = {
        prompt_title = 'Grep Visual Selection',
        entry_maker = require('plugins.telescope.grep_entry_maker')(),
    },
    buffers = {
        prompt_title = 'Choose Buffer',
    },
    lsp_document_symbols = {
        prompt_title = 'Jump in Document',
        ignore_symbols = { 'enum', 'enummember', 'constant' },
        entry_maker = require('plugins.telescope.symbols_entry_maker')({
            path_hidden = true
        })
    },
    lsp_workspace_symbols = {
        prompt_title = 'Jump in Project',
        entry_maker = require('plugins.telescope.symbols_entry_maker')({
            path_hidden = false, fname_width = 20
        })
    }
}

--------------------------------------------------------------------------------
