return {
    {
        'lervag/vimtex',
        ft = 'tex',
        config = function()
            -- Vimtex
            vim.g.tex_flavor = 'latex'
            vim.g.tex_fast = 'bMpr'
            vim.g.tex_conceal = ''
            vim.g.vimtex_enabled = 1
            vim.g.vimtex_view_sioyek_exe = '/home/roshan/Applications/Sioyek.AppImage'
            vim.g.vimtex_view_method = 'sioyek'
            vim.o.conceallevel = 0
            vim.g.vimtex_indent_enabled = 0
            vim.g.vimtex_matchparen_enabled = 0
            vim.g.vimtex_imaps_enabled = 0

            -- Ignore certain annoying warnings
            vim.g.vimtex_quickfix_ignore_filters = {
                'Underfull',
                'Overfull',
                'requested',
                "removing `math shift'",
                'bad break',
                'atopwithdelims',
            }

            -- Configure compiler
            vim.g.vimtex_compiler_method = 'latexmk'
            vim.g.vimtex_compiler_latexmk = {
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
    }
    -- {
    --     "nvim-treesitter/nvim-treesitter",
    --     config = function()
    --         local treesitter = require "nvim-treesitter.configs"
    --         treesitter.setup {
    --             highlight = {
    --                 enable = true,
    --                 additional_vim_regex_highlighting = false,
    --                 use_languagetree = false,
    --                 disable = function(_, bufnr)
    --                     local buf_name = vim.api.nvim_buf_get_name(bufnr)
    --                     local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
    --                     return file_size > 256 * 1024
    --                 end,
    --             }
    --         }
    --     end,
    --     build = function()
    --         require("nvim-treesitter.install").update({ with_sync = true })
    --     end,
    -- }
}
