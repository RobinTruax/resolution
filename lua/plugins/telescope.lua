-- configuration for telescope
return {
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        lazy = true,
    },

    -- telescope.nvim
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'BurntSushi/ripgrep',
            'nvim-telescope/telescope-fzf-native.nvim',
        },
        cmd = 'Telescope',

        -- configuration and ui standardization
        config = function()
            -- basic setup
            require('telescope').setup({
                defaults = {
                    path_display = {truncate = 0},
                    layout_strategy = 'horizontal',
                    prompt_prefix = '  ',
                    selection_caret = '  ',
                    layout_config = {
                        anchor = 's',
                        height = 0.5,
                        width = 0.9999,
                        prompt_position = 'top',
                        preview_cutoff = 0,
                        preview_width = 0.5,
                    },
                },
            })

            -- proper placement
            local resolve = require('telescope.config.resolve')
            resolve.resolve_anchor_pos = function(anchor, p_width, p_height, max_columns, max_lines)
                anchor = anchor:upper()
                local pos = { 0, 0 }
                if anchor == "CENTER" then
                    return pos
                end
                if anchor:find "W" then
                    pos[1] = math.ceil((p_width - max_columns) / 2) + 1
                elseif anchor:find "E" then
                    pos[1] = math.ceil((max_columns - p_width) / 2) - 1
                end
                if anchor:find "N" then
                    pos[2] = math.ceil((p_height - max_lines) / 2) + 1
                elseif anchor:find "S" then
                    pos[2] = math.ceil((max_lines - p_height) / 2)
                end
                return pos
            end

            -- wrapping
            vim.api.nvim_create_autocmd("User", {
                pattern = "TelescopePreviewerLoaded",
                callback = function(args)
                    vim.wo.wrap = true
                    vim.wo.number = true
                end,
            })

            -- colors
            local TelescopePrompt = {
                TelescopeNormal = {
                    bg = '#1F2335',
                },
                TelescopeBorder = {
                    fg = '#1F2335',
                    bg = '#1F2335',
                },
                TelescopeSelection = {
                    bg = '#2d3149',
                },
                TelescopeSelectionCaret = {
                    fg = '#1F2335',
                    bg = '#1F2335',
                },
                TelescopeMatching = {
                    fg = '#7aa2f7',
                },
                TelescopePromptNormal = {
                    bg = '#2d3149',
                },
                TelescopePromptTitle = {
                    fg = '#2d3149',
                    bg = '#7aa2f7',
                },
                TelescopePromptPrefix = {
                    fg = '#7aa2f7',
                    bg = '#2d3149',
                },
                TelescopePromptBorder = {
                    fg = '#2d3149',
                    bg = '#2d3149',
                },
                TelescopePreviewTitle = {
                    fg = '#1F2335',
                    bg = '#1F2335',
                },
                TelescopePreviewBorder = {
                    fg = '#1F2335',
                    bg = '#1F2335',
                },
                TelescopeResultsTitle = {
                    fg = '#1F2335',
                    bg = '#1F2335',
                },
                TelescopeResultsBorder = {
                    fg = '#1F2335',
                    bg = '#1F2335',
                },
            }
            for hl, col in pairs(TelescopePrompt) do
                vim.api.nvim_set_hl(0, hl, col)
            end
        end,
    },
}
