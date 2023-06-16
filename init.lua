--[[
resolution v0.1.0
this file runs on startup
there is usually no reason to modify it
--]]

-- preferences
require('config.preferences')

-- set up plugins
require('core.plugins')

-- set up keybinds
require('core.maps')

-- set autocmds
require('core.autocmds')

-- miscellaneous
require('core.misc')

-- set any lingering neovim options
require('core.execute-config')
