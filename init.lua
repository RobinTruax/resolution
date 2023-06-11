--[[
resolution v0.1.0
this file runs on startup; there is usually no reason to modify it
--]]

-- set neovim options
require('config.preferences')

-- set up plugins
require('core.plugins')

-- set up keybinds main operations
require('core.maps-leader')

-- set up other keybinds
require('core.maps-other')

-- set autocmds
require('core.autocmds')
