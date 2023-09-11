--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file includes and configures all UI components which run on startup.

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

    ------------------------- mini.starter: startup screen -------------------------

    {
        'echasnovski/mini.starter',
        version = '*',

        -- configuration
        config = function()
            -- get preferences and necessary functions
            local prefs = require('config.preferences')
            local starter = require('mini.starter')

            -- better recent_files pop-up
            local recent_files = function(n)
                return function()
                    -- get files
                    local files = vim.tbl_filter(function(f)
                        return vim.fn.filereadable(f) == 1
                    end, vim.v.oldfiles or {})

                    -- return nothing if there are no recent files
                    if #files == 0 then
                        return {
                            {
                                name = 'none',
                                action = '',
                                section = 'recent files'
                            }
                        }
                    end

                    -- add items for each recent file up to the maximium number
                    local items = {}
                    local fmodify = vim.fn.fnamemodify
                    for _, f in ipairs(vim.list_slice(files, 1, n)) do
                        local path = (' (%s/%s)'):format(fmodify(f, ':p:h:h:t'), fmodify(f, ':p:h:t'))
                        local name = ('%s%s'):format(fmodify(f, ':t'), path)
                        table.insert(items,
                            {
                                action = ('cd %s | edit %s'):format(fmodify(f, ':p:h'), fmodify(f, ':p')),
                                name = name,
                                section = 'recent files'
                            })
                    end

                    return items
                end
            end

            -- configure the startup screen
            local config = {
                query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_-. ',
                evaluate_single = true,
                silent = true,
                header = 'resolution',
                items = {
                    -- first section: default actions
                    {
                        {
                            action = function()
                                require('filesys.actions.choose_project')()
                            end,
                            name = 'open math project',
                            section = 'actions'
                        },
                        {
                            action = function()
                                require('filesys.actions.create_project')()
                            end,
                            name = 'new math project',
                            section = 'actions'
                        },
                        {
                            action = 'Telescope find_files cwd=~',
                            name = 'search for file',
                            section = 'actions'
                        },
                        {
                            action = 'Telescope find_files cwd=' .. vim.fn.stdpath('config') .. '/lua/config',
                            name = 'customize rsltn',
                            section = 'actions'
                        },
                        {
                            action = 'Lazy',
                            name = 'lazy.nvim (plugins)',
                            section = 'actions'
                        },
                        {
                            action = 'enew',
                            name = 'documentation',
                            section = 'actions'
                        },
                        {
                            action = 'q',
                            name = 'quit',
                            section = 'actions'
                        },
                        {
                            action = 'WhichKey <leader>',
                            name = ' ',
                            section = 'actions'
                        },
                    },
                    -- second section: default files
                    recent_files(prefs.number_recent_files),
                },
                -- changes to default visual settings
                content_hooks = {
                    starter.gen_hook.adding_bullet(),
                    starter.gen_hook.padding(3, 2),
                },
                footer = 'press space for more',
            }

            -- finish setup
            starter.setup(config)
        end
    },

    -------------------------- lualine.nvim: status line ---------------------------

    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        dependencies = { 'nvim-tree/nvim-web-devicons' },

        -- configuration
        config = function()
            -- set up separators based on ui sharpness
            local section_separators = { left = '', right = '' }

            -- required setting for showcmd to function
            vim.opt.showcmdloc = 'statusline'

            -- set up statusline
            require('lualine').setup({
                -- options
                options = {
                    theme = 'auto',
                    icons_enabled = true,
                    section_separators = section_separators,
                    component_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = { 'starter' },
                        winbar = { 'starter', 'toggleterm', 'NvimTree' },
                    },
                    always_divide_middle = true,
                    globalstatus = true,
                    refresh = {
                        statusline = 1000,
                    },
                },
                -- sections of statusline
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { '%S' },
                    lualine_c = {
                        {
                            require('noice').api.status.mode.get,
                            cond = require('noice').api.status.mode.has,
                            color = 'CommandMode',
                        },
                        {
                            require('noice').api.status.search.get,
                            cond = require('noice').api.status.search.has,
                            color = 'CommandMode',
                        },
                    },
                    lualine_x = { 'diff', 'branch' },
                    lualine_y = {
                        function()
                            local util = require('core.utilities')
                            return util.get_project_name(util.current_directory())
                        end },
                    lualine_z = { 'location' },
                },
            })
        end
    },
}

--------------------------------------------------------------------------------
