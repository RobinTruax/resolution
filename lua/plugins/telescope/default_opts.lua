--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file provides the default options for telescope.nvim

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
    path_display = { truncate = 0 },
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    prompt_prefix = '  ',
    selection_caret = '  ',
    layout_config = {
        anchor = 's',
        height = 0.5,
        width = 1000,
        prompt_position = 'top',
        preview_cutoff = 0,
        preview_width = 0.5,
    },
}

--------------------------------------------------------------------------------
