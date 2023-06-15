return {
    -- toggleterm.nvim: a better terminal
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        cmd = 'ToggleTerm',
        config = true,
    },

    -- neo-tree.nvim: file explorer
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
        cmd = 'Neotree',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
    },

    -- lazygit.nvim: git integration
    {
        "kdheepak/lazygit.nvim",
        cmd = 'LazyGit',
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },

    -- nvim-spectre: search/replace across multiple files
    {
        'nvim-pack/nvim-spectre',
        cmd = 'Spectre',
        config = function()
            require('spectre').setup()
        end,
    },

    -- which-key.nvim: keybind-based menus
    {
        'folke/which-key.nvim',
        keys = '<Space>',
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            vim.o.timeout = true
            local border = require('config.aesthetics').ui_borderless and 'none' or 'single'
            require('which-key').setup({
                window = {
                    border = border,
                    margin = {1, 0, 0, 0},
                },
                triggers_nowait = {},
            })
        end,
    },
}
