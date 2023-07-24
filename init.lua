--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computation math.

This is resolution's init file; it is called on Neovim's startup.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

-- detect windows or unix and assign it to global variable
vim.g.windows = (vim.loop.os_uname().sysname == "Windows")

-- set preferences
require('config.preferences')

-- set up plugins
require('core.plugins')

-- set up keybinds
require('core.keymaps')

-- set autocmds
require('core.autocmds.all')

-- set up any specialized configuration options
require('core.config')

--------------------------------------------------------------------------------
