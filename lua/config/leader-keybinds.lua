--[[
resolution v0.1.0
this file defines the keybinds for rsltn's main operations
these use the <leader> key
--]]

return {

--------------------------- top-level ---------------------------

    ['a'] = {
        desc = 'toggle [a]utosnippets',
        cmd = ''
    },
    ['d'] = {
        desc = '[d]elete buffer',
        cmd = '<cmd> bd <cr>'
    },
    ['h'] = {
        desc = '[h]help and documentation',
        cmd = ''
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
    ['T'] = {
        desc = '[t]erminal',
        cmd = '<cmd> ToggleTerm <cr>'
    },
    ['v'] = {
        desc = '[v]iew file in project',
        cmd = ''
    },

-------------------------- windows (w) --------------------------



-------------------------- buffers (b) --------------------------



------------------------ preferences (p) ------------------------



------------------------- utilities (u) -------------------------



-------------------------- search (s) ---------------------------



---------------------- file management (f) ----------------------



---------------------- tex operations (t) -----------------------



---------------------- code operations (c) ----------------------



---------------------- tex extensions (x) -----------------------



}

