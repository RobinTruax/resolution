--[[
resolution v0.1.0
this file is used to configure various color assignments
--]]

local colors = {}
local aesthetics = require('config.aesthetics')

-- this list configures the behavior of various colorschemes in resolution in 2 ways:
-- the names of the light and dark versions of the colorscheme
-- any colors which need to be specifically set (can be new or inherited)
-- see below for examples.

colors.util_colors = {
    tokyonight = {
        dark = {
        },
        light = {
        }
    }
}

colors.colorscheme_config = {
    tokyonight = {
        light   = 'tokyonight-day',
        dark    = 'tokyonight-moon',
        always  = {
            dark = {
                StartupHeader = { fg = '#65bcff' },
                StartupCenter = { fg = '#636da6' },
            },
            light = {
                StartupHeader = { fg = '#2e7de9' },
                StartupCenter = { fg = '#848cb5' },
            },
        },
        options = {
            ui_borderless = {
                dark = {
                    TelescopeNormal         = { bg = '#1F2335' },
                    TelescopeBorder         = { fg = '#1F2335', bg = '#1F2335' },
                    TelescopeSelection      = { bg = '#2d3149' },
                    TelescopeSelectionCaret = { fg = '#1F2335', bg = '#1F2335' },
                    TelescopeMatching       = { fg = '#65bcff' },
                    TelescopePromptNormal   = { bg = '#2d3149' },
                    TelescopePromptTitle    = { fg = '#2d3149', bg = '#65bcff' },
                    TelescopePromptPrefix   = { fg = '#65bcff', bg = '#2d3149' },
                    TelescopePromptBorder   = { fg = '#2d3149', bg = '#2d3149' },
                    TelescopePreviewTitle   = { fg = '#1F2335', bg = '#1F2335' },
                    TelescopePreviewBorder  = { fg = '#1F2335', bg = '#1F2335' },
                    TelescopeResultsTitle   = { fg = '#1F2335', bg = '#1F2335' },
                    TelescopeResultsBorder  = { fg = '#1F2335', bg = '#1F2335' },
                },
                light = {
                    TelescopeNormal         = { bg = '#e9e9ec' },
                    TelescopeBorder         = { fg = '#e9e9ec', bg = '#e9e9ec' },
                    TelescopeSelection      = { bg = '#d2d1d6' },
                    TelescopeSelectionCaret = { fg = '#e9e9ec', bg = '#e9e9ec' },
                    TelescopeMatching       = { fg = '#34548a' },
                    TelescopePromptNormal   = { bg = '#d2d1d6' },
                    TelescopePromptTitle    = { fg = '#d2d1d6', bg = '#34548a' },
                    TelescopePromptPrefix   = { fg = '#34548a', bg = '#d2d1d6' },
                    TelescopePromptBorder   = { fg = '#d2d1d6', bg = '#d2d1d6' },
                    TelescopePreviewTitle   = { fg = '#e9e9ec', bg = '#e9e9ec' },
                    TelescopePreviewBorder  = { fg = '#e9e9ec', bg = '#e9e9ec' },
                    TelescopeResultsTitle   = { fg = '#e9e9ec', bg = '#e9e9ec' },
                    TelescopeResultsBorder  = { fg = '#e9e9ec', bg = '#e9e9ec' },
                }
            }
        }
    },
    --             -- #2d353b
    --             -- #859289
    --             -- #e69875
}

-- function for setting a colorscheme properly
colors.set_colorscheme = function(scheme, mode)
    -- first set mode
    vim.o.background = mode
    if colors.colorscheme_config[scheme] ~= nil then
        -- then set colorscheme
        local scheme_name = colors.colorscheme_config[scheme][mode]
        vim.cmd('colorscheme ' .. scheme_name)

        -- then customize colorscheme, first with options always triggered
        for k, v in pairs(colors.colorscheme_config[scheme].always[mode]) do
            vim.api.nvim_set_hl(0, k, v)
        end

        for k,v in pairs(colors.colorscheme_config[scheme].options) do
            if aesthetics[k] == true then
                for l, w in pairs(v[mode]) do
                    vim.api.nvim_set_hl(0, l, w)
                end
            end
        end
    else
        vim.cmd('colorscheme ' .. scheme)
    end
end

return colors
