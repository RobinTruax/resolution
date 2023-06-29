--[[------------------- resolution v0.1.0 -----------------------

telescope and its many extensions

-------------------------------------------------------------]]

-- fzf native telescope; can only be built on unix systems
local fzf = {}
if vim.g.windows == false then
    fzf = {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        lazy = true,
    }
end

return {

    ------ telescope-fzf-native.nvim: fzf syntax/faster search ------
    fzf,

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
            -- set up telescope
            require('telescope').setup({
                defaults = require('plugins.telescope.default_opts'),
                pickers = require('plugins.telescope.picker_opts')
            })

            -- eliminate a gap in telescope's positioning
            require('plugins.telescope.fix_anchor')

            -- enable wrapping and disable numbering in preview windows
            vim.api.nvim_create_autocmd('User', {
                pattern = 'TelescopePreviewerLoaded',
                callback = function()
                    vim.wo.wrap = true
                    vim.wo.number = false
                end,
            })

            -- extensions
            if vim.g.windows == true then
                require('telescope').load_extension('fzf')
            end
            require('telescope').load_extension('neoclip')
            require('telescope').load_extension('undo')
        end,
    },
}

-----------------------------------------------------------------
