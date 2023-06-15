-- configuration for telescope
return {

    -- telescope-fzf-native.nvim: fzf syntax/faster search
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        lazy = true,
    },

    -- nvim-neoclip.lua: search yanks
    {
        'AckslD/nvim-neoclip.lua',
        lazy = true,
        config = true,
    },

    -- auto-session: session manager
    {
        'rmagatti/auto-session',
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("auto-session").setup({
                log_level = "error",
                auto_session_suppress_dirs = { "~/", "/" },
                auto_session_enable_last_session = false,
                auto_session_enabled = true,
                auto_session_create_enabled = true,
                auto_save_enabled = true
            })
        end
    },
    -- session-lens: link to telescope
    {
        'rmagatti/session-lens',
        requires = { 'rmagatti/auto-session' },
        config = function()
            require('session-lens').setup({})
        end,
        lazy = true
    },

    -- telescope.nvim
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'BurntSushi/ripgrep',
            'nvim-telescope/telescope-fzf-native.nvim',
            'AckslD/nvim-neoclip.lua',
            'debugloop/telescope-undo.nvim',
            'rmagatti/auto-session',
        },
        cmd = 'Telescope',

        -- configuration and ui standardization
        config = function()
            -- basic setup
            require('telescope').setup({
                defaults = {
                    path_display = { truncate = 0 },
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

            require('telescope').load_extension('fzf')
            require('telescope').load_extension('neoclip')
            require('telescope').load_extension('undo')
        end,
    },
}
