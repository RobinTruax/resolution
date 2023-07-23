return {
    "epwalsh/obsidian.nvim",
    lazy = true,
    event = { "BufReadPre " .. vim.fn.expand("~") .. "/Obsidian/**.md" },
    keys = {
        {
            '<leader>O',
            function()
                vim.cmd('cd ' .. vim.fn.expand('~') .. '/Obsidian')
                local opts = {}
                -- opts.cwd = vim.fn.expand('~') .. '/Obsidian/'
                opts.file_ignore_patterns = { 'Utility' }
                require('telescope.builtin').find_files(opts)
            end,
            desc = 'Obsidian'
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
        "godlygeek/tabular",
        "preservim/vim-markdown",
    },
    opts = {
        dir = "~/Obsidian",
        log_level = vim.log.levels.DEBUG,
        daily_notes = {
            folder = "Daily",
            date_format = "%Y-%m-%d"
        },

        completion = {
            nvim_cmp = true,
            min_chars = 2,
            new_notes_location = "current_dir"
        },

        disable_frontmatter = false,

        templates = {
            subdir = "Utility",
            date_format = "%Y-%m-%d-%a",
            time_format = "%H:%M",
        },

        follow_url_func = function(url)
            vim.fn.jobstart({ "xdg-open", url }) -- linux
        end,

        use_advanced_uri = true,
        open_app_foreground = false,
        finder = "telescope.nvim",
    },
    config = function(_, opts)
        vim.g.vim_markdown_folding_disabled = 1
        require("obsidian").setup(opts)
        vim.keymap.set("n", "gf", function()
            if require("obsidian").util.cursor_on_markdown_link() then
                return "<cmd>ObsidianFollowLink<CR>"
            else
                return "gf"
            end
        end, { noremap = false, expr = true })
    end,
}
