-- preferences
local preferences = require('config.preferences')

-- aesthetics
local aesthetics = require('config.aesthetics')

require('core.colors').set_colorscheme(
    aesthetics.default_colorscheme,
    aesthetics.default_mode
)

-- other (options considered nonconfigurable)
vim.o.showtabline = 2
vim.o.laststatus = 3
