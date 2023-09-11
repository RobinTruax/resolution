--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file installs and configures all plugins providing UI components not called
on startup.

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

    ---------------------- toggleterm.nvim: a better terminal ----------------------

    {
        'akinsho/toggleterm.nvim',
        version = '*',
        cmd = {'ToggleTerm', 'TermExec'},

        -- configuration
        config = true,
    },

    ------------------------ nvim-tree.nvim: file explorer -------------------------

    {
        'nvim-tree/nvim-tree.lua',
        version = '*',
        cmd = { 'NvimTreeOpen', 'NvimTreeToggle', 'NvimTreeFindFile', 'NvimTreeFindFileToggle' },
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },

        -- configuration
        config = function()
            require('nvim-tree').setup({
                view = {
                    number = true,
                    relativenumber = true,
                    signcolumn = 'no',
                },
            })
        end,
    },

    ------------------------ lazygit.nvim: git integration -------------------------

    {
        'kdheepak/lazygit.nvim',
        cmd = { 'LazyGit', 'LazyGitCurrentFile' },
        dependencies = {
            'nvim-lua/plenary.nvim',
        },

        -- configuration
        config = function()
            vim.g.lazygit_floating_window_border_chars = require('core.ui').get_borders()
            vim.g.lazygit_floating_window_scaling_factor = 0.8
        end
    },

    --------------------- which-key.nvim: keybind-based menus ----------------------

    {
        'folke/which-key.nvim',
        cmd = 'WhichKey',
        event = { 'BufReadPost', 'BufNewFile' },

        -- configuration
        config = function()
            -- necessary for which-key to function
            vim.o.timeout = true

            -- register 'other'-type keybinds
            local flat_other_keybinds = {}
            local other_keybinds = require('config.other-keybinds')
            for k, v in pairs(other_keybinds) do
                if v.cmd == false then
                    flat_other_keybinds[k] = { name = v.desc }
                end
            end

            -- register 'leader'-type keybinds
            local flat_leader_keybinds = {}
            local leader_keybinds = require('config.leader-keybinds')
            for k, v in pairs(leader_keybinds) do
                if v.cmd == false then
                    flat_leader_keybinds['<leader>' .. k] = { name = v.desc }
                end
            end

            local border = 'none'
            -- ui customization and setup
            local wk = require('which-key')
            wk.setup({
                window = {
                    winblend = 18,
                    border = border,
                },
                layout = {
                    height = { min = 4, max = 10 },
                    width = { min = 20, max = 40 },
                    spacing = 3,
                    align = 'center',
                }
            })
            wk.register(flat_other_keybinds)
            wk.register(flat_leader_keybinds)
        end,
    },

    ----------------------------- markdown previewing ------------------------------

    {
        'iamcco/markdown-preview.nvim',
        event = 'VeryLazy',

        -- configuration
        build = function()
            vim.fn['mkdp#util#install']()
        end,
        config = function()
            vim.g.mkdp_auto_close = 0
        end
    },

}

--------------------------------------------------------------------------------
