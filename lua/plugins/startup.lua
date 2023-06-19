--[[------------------- resolution v0.1.0 -----------------------

all ui elements which run on startup

-------------------------------------------------------------]]

return {
    ----------------- mini.starter: startup screen ------------------
    {
        'echasnovski/mini.starter',
        version = '*',
        config = function()
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

            -- config file
            local config = {
                query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_-. ',
                evaluate_single = true,
                silent = true,
                header = 'resolution',
                items = {
                    {
                        {
                            action = 'enew',
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

            -- call setup
            starter.setup(config)
        end
    },

    ------------------- lualine.nvim: status line -------------------
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local section_separators = {}
            if require('config.aesthetics').ui_sharp == true then
                section_separators = { left = '', right = '' }
            else
                section_separators = { left = '', right = '' }
            end

            vim.opt.showcmdloc = 'statusline'

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
                    lualine_b = { 'searchcount', '%S' },
                    lualine_c = { 'require("core.ui").macro_recording_sl()' },
                    lualine_x = { 'diff' },
                    lualine_y = { 'branch' },
                    lualine_z = { 'location' },
                },
            })
        end
    },

    --------------- barbecue: winbar location system ----------------
    {
        'utilyre/barbecue.nvim',
        name = 'barbecue',
        version = '*',
        dependencies = {
            'SmiteshP/nvim-navic',
            'nvim-tree/nvim-web-devicons',
        },
        event = 'VeryLazy',
        config = function()
            vim.opt.updatetime = 200

            require('barbecue').setup({
                create_autocmd = false,
                show_dirname = false,
                show_basename = true,
                show_modified = true,
            })

            vim.api.nvim_create_autocmd({
                'WinScrolled',
                'BufWinEnter',
                'CursorHold',
                'InsertLeave',
                'BufModifiedSet',
            }, {
                group = vim.api.nvim_create_augroup('barbecue.updater', {}),
                callback = function()
                    require('barbecue.ui').update()
                end,
            })
        end
    },
}
-----------------------------------------------------------------
