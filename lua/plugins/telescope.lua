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

    ------------------------ telescope.nvim -------------------------
    {
        'nvim-telescope/telescope.nvim',
        event = 'VeryLazy',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
            'BurntSushi/ripgrep',
            'AckslD/nvim-neoclip.lua',
            'debugloop/telescope-undo.nvim',
        },

        config = function()
            require('telescope').setup({
                defaults = require('plugins.telescope.default_opts'),
                pickers = require('plugins.telescope.picker_opts')
            })

            -- overwrite to fix placement
            require('plugins.telescope.fix_anchor')

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
