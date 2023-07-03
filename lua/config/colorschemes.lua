--[[------------------- resolution  q0.1.0 -----------------------

configuration for all colorscheme assignments
this includes specially assigned colors for rsltn

---------------------------------------------------------------]]


local colorschemes = {}

------------------------- basic palette -------------------------

colorschemes.universal_palette = {
    bg = {
        tokyonight = { dark = '#222436', light = '#E1E2E7' },
        gruvbox    = { dark = '#282828', light = '#fbf1c7' },
        everforest = { dark = '#2D353B', light = '#FDF6E3' },
        tundra     = { dark = '#111827', light = '#111827' },
    },
    ui_normal = {
        tokyonight = { dark = '#1F2335', light = '#E9E9EC' },
        gruvbox    = { dark = '#1b1b1b', light = '#eee0b7' },
        everforest = { dark = '#232A2E', light = '#EFEBD4' },
        tundra     = { dark = '#081021', light = '#081021' },
    },
    ui_special = {
        tokyonight = { dark = '#2D3149', light = '#D2D1D6' },
        gruvbox    = { dark = '#32302f', light = '#ddccab' },
        everforest = { dark = '#343F44', light = '#E6E2CC' },
        tundra     = { dark = '#121d35', light = '#121f3a' },
    },
    ui_emph_text = {
        tokyonight = { dark = '#65BCFF', light = '#34548A' },
        gruvbox    = { dark = '#b0b846', light = '#6f8352' },
        everforest = { dark = '#A7C080', light = '#8DA101' },
        tundra     = { dark = '#fecdd3', light = '#fecdd3' },
    },
}

------------------- universal configurations --------------------

local c = colorschemes.universal_palette
colorschemes.universal_config = {
    always = {
        MiniStarterItemBullet = { fg = c.bg, bg = c.bg },
        LeapBackdrop          = { link = 'Comment' },
        LeapMatch             = { fg = '#ff007c', bold = true, nocombine = true },
        LeapLabelPrimary      = { fg = '#ff007c', bold = true, nocombine = true },
        LeapLabelSecondary    = { fg = '#4fd6be', bold = true, nocombine = true },
        CccFloatNormal        = { bg = c.bg },
        CccFloatBorder        = { link = 'SpecialChar' },
    },
    optional = {
        ui_borderless = {
            TelescopeNormal        = { bg = c.ui_normal },
            TelescopeBorder        = { fg = c.ui_normal, bg = c.ui_normal },
            TelescopeSelection     = { bg = c.ui_special },
            TelescopePromptNormal  = { bg = c.ui_special },
            TelescopePromptTitle   = { fg = c.ui_normal, bg = c.ui_emph_text },
            TelescopePromptPrefix  = { fg = c.ui_emph_text, bg = c.ui_special },
            TelescopePromptBorder  = { fg = c.ui_special, bg = c.ui_special },
            TelescopePreviewTitle  = { fg = c.ui_normal, bg = c.ui_normal },
            TelescopePreviewBorder = { fg = c.ui_normal, bg = c.ui_normal },
            TelescopeResultsTitle  = { fg = c.ui_normal, bg = c.ui_normal },
            TelescopeResultsBorder = { fg = c.ui_normal, bg = c.ui_normal },
            TelescopePromptCounter = { fg = c.ui_emph_text },
        }
    }
}
------------------- by-scheme configurations --------------------

colorschemes.colorscheme_configs = {
    -------------------------- tokyonight ---------------------------

    tokyonight = {
        dark = 'tokyonight-moon',
        light = 'tokyonight-day',
        always = {
            dark = {
                MiniStarterHeader     = { fg = '#65BCFF', bold = true },
                MiniStarterSection    = { fg = '#82aaff', bold = true },
                MiniStarterFooter     = { fg = '#65BCFF', italic = true },
                MiniStarterItemPrefix = { fg = '#c3e88d' },
                MiniStarterQuery      = { fg = '#c099ff' },
                NormalMode            = { fg = '#82aaff' },
                InsertMode            = { fg = '#c3e88d' },
                VisualMode            = { fg = '#c099ff' },
                CommandMode           = { fg = '#ffc777' },
                ReplaceMode           = { fg = '#ff757f' },
                TerminalMode          = { fg = '#4fd6be' },
                SelectMode            = { fg = '#c099ff' },
                Snippet               = { fg = '#c3e88d', bg = '#2f334d' },
            },
            light = {
                MiniStarterHeader     = { fg = '#34548A', bold = true },
                MiniStarterSection    = { fg = '#2e7de9', bold = true },
                MiniStarterFooter     = { fg = '#118c74', italic = true },
                MiniStarterItemPrefix = { fg = '#9854f1' },
                MiniStarterQuery      = { fg = '#f52a65' },
                NormalMode            = { fg = '#2e7de9' },
                InsertMode            = { fg = '#587539' },
                VisualMode            = { fg = '#9854f1' },
                CommandMode           = { fg = '#8c6c3e' },
                ReplaceMode           = { fg = '#f52a65' },
                TerminalMode          = { fg = '#118c74' },
                SelectMode            = { fg = '#2e7de9' },
                Snippet               = { fg = '#587539', bg = '#c4c8da' },
            },
        },
        optional = {}
    },

    ---------------------------- gruvbox ----------------------------

    gruvbox = {
        dark = 'gruvbox-material',
        light = 'gruvbox-material',
        always = {
            dark = {
                MiniStarterHeader     = { fg = '#f2594b', bold = true },
                MiniStarterSection    = { fg = '#f28534', bold = true },
                MiniStarterFooter     = { fg = '#f2594b', italic = true },
                MiniStarterItemPrefix = { fg = '#b0b846' },
                NormalMode            = { fg = '#a89984' },
                InsertMode            = { fg = '#b0b846' },
                VisualMode            = { fg = '#db4740' },
                CommandMode           = { fg = '#80aa9e' },
                ReplaceMode           = { fg = '#e9b143' },
                TerminalMode          = { fg = '#d3869b' },
                SelectMode            = { fg = '#a89984' },
                Snippet               = { fg = '#b0b846', bg = '#32302f' },
            },
            light = {
                MiniStarterHeader     = { fg = '#af2528', bold = true },
                MiniStarterSection    = { fg = '#b94c07', bold = true },
                MiniStarterFooter     = { fg = '#af2528', italic = true },
                MiniStarterItemPrefix = { fg = '#989e28' },
                MiniStarterQuery      = { fg = '#5fa37a' },
                NormalMode            = { fg = '#7c6f64' },
                InsertMode            = { fg = '#6f8352' },
                VisualMode            = { fg = '#ae5858' },
                CommandMode           = { fg = '#266b79' },
                ReplaceMode           = { fg = '#a96b2c' },
                TerminalMode          = { fg = '#924f79' },
                SelectMode            = { fg = '#7c6f64' },
                Snippet               = { fg = '#6f8352', bg = '#f4e8be' },
            }
        },
        optional = {}
    },

    -------------------------- everforest ---------------------------

    everforest = {
        dark = 'everforest',
        light = 'everforest',
        always = {
            dark = {
                MiniStarterHeader     = { fg = '#83c092', bold = true },
                MiniStarterFooter     = { fg = '#83c092', italic = true },
                MiniStarterSection    = { fg = '#a7c080', bold = true },
                MiniStarterItemPrefix = { fg = '#d699b6' },
                MiniStarterQuery      = { fg = '#e67e80' },
                NormalMode            = { fg = '#a7c080' },
                InsertMode            = { fg = '#d3c6aa' },
                VisualMode            = { fg = '#e67e80' },
                CommandMode           = { fg = '#83c092' },
                ReplaceMode           = { fg = '#e69875' },
                TerminalMode          = { fg = '#d699b6' },
                SelectMode            = { fg = '#a7c080' },
                Snippet               = { fg = '#d3c6aa', bg = '#343f44' },
            },
            light = {
                MiniStarterHeader     = { fg = '#35a77c', bold = true },
                MiniStarterFooter     = { fg = '#35a77c', italic = true },
                MiniStarterSection    = { fg = '#8da101', bold = true },
                MiniStarterItemPrefix = { fg = '#df69ba' },
                MiniStarterQuery      = { fg = '#f85552' },
                NormalMode            = { fg = '#93b259' },
                InsertMode            = { fg = '#708089' },
                VisualMode            = { fg = '#e66868' },
                CommandMode           = { fg = '#35a77c' },
                ReplaceMode           = { fg = '#f67d26' },
                TerminalMode          = { fg = '#df69ba' },
                SelectMode            = { fg = '#93b259' },
                Snippet               = { fg = '#708089', bg = '#f4f0d9' },
            }
        },
        optional = {}
    },

    tundra = {
        dark = 'tundra',
        light = 'tundra',
        always = {
            dark = {
                MiniStarterHeader     = { fg = '#bae6fd', bold = true },
                MiniStarterFooter     = { fg = '#bae6fd', italic = true },
                MiniStarterSection    = { fg = '#a5b4fc' },
                MiniStarterItemPrefix = { fg = '#fbc19d', bold = true },
                MiniStarterQuery      = { fg = '#ddd6fe' },
                NormalMode            = { fg = '#3c4759' },
                InsertMode            = { fg = '#c7ffc1' },
                VisualMode            = { fg = '#ccfdff' },
                -- CommandMode           = { fg = '#80aa9e' },
                ReplaceMode           = { fg = '#ffd4ac' },
                TerminalMode          = { fg = '#444c5c' },
                SelectMode            = { fg = '#3c4759' },
                Snippet               = { fg = '#c7ffc1', bg = '#1f2937' },
            },
            light = {
                MiniStarterHeader     = { fg = '#bae6fd', bold = true },
                MiniStarterFooter     = { fg = '#bae6fd', italic = true },
                MiniStarterSection    = { fg = '#a5b4fc' },
                MiniStarterItemPrefix = { fg = '#fbc19d', bold = true },
                MiniStarterQuery      = { fg = '#ddd6fe' },
                NormalMode   = { fg = '#3c4759' },
                InsertMode   = { fg = '#c7ffc1' },
                VisualMode   = { fg = '#ccfdff' },
                -- CommandMode           = { fg = '#80aa9e' },
                ReplaceMode  = { fg = '#ffd4ac' },
                TerminalMode = { fg = '#444c5c' },
                SelectMode   = { fg = '#3c4759' },
                Snippet      = { fg = '#c7ffc1', bg = '#1f2937' },
            }
        },
        optional = {}
    }
}

----------------- assorted colorscheme options ------------------

vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_foreground = 'mix'

-----------------------------------------------------------------

return colorschemes

-----------------------------------------------------------------
