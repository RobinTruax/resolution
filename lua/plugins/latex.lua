--[[------------------- resolution v0.1.0 -----------------------

vimtex configuration

---------------------------------------------------------------]]

return {
    ------------- vimtex: the best tex plugin there is --------------
    {
        'lervag/vimtex',
        config = function()
            -- Vimtex settings
            vim.g.tex_flavor = 'latex'
            vim.g.tex_fast = 'bMpr'
            vim.g.tex_conceal = ''
            vim.g.vimtex_enabled = 1
            vim.o.conceallevel = 0
            vim.g.vimtex_indent_enabled = 0
            vim.g.vimtex_matchparen_enabled = 0
            vim.g.vimtex_imaps_enabled = 0

            -- Configure compiler
            vim.g.vimtex_compiler_method = 'latexmk'
            vim.g.vimtex_compiler_latexmk = {
                aux_dir = 'aux',
                callback = 1,
                continuous = 1,
                executable = 'latexmk',
                options = {
                    '-shell-escape',
                    '-verbose',
                    '-file-line-error',
                    '-synctex=1',
                    '-interaction=nonstopmode',
                    '-emulate-aux-dir',
                    '-auxdir="aux"',
                    '-outdir=""',
                },
            }
        end,
    },


    -- {
    --     "hkupty/iron.nvim",
    --     config = function()
    --         local iron = require "iron.core"
    --         iron.setup({
    --             config = {
    --                 scratch_repl = true,
    --                 repl_definition = {
    --                     python = {
    --                         command = { "ptpython" },
    --                         format = require("iron.fts.common").bracketed_paste,
    --                     },
    --                 },
    --                 repl_open_cmd = "vertical botright 50 split",
    --             },
    --             keymaps = {
    --                 send_motion = "<leader>r",
    --                 visual_send = "<leader>r",
    --             },
    --         })
    --     end,
    -- },
    -- ------------ magma-nvim-goose: computational backend ------------
    -- {
    --     "GCBallesteros/NotebookNavigator.nvim",
    --     keys = {
    --         { "]h",        function() require("notebook-navigator").move_cell "d" end },
    --         { "[h",        function() require("notebook-navigator").move_cell "u" end },
    --         { "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
    --         { "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
    --     },
    --     dependencies = {
    --         "echasnovski/mini.comment",
    --         "echasnovski/mini.ai",
    --         "hkupty/iron.nvim",
    --         "anuvyklack/hydra.nvim",
    --     },
    --     event = "VeryLazy",
    --     config = function()
    --         local nn = require "notebook-navigator"
    --         nn.setup({ activate_hydra_keys = "<leader>C" })
    --     end,
    -- }
    {
        'dccsillag/magma-nvim',
        version = "*",
        event = 'VeryLazy',
        'WhiteBlackGoose/magma-nvim-goose'
        -- keys = {
        --     {
        --         "<leader>mi",
        --         "<cmd>MagmaInit<CR>",
        --         desc =
        --         "This command initializes a runtime for the current buffer."
        --     },
        --     { "<leader>mo", "<cmd>MagmaEvaluateOperator<CR>", desc = "Evaluate the text given by some operator." },
        --     { "<leader>ml", "<cmd>MagmaEvaluateLine<CR>",     desc = "Evaluate the current line." },
        --     { "<leader>mv", "<cmd>MagmaEvaluateVisual<CR>",   desc = "Evaluate the selected text." },
        --     { "<leader>mc", "<cmd>MagmaEvaluateOperator<CR>", desc = "Reevaluate the currently selected cell." },
        --     { "<leader>mr", "<cmd>MagmaRestart!<CR>",         desc = "Shuts down and restarts the current kernel." },
        --     {
        --         "<leader>mx",
        --         "<cmd>MagmaInterrupt<CR>",
        --         desc = "Interrupts the currently running cell and does nothing if not cell is running.",
        --     },
        -- },
    },
}

-----------------------------------------------------------------
