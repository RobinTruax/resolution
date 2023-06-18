--[[------------------- resolution v0.1.0 -----------------------

configuration for all colorscheme assignments
this includes specially assigned colors for rsltn

-------------------------------------------------------------]]--

local colorschemes = {}

------------------------- colorscheme options -------------------------

vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_foreground = 'mix'

------------------------- basic palette -------------------------

colorschemes.universal_palette = {
    tokyonight = {
        dark = {
            bg = '#222436',
            ui_normal = '#1F2335',
            ui_special = '#2D3149',
            ui_emphasized_text = '#65BCFF',
        },
        light = {
            bg = '#E1E2E7',
            ui_normal = '#E9E9EC',
            ui_special = '#D2D1D6',
            ui_emphasized_text = '#34548A',
        }
    },
    gruvbox = {
        dark = {
            bg = '#282828',
            ui_normal = '#1b1b1b',
            ui_special = '#32302f',
            ui_emphasized_text = '#b0b846',
        },
        light = {
            bg = '#fbf1c7',
            ui_normal = '#eee0b7',
            ui_special = '#ddccab',
            ui_emphasized_text = '#6f8352',
        },
    },
    everforest = {
        dark = {
            bg = '#2D353B',
            ui_normal = '#232A2E',
            ui_special = '#343F44',
            ui_emphasized_text = '#A7C080',
        },
        light = {
            bg = '#FDF6E3',
            ui_normal = '#EFEBD4',
            ui_special = '#E6E2CC',
            ui_emphasized_text = '#8DA101',
        },
    }
}

------------------- universal configurations --------------------

colorschemes.universal_config = {
    always = {
        MiniStarterItemBullet = { fg = 'bg', bg = 'bg' },
    },
    optional = {
        ui_borderless = {
            TelescopeNormal        = { bg = 'ui_normal' },
            TelescopeBorder        = { fg = 'ui_normal', bg = 'ui_normal' },
            TelescopeSelection     = { bg = 'ui_special' },
            TelescopePromptNormal  = { bg = 'ui_special' },
            TelescopePromptTitle   = { fg = 'ui_normal', bg = 'ui_emphasized_text' },
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
        dark = 'tokyonight-moon',
        light = 'tokyonight-day',
        always = {
            dark = {
                MiniStarterHeader = {fg = '#65BCFF', bold = true},
                MiniStarterSection = { fg = '#82aaff', bold = true },
                MiniStarterFooter = { fg = '#c099ff', italic = true},
                MiniStarterItemPrefix = { fg = '#c3e88d' },
                MiniStarterQuery = { fg = '#4fd6be' },
                NormalMode    = { fg = '#82aaff' },
                InsertMode    = { fg = '#c3e88d' },
                VisualMode    = { fg = '#c099ff' },
                CommandMode   = { fg = '#ffc777' },
                ReplaceMode   = { fg = '#ff757f' },
                TerminalMode  = { fg = '#4fd6be' },
                SelectMode    = { fg = '#c099ff' },
            },
            light = {
                MiniStarterHeader = {fg = '#34548A', bold = true},
                MiniStarterSection = { fg = '#2e7de9', bold = true },
                MiniStarterFooter = { fg = '#118c74', italic = true},
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
    gruvbox = {
        dark = 'gruvbox-material',
        light = 'gruvbox-material',
        always = {
            dark = {},
            light = {}
        },
        optional = {}
    },
    everforest = {
        dark = 'everforest',
        light = 'everforest',
        always = {
            dark = {
                MiniStarterHeader     = { fg = '#83c092', bold   = true },
                MiniStarterFooter     = { fg = '#83c092', italic = true },
                MiniStarterSection    = { fg = '#a7c080', bold   = true },
                MiniStarterItemPrefix = { fg = '#d699b6' },
                MiniStarterQuery      = { fg = '#e67e80' },
                NormalMode            = { fg = '#a7c080' },
                InsertMode            = { fg = '#d3c6aa' },
                VisualMode            = { fg = '#e67e80' },
                CommandMode           = { fg = '#83c092' },
                ReplaceMode           = { fg = '#e69875' },
                TerminalMode          = { fg = '#d699b6' },
                SelectMode            = { fg = '#a7c080' },
            },
            light = {
                MiniStarterHeader     = { fg = '#35a77c', bold   = true },
                MiniStarterFooter     = { fg = '#35a77c', italic = true },
                MiniStarterSection    = { fg = '#8da101', bold   = true },
                MiniStarterItemPrefix = { fg = '#df69ba' },
                MiniStarterQuery      = { fg = '#f85552' },
                NormalMode            = { fg = '#93b259' },
                InsertMode            = { fg = '#708089' },
                VisualMode            = { fg = '#e66868' },
                CommandMode           = { fg = '#35a77c' },
                ReplaceMode           = { fg = '#f67d26' },
                TerminalMode          = { fg = '#df69ba' },
                SelectMode            = { fg = '#93b259' },
            }
        },
        optional = {}
    }
    -- #2d353b
    -- #859289
    -- #e69875
}

-----------------------------------------------------------------

return colorschemes

-----------------------------------------------------------------
