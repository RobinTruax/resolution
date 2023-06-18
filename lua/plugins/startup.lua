--[[------------------- resolution v0.1.0 -----------------------

all ui elements which run on startup

-------------------------------------------------------------]]--

return {
----------------- mini.starter: startup screen ------------------
    {
        'echasnovski/mini.starter',
        version = '*',

        dependencies = {'nvim-lualine/lualine.nvim', 'akinsho/bufferline.nvim' },

        config = function()
            local prefs = require('config.preferences')
            local starter = require('mini.starter')

            local recent_files = function(n)
                return function()
                    local section = ('recent files')

                    local files = vim.tbl_filter(function(f) return vim.fn.filereadable(f) == 1 end, vim.v.oldfiles or {})

                    if #files == 0 then return { { name = 'none', action = '', section = section } } end

                    local items = {}
                    local fmodify = vim.fn.fnamemodify

                    for _, f in ipairs(vim.list_slice(files, 1, n)) do
                        local path = (' (%s/%s)'):format(fmodify(f, ':p:h:h:t'), fmodify(f, ':p:h:t'))
                        local name = ('%s%s'):format(fmodify(f, ':t'), path)
                        table.insert(items,
                            { action = ('cd %s | edit %s'):format(fmodify(f, ':p:h'), fmodify(f, ':p')), name = name, section = section })
                    end

                    return items
                end
            end

            config = {
                evaluate_single = true,
                silent = true,
                header = 'resolution',
                query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_-. ',
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
                            name = 'configure rsltn',
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
 
            starter.setup(config)
        end
    },

------------------- lualine.nvim: status line -------------------
    {
        'nvim-lualine/lualine.nvim',

        event = { 'BufReadPost', 'BufNewFile' },

        dependencies = { 'nvim-tree/nvim-web-devicons' },

        config = function()
            local section_separators = {}
            if require('config.aesthetics').ui_sharp == true then
                section_separators = { left = '', right = '' }
            else
                section_separators = { left = '', right = '' }
            end

            require('lualine').setup({
                options = {
                    theme = 'auto',
                    icons_enabled = true,
                    section_separators = section_separators,
                    component_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = { 'starter' },
                        winbar = { 'starter', 'toggleterm' },
                    },
                    always_divide_middle = true,
                    globalstatus = true,
                    refresh = {
                        statusline = 1000,
                    },
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'os.date("%d %b")' },
                    lualine_y = { 'os.date("%H:%M")' },
                    lualine_z = { 'searchcount', 'location' },
                },
                -- winbar = {
                -- lualine_c = {
                --     'navic',
                --     color_correction = nil,
                --     navic_opts = nil
                -- }
                -- },
            })
        end
    },

----------------- bufferline.nvim: buffer line ------------------
    {
        'akinsho/bufferline.nvim',

        event = { 'BufReadPost', 'BufNewFile' },

        dependencies = { 'nvim-tree/nvim-web-devicons' },

        config = function()
            require('bufferline').setup({
                options = {
                    always_show_bufferline = false,
                    offsets = {
                        {
                            filetype = 'neo-tree',
                            highlight = 'Directory',
                            separator = true
                        }
                    }
                },
            })

            vim.keymap.set('n', '<C-Left>', '<Esc>:BufferLineCyclePrev<cr>', { silent = true, desc = 'Previous buffer' })
            vim.keymap.set('n', '<C-Right>', '<Esc>:BufferLineCycleNext<cr>', { silent = true, desc = 'Next buffer' })
            vim.keymap.set('n', '<C-S-Left>', '<Esc>:BufferLineMovePrev<cr>',
                { silent = true, desc = 'Move buffer to previous' })
            vim.keymap.set('n', '<C-S-Right>', '<Esc>:BufferLineMoveNext<cr>',
                { silent = true, desc = 'Move buffer to next' })
        end
    },
}

-----------------------------------------------------------------
