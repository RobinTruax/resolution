--[[
resolution v0.1.0
this file runs on startup; there is usually no reason to modify it
--]]



-- set up keybinds for rsltn's main operations
require('core.maps-leader')

-- set up other keybinds
require('core.maps-other')

-- set all vim options
require('config.vimopts')

-- set autocmds
require('config.autocmds')
