--[[------------------- resolution v0.1.0 -----------------------

all ui components which run on startup

-------------------------------------------------------------]]

return {
    ----------------- mini.starter: startup screen ------------------
    {
        'echasnovski/mini.starter',
        version = '*',
        config = function()
            -- get preferences and necessary functions
            local prefs = require('config.preferences')
            local starter = require('mini.starter')

            -- better recent_files pop-up
            local recent_files = function(n)
                return function()
                    -- get files
                    local files = vim.tbl_filter(function(f) return vim.fn.filereadable(f) == 1 end, vim.v.oldfiles or {})

                    -- return nothing if there are no recent files
                    if #files == 0 then return { { name = 'none', action = '', section = 'recent files' } } end

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
                    {
                        {
                            action = require('filesys.project_menu').project_menu,
                            name = 'open math project',
                            section = 'actions'
                        },
                        {
                            action = 'enew',
                            name = 'new math project',
                            section = 'actions'
                        },
                        {
                            action = 'Telescope find_files hidden=true',
                            name = 'search for file',
                            section = 'actions'
                        },
                        {
                            action = 'Telescope find_files cwd=' .. vim.fn.stdpath('config'),
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
                    recent_files(prefs.number_recent_files),
                },
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

    ------------------- lualine.nvim: status line -------------------
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            -- set up separators based on ui sharpness
            local section_separators = {}
            if require('config.aesthetics').ui_sharp == true then
                section_separators = { left = '', right = '' }
            else
                section_separators = { left = '', right = '' }
            end

            -- required setting for showcmd to function
            vim.opt.showcmdloc = 'statusline'

            -- set up statusline
            require('lualine').setup({
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
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { '%S' },
                    lualine_c = {
                        {
                            require("noice").api.status.message.get_hl,
                            cond = function()
                                if require("noice").api.status.search.has() == true then
                                    return false
                                else
                                    return require("noice").api.status.message.has()
                                end
                            end
                        },
                        {
                            require("noice").api.status.mode.get,
                            cond = require("noice").api.status.mode.has,
                            color = 'CommandMode',
                        },
                        {
                            require("noice").api.status.search.get,
                            cond = require("noice").api.status.search.has,
                            color = 'CommandMode',
                        },
                    },
                    lualine_x = { 'diff', 'branch' },
                    lualine_y = {
                        function() return require("filesys.menus.utilities").get_project_name(vim.fn.getcwd()) end },
                    lualine_z = { 'location' },
                },
            })
        end
    },
}
-----------------------------------------------------------------
