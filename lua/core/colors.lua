--[[
resolution v0.1.0
this file is used to configure various color assignments
--]]

local colors = {}
local aesthetics = require('config.aesthetics')

colors.util_colors = {
    tokyonight = {
        dark = {
            tel_nrm = '#1F2335',
            tel_emp = '#2D3149',
            tel_spc = '#65BCFF',
        },
        light = {
            tel_nrm = '#e9e9ec',
            tel_emp = '#d2d1d6',
            tel_spc = '#34548a',
        }
    }
}

colors.get_telescope_colors = function(scheme, mode)
    return {
        TelescopeNormal        = { bg = colors.util_colors[scheme][mode].tel_nrm },
        TelescopeBorder        = { fg = colors.util_colors[scheme][mode].tel_nrm, bg = colors.util_colors[scheme][mode].tel_nrm },
        TelescopeSelection     = { bg = colors.util_colors[scheme][mode].tel_emp },
        TelescopePromptNormal  = { bg = colors.util_colors[scheme][mode].tel_emp },
        TelescopePromptTitle   = { fg = colors.util_colors[scheme][mode].tel_emp, bg = colors.util_colors[scheme][mode].tel_spc },
        TelescopePromptPrefix  = { fg = colors.util_colors[scheme][mode].tel_spc, bg = colors.util_colors[scheme][mode].tel_emp },
        TelescopePromptBorder  = { fg = colors.util_colors[scheme][mode].tel_emp, bg = colors.util_colors[scheme][mode].tel_emp },
        TelescopePreviewTitle  = { fg = colors.util_colors[scheme][mode].tel_nrm, bg = colors.util_colors[scheme][mode].tel_nrm },
        TelescopePreviewBorder = { fg = colors.util_colors[scheme][mode].tel_nrm, bg = colors.util_colors[scheme][mode].tel_nrm },
        TelescopeResultsTitle  = { fg = colors.util_colors[scheme][mode].tel_nrm, bg = colors.util_colors[scheme][mode].tel_nrm },
        TelescopeResultsBorder = { fg = colors.util_colors[scheme][mode].tel_nrm, bg = colors.util_colors[scheme][mode].tel_nrm },
    }
end

-- this list configures the behavior of various colorschemes in resolution in 2 ways:
-- the names of the light and dark versions of the colorscheme
-- any colors which need to be specifically set (can be new or inherited)
-- see below for examples.
colors.colorscheme_config = {
    tokyonight = {
        light   = 'tokyonight-day',
        dark    = 'tokyonight-moon',
        always  = {
            dark = {
                StartupHeader = { fg = '#65bcff' },
                StartupCenter = { fg = '#636da6' },
                StartupFooter = { fg = '#4fd6be' },
                NormalMode    = { fg = '#82aaff' },
                InsertMode    = { fg = '#c3e88d' },
                VisualMode    = { fg = '#c099ff' },
                CommandMode   = { fg = '#ffc777' },
                ReplaceMode   = { fg = '#ff757f' },
                TerminalMode  = { fg = '#4fd6be' },
                SelectMode    = { fg = '#c099ff' },
            },
            light = {
                StartupHeader = { fg = '#2e7de9' },
                StartupCenter = { fg = '#848cb5' },
                StartupFooter = { fg = '#188092' },
                NormalMode    = { fg = '#2e7de9' },
                InsertMode    = { fg = '#587539' },
                VisualMode    = { fg = '#9854f1' },
                CommandMode   = { fg = '#8c6c3e' },
                ReplaceMode   = { fg = '#f52a65' },
                TerminalMode  = { fg = '#118c74' },
                SelectMode    = { fg = '#2e7de9' },
            },
        },
        options = {
            ui_borderless = {
                dark = colors.get_telescope_colors('tokyonight', 'dark'),
                light = colors.get_telescope_colors('tokyonight', 'light'),
            }
        }
    },
    -- #2d353b
    -- #859289
    -- #e69875
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

        for k, v in pairs(colors.colorscheme_config[scheme].options) do
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
