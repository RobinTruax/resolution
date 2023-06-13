--[[
resolution v0.1.0
this file defines the keybinds for rsltn's main operations, which use the <leader> key
--]]

return {
    -- top-level keybinds
    ['a'] = {
        desc = 'toggle [a]utosnippets',
        cmd = ''
    },
    ['d'] = {
        desc = '[d]elete buffer',
        cmd = '<cmd> bd <cr>'
    },
    ['j'] = {
        desc = '[j]ump list',
        cmd = require("nvim-navbuddy").open()
    },
    ['J'] = {
        desc = 'flat [J]ump list',
        cmd = ''
    },
    ['l'] = {
        desc = '[l]atex compilation',
        cmd = '<cmd> VimtexCompile <cr>'
    },
    ['m'] = {
        desc = 'open [m]ath project',
        cmd = ''
    },
    ['n'] = {
        desc = 'the [n]apkin',
        cmd = ''
    },
    ['N'] = {
        desc = 'the [N]otebook',
        cmd = ''
    },
    ['q'] = {
        desc = '[q]uit/save all',
        cmd = '<cmd> wqa <cr>'
    },
    ['t'] = {
        desc = '[t]erminal',
        cmd = '<cmd> ToggleTerm <cr>'
    },
    ['v'] = {
        desc = '[v]iew file in project', 
        cmd = ''
    },

    -- utilities
}

