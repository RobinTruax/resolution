--[[------------------- resolution v0.1.0 -----------------------

telescope and its many extensions

-------------------------------------------------------------]]

return {

    ------ telescope-fzf-native.nvim: fzf syntax/faster search ------
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        lazy = true,
    },

    ---------------- nvim-neoclip.lua: search yanks -----------------
    {
        'AckslD/nvim-neoclip.lua',
        lazy = true,
        config = true,
    },

    ----------------- auto-session: session manager -----------------
    {
        'rmagatti/auto-session',
        event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            require('auto-session').setup({
                log_level = 'error',
                auto_session_suppress_dirs = { '~/', '/' },
                auto_session_enable_last_session = false,
                auto_session_enabled = true,
                auto_session_create_enabled = true,
                auto_save_enabled = true
            })
        end
    },

    ---------------- session-lens: link to telescope ----------------
    {
        'rmagatti/session-lens',
        lazy = true,
        dependencies = { 'rmagatti/auto-session' },
        config = true
    },

    ------------------------ telescope.nvim -------------------------
    {
        'nvim-telescope/telescope.nvim',
        cmd = { 'Telescope', 'TelescopeLoad' },
        dependencies = {
            'nvim-lualine/lualine.nvim',
            'akinsho/bufferline.nvim',
            'nvim-lua/plenary.nvim',
            'BurntSushi/ripgrep',
            'nvim-telescope/telescope-fzf-native.nvim',
            'AckslD/nvim-neoclip.lua',
            'debugloop/telescope-undo.nvim',
            'rmagatti/auto-session',
        },

        config = function()
            -- command for manual loading
            vim.api.nvim_create_user_command('TelescopeLoad', '', {})

            -- basic setup
            require('telescope').setup({
                defaults = {
                    path_display = { truncate = 0 },
                    sorting_strategy = 'ascending',
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
                pickers = {
                    buffers = {
                    },
                    lsp_document_symbols = {
                        prompt_title = 'Jump in Document',
                        ignore_symbols = { 'enum', 'enummember', 'constant' },
                    },
                    lsp_workspace_symbols = {
                        prompt_title = 'Jump in Project',
                    }
                }
            })

            -- overwrite various entry makers
            require('core.menus.buffers')
            require('core.menus.lsp_symbols')

            -- fix placement
            require('core.menus.fix_anchor')

            -- wrapping
            vim.api.nvim_create_autocmd('User', {
                pattern = 'TelescopePreviewerLoaded',
                callback = function()
                    vim.wo.wrap = true
                    vim.wo.number = true
                end,
            })

            -- extensions
            require('telescope').load_extension('fzf')
            require('telescope').load_extension('neoclip')
            require('telescope').load_extension('undo')
        end,
    },
}

-----------------------------------------------------------------
