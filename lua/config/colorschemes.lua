--[[------------------- resolution v0.1.0 -----------------------

configuration for all colorscheme assignments
this includes specially assigned colors for rsltn

-------------------------------------------------------------]]--

local colorschemes = {}

------------------------- basic palette -------------------------

colorschemes.universal_palette = {
    tokyonight = {
        dark = {
            ui_normal = '#1F2335',
            ui_special = '#2D3149',
            ui_emphasized_text = '#65BCFF',
        },
        light = {
            ui_normal = '#E9E9EC',
            ui_special = '#D2D1D6',
            ui_emphasized_text = '#34548A',
        }
    },
}

------------------- universal configurations --------------------

colorschemes.universal_config = {
    always = {
    },
    optional = {
        ui_borderless = {
            TelescopeNormal        = { bg = 'ui_normal' },
            TelescopeBorder        = { fg = 'ui_normal', bg = 'ui_normal' },
            TelescopeSelection     = { bg = 'ui_special' },
            TelescopePromptNormal  = { bg = 'ui_special' },
            TelescopePromptTitle   = { fg = 'ui_special', bg = 'ui_emphasized_text' },
            TelescopePromptPrefix  = { fg = 'ui_emphasized_text', bg = 'ui_special' },
            TelescopePromptBorder  = { fg = 'ui_special', bg = 'ui_special' },
            TelescopePreviewTitle  = { fg = 'ui_normal', bg = 'ui_normal' },
            TelescopePreviewBorder = { fg = 'ui_normal', bg = 'ui_normal' },
            TelescopeResultsTitle  = { fg = 'ui_normal', bg = 'ui_normal' },
            TelescopeResultsBorder = { fg = 'ui_normal', bg = 'ui_normal' },
        }
    }
}

------------------- by-scheme configurations --------------------

colorschemes.colorscheme_configs = {
    tokyonight = {
        dark    = 'tokyonight-moon',
        light   = 'tokyonight-day',
        always  = {
            dark = {
                MiniStarterHeader = { fg = '#65bcff', bold = true },
                MiniStarterSection = { fg = '#82aaff', bold = true },
                MiniStarterFooter = { fg = '#c099ff', italic = true},
                MiniStarterItemPrefix = { fg = '#4fd6be' },
                MiniStarterQuery = { fg = '#c3e88d' },
                NormalMode    = { fg = '#82aaff' },
                InsertMode    = { fg = '#c3e88d' },
                VisualMode    = { fg = '#c099ff' },
                CommandMode   = { fg = '#ffc777' },
                ReplaceMode   = { fg = '#ff757f' },
                TerminalMode  = { fg = '#4fd6be' },
                SelectMode    = { fg = '#c099ff' },
            },
            light = {
                MiniStarterHeader = { fg = '#1a5ce9', bold = true },
                MiniStarterSection = { fg = '#2e7de9', bold = true },
                MiniStarterFooter = { fg = '#587539', italic = true},
                MiniStarterItemPrefix = { fg = '#9854f1' },
                MiniStarterQuery = { fg = '#f52a65' },
                NormalMode    = { fg = '#2e7de9' },
                InsertMode    = { fg = '#587539' },
                VisualMode    = { fg = '#9854f1' },
                CommandMode   = { fg = '#8c6c3e' },
                ReplaceMode   = { fg = '#f52a65' },
                TerminalMode  = { fg = '#118c74' },
                SelectMode    = { fg = '#2e7de9' },
            },
        },
        optional = {}
    },
    -- #2d353b
    -- #859289
    -- #e69875
}

-----------------------------------------------------------------

return colorschemes

-----------------------------------------------------------------
