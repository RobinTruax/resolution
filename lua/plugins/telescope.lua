--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file installs and configures telescope.nvim and its many extensions.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

--------------------------------- dependencies ---------------------------------
local utilities = require('core.utilities')

------------- install a faster fuzzy searcher if on a unix system --------------

local fzf = {}
if vim.g.windows == false then
    fzf = {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        lazy = true,
    }
end

--------------------------------------------------------------------------------

return {

    ------------- telescope-fzf-native.nvim: fzf syntax/faster search --------------
    fzf,

    ------------------------ nvim-neoclip.lua: search yanks ------------------------
    {
        'AckslD/nvim-neoclip.lua',
        event = 'VeryLazy',
        -- configuration
        config = true,
    },

    -------------------------------- telescope.nvim --------------------------------
    {
        'nvim-telescope/telescope.nvim',
        event = 'VeryLazy',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
            'BurntSushi/ripgrep',
            'AckslD/nvim-neoclip.lua',
            'debugloop/telescope-undo.nvim',
            'nvim-telescope/telescope-bibtex.nvim',
        },

        -- configuration
        config = function()
            -- set up telescope
            require('telescope').setup({
                defaults = require('plugins.telescope.default_opts'),
                pickers = require('plugins.telescope.picker_opts'),
                extensions = {
                    bibtex = {
                        global_files = {
                            utilities.config_path() .. '/tex/style/zotero.bib'
                        },
                    }
                }
            })

            -- eliminate a gap in telescope's positioning
            require('plugins.telescope.fix_anchor')

            -- overwrite the grep entry maker for telescope
            require('plugins.telescope.grep_entry_maker')

            -- enable wrapping and disable numbering in preview windows
            vim.api.nvim_create_autocmd('User', {
                pattern = 'TelescopePreviewerLoaded',
                callback = function()
                    vim.wo.wrap = true
                    vim.wo.number = false
                end,
            })

            -- extensions
            if vim.g.windows == true then
                require('telescope').load_extension('fzf')
            end
            require('telescope').load_extension('neoclip')
            require('telescope').load_extension('undo')
            require('telescope').load_extension('bibtex')
        end,
    },

}

--------------------------------------------------------------------------------
