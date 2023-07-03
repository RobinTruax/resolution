--[[------------------- resolution v0.1.0 -----------------------

init file; nexus for all other files

-------------------------------------------------------------]]--

-- detect windows or unix
vim.g.windows = (vim.loop.os_uname().sysname == "Windows")

-- preferences
require('config.preferences')

-- set up plugins
require('core.plugins')

-- set up keybinds
require('core.keymaps')

-- set autocmds
require('core.autocmds.all')

-- set any lingering neovim options
require('core.config')
