--[[------------------- resolution v0.1.0 -----------------------

this file provides the layout necessary for the pop-up.

---------------------------------------------------------------]]

local popup = {}

------------------------- dependencies --------------------------

-- configuration
local config_computation = require('config.advanced.computation')

-- nui.nvim
local Popup = require('nui.popup')
local Layout = require('nui.layout')
local NuiText = require('nui.text')
local Event = require('nui.utils.autocmd').event

-- plenary.nvim
local Job = require('plenary.job')

----------------- individual windows for popup ------------------

-- window for LaTeX input
popup.input_tex = Popup({
    enter = true,
    border = {
        style = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        text = {
            top = NuiText(' TeX ', 'SpecialChar'),
            bottom = NuiText(' tab: move ', 'SpecialChar')
        },
    },
    win_options = {
        winhighlight = 'Normal:Normal, FloatBorder:SpecialChar',
    },
})

-- window for sympy input
popup.sympy = Popup({
    border = {
        style = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        text = {
            top = NuiText(' SymPy ', 'SpecialChar'),
            bottom = NuiText(' \\s, \\S: send ', 'SpecialChar')
        },
    },
    focusable = true,
    win_options = {
        winhighlight = 'Normal:Normal, FloatBorder:SpecialChar',
    },
})

-- window for LaTeX output
popup.output_tex = Popup({
    border = {
        style = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        text = {
            top = NuiText(' Output ', 'CommandMode'),
            bottom = NuiText(' q: quit, \\y: yank/quit ', 'CommandMode')
        },
    },
    focusable = true,
    win_options = {
        winhighlight = 'Normal:Normal,FloatBorder:CommandMode',
        wrap = false,
    },
})

----------------- layout of individual windows ------------------

-- collection of all windows for iteration
popup.all = {
    popup.input_tex,
    popup.sympy,
    popup.output_tex,
}

-- layout which organizes the windows
popup.layout = Layout(
    {
        relative = config_computation.window_parameters.relative,
        position = {
            row = 1,
            col = -2
        },
        anchor = 'NW',
        size = config_computation.window_parameters.size
    },
    Layout.Box({
        Layout.Box({
            Layout.Box(popup.input_tex, { size = '50%' }),
            Layout.Box(popup.sympy, { size = '50%' }),
        }, { dir = 'row', size = '50%' }),
        Layout.Box(popup.output_tex, { size = '50%' })
    }, { dir = 'col' })
)

-----------------------------------------------------------------

return popup

-----------------------------------------------------------------
