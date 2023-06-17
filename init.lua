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
require('core.keymaps')

-- set autocmds
require('core.autocmds.all')

-- set any lingering neovim options
require('core.execute-config')
