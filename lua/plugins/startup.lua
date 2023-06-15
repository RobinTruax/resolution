return {
    {
        'startup-nvim/startup.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local vertical_content = function(text, proportion)
                local height = math.floor(vim.o.lines * proportion) - #text
                if height < 0 then
                    height = 0
                end

                local finished_text = {}
                for i = 1, height, 1 do
                    finished_text[i] = ''
                end

                for i, v in ipairs(text) do
                    finished_text[height + i] = v
                end

                return finished_text
            end

            local b_ul = '┌' and require('config.aesthetics').ui_sharp or '╭'
            local b_ur = '┐' and require('config.aesthetics').ui_sharp or '╮'
            local b_bl = '└' and require('config.aesthetics').ui_sharp or '╰'
            local b_br = '┘' and require('config.aesthetics').ui_sharp or '╯'

            local header = {
                '',
                b_ul..'──────────── ∘°❉°∘ ───────────'..b_ur,
                '│                              │',
                '│     ｒｅｓｏｌｕｔｉｏｎ     │',
                '│          ｖ０.１.０          │',
                '│                              │',
                b_bl..'──────────── °∘❉∘° ───────────'..b_br,
            }
            local center = {
                '',
                'ｂｙ ｒｏｂｉｎ',
            }
            local footer = {
                '',
                b_ul..'───────────────────────'..b_ur,
                '│ ｐｒｅｓｓ ｓｐａｃｅ │',
                b_bl..'───────────────────────'..b_br,
            }

            require('startup').setup({
                header = {
                    type = 'text',
                    align = 'center',
                    margin = 0,
                    content = vertical_content(header, 0.25),
                    highlight = 'StartupHeader'
                },
                center = {
                    type = 'text',
                    align = 'center',
                    margin = 0,
                    content = vertical_content(center, 0.05),
                    highlight = 'StartupCenter'
                },
                footer = {
                    type = 'text',
                    align = 'center',
                    margin = 0,
                    content = vertical_content(footer, 0.6),
                    highlight = 'StartupFooter'
                },
                extra = {
                    type = 'text',
                    align = 'center',
                    margin = 0,
                    content = vertical_content(footer, 1),
                    highlight = 'Normal'
                },
                options = {
                    cursor_column = 0.5,
                    disable_statuslines = true,
                    paddings = {0,0,0,0},
                },
                parts = { 'header', 'center', 'footer', 'extra', },
            })
        end
    },

    -- lualine.nvim: status line
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            local section_separators = {}
            if require('config.aesthetics').ui_sharp == true then
                section_separators = { left = '', right = '' }
            else
                section_separators = { left = '', right = '' }
            end

            require('lualine').setup({
                options = {
                    icons_enabled = true,
                    section_separators = section_separators,
                    component_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = { 'startup', 'TelescopePrompt', 'toggleterm' },
                        winbar = { 'startup', 'TelescopePrompt', 'toggleterm' },
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

    -- bufferline.nvim: buffer line
    {
        'akinsho/bufferline.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = { 'BufReadPost', 'BufNewFile' },
        -- cmd = 'Telescope',
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
        end
    },
}
