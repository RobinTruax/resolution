--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This files contains aesthetic options (of which more may be added later).

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

local aesthetics = {}

------------------------------ aesthetic options -------------------------------

-- built-in colorschemes: tokyonight, gruvbox, everforest, tundra
aesthetics.default_colorscheme     = 'tundra'
-- built-in modes: dark or light
aesthetics.default_mode            = 'dark'

------------------------------- advanced options -------------------------------

aesthetics.configured_colorschemes = {
    'tokyonight',
    'gruvbox',
    'everforest',
    'tundra'
}

--------------------------------------------------------------------------------

return aesthetics

--------------------------------------------------------------------------------
