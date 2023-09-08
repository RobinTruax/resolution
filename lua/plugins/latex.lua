--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computation math.

This file installs and configures plugins key for LaTeX: vimtex and magma.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

return {

    --------------------- vimtex: the best tex plugin there is ---------------------

    {
        'lervag/vimtex',

        -- configuration
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

    ---------------------- magma-nvim: computational backend -----------------------

    {
        'dccsillag/magma-nvim',
        version = "*",
        event = 'VeryLazy',

        -- configuration
        config = function()
            vim.g.magma_image_provider = 'none'
        end
    },

    --------------------------------------------------------------------------------

    -- {
        -- 'petRUShka/vim-gap',
    -- },

    {
        'barrett-ruth/live-server.nvim',
        build = 'yarn global add live-server',
        config = true
    }
}

-----------------------------------------------------------------
