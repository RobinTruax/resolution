return {
    -- tokyonight
    {
        'folke/tokyonight.nvim',
        lazy = false,
	priority = 1000,
	config = function()
	    vim.cmd('colorscheme tokyonight-moon')
	end
    },
    -- gruvbox
    {
        'morhetz/gruvbox',
        lazy = true,
    },
    -- nord
    {
        'shaunsingh/nord.nvim',
        lazy = true,
    },
    -- polar
    {
        'mtyn/polar',
        lazy = true,
    },
    -- everforest
    {
        'sainnhe/everforest',
        lazy = true,
    },
    -- kanagawa
    {
        'rebelot/kanagawa.nvim',
        lazy = true,
    },
    -- catppuccin
    {
        'catppuccin/nvim',
        lazy = true,
    },
}
