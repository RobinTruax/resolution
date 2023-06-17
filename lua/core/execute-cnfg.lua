--[[------------------- resolution v0.1.0 -----------------------

execute all configuration options which need to be called

-------------------------------------------------------------]]--

local preferences = require('config.preferences')
local aesthetics = require('config.aesthetics')

------------------------ set colorscheme ------------------------

require('core.colors').set_colorscheme(
    aesthetics.default_colorscheme,
    aesthetics.default_mode
)

------------------ set nonconfigurable options ------------------

vim.o.showtabline = 2
vim.o.laststatus = 3

-----------------------------------------------------------------
