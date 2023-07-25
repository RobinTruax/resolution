--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file includes and configures a few pretty colorschemes for basic use.

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

    ---------------------------------- tokyonight ----------------------------------

    {
        'folke/tokyonight.nvim',
        lazy = true,
    },

    ----------------------------------- gruvbox ------------------------------------

    {
        'sainnhe/gruvbox-material',
        lazy = true,
    },

    ---------------------------------- everforest ----------------------------------

    {
        'sainnhe/everforest',
        lazy = true,
    },

    --------------------------------- nvim-tundra ----------------------------------

    {
        'sam4llis/nvim-tundra',
        lazy = true,

        -- configuration
        opts = {},
    },

}

--------------------------------------------------------------------------------
