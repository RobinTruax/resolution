--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

Execute all configuration options which need to be called.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

--------------------------------- dependencies ---------------------------------

local preferences = require('config.preferences')
local aesthetics = require('config.aesthetics')

------------------------------- set colorscheme --------------------------------

require('core.colors').set_colorscheme(
    aesthetics.default_colorscheme,
    aesthetics.default_mode
)

------------------------- set nonconfigurable options --------------------------

vim.o.showtabline = 0
vim.o.laststatus = 3

--------------------------------------------------------------------------------
