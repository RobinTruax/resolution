--[[------------------- resolution v0.1.0 -----------------------

defines keybinds for rsltn's main operations; these use the
<leader> key set in config.preferences

-------------------------------------------------------------]]--

return {

    [''] = {
        desc = 'resolution',
        cmd = false,
    },

--------------------------- top-level ---------------------------

    ['a'] = {
        desc = 'Toggle [a]utosnippets',
        cmd = ''
    },
    ['d'] = {
        desc = '[d]elete buffer',
        cmd = '<cmd> bd <cr>'
    },
    ['e'] = {
        desc = 'File [e]xplorer',
        cmd = '<cmd> Neotree <cr>'
    },
    ['h'] = {
        desc = '[h]elp and doc.',
        cmd = '<cmd> e '..vim.fn.stdpath('config')..'/documentation.md <cr>'
    },
    ['j'] = {
        desc = '[j]ump list',
        cmd = function() require("nvim-navbuddy").open() end
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
        desc = 'Open [m]ath project',
        cmd = ''
    },
    ['n'] = {
        desc = 'The [n]apkin',
        cmd = ''
    },
    ['N'] = {
        desc = 'The [N]otebook',
        cmd = ''
    },
    ['P'] = {
        desc = '[P]eek at definition',
        cmd = ''
    },
    ['q'] = {
        desc = '[q]uit/save all',
        cmd = '<cmd> wqa <cr>'
    },
    ['r'] = {
        desc = '[r]sltn start',
        cmd = '<cmd> lua require("mini.starter").open() <cr>'
    },
    ['R'] = {
        desc = '[R]sltn start w/ split',
        cmd = '<C-w>v<C-w>w <cmd> lua require("mini.starter").open() <cr>'
    },
    ['T'] = {
        desc = '[T]erminal',
        cmd = '<cmd> ToggleTerm <cr>'
    },
    ['v'] = {
        desc = '[v]iew file in project',
        cmd = ''
    },

-------------------------- windows (w) --------------------------

    ['w'] = {
        desc = '[w]indows',
        cmd = false,
    },
    ['w+'] = {
        desc = 'Increase win. height',
        cmd = ''
    },
    ['w-'] = {
        desc = 'Decrease win. height',
        cmd = ''
    },
    ['w>'] = {
        desc = 'Increase win. width',
        cmd = ''
    },
    ['w<'] = {
        desc = 'Decrease win. height',
        cmd = ''
    },
    ['w_'] = {
        desc = 'Maximize win. height',
        cmd = ''
    },
    ['w|'] = {
        desc = 'Maximize win. width',
        cmd = ''
    },
    ['w='] = {
        desc = 'Equalize windows',
        cmd = ''
    },
    ['wq'] = {
        desc = 'Close window',
        cmd = ''
    },
    ['wo'] = {
        desc = 'Close other windows',
        cmd = ''
    },
    ['wh'] = {
        desc = 'Horizontal split',
        cmd = ''
    },
    ['wv'] = {
        desc = 'Vertical split',
        cmd = ''
    },
    ['ws'] = {
        desc = 'Swap windows',
        cmd = ''
    },

-------------------------- buffers (b) --------------------------

    ['b'] = {
        desc = '[b]uffers',
        cmd = false,
    },
    ['bp'] = {
        desc = 'Pin buffer',
        cmd = ''
    },
    ['bs'] = {
        desc = 'Pick buffer',
        cmd = ''
    },
    ['bd'] = {
        desc = 'Pick and delete buffer',
        cmd = ''
    },
    ['br'] = {
        desc = 'Remember session',
        cmd = ''
    },
    ['bS'] = {
        desc = 'Search sessions',
        cmd = ''
    },

------------------------ preferences (p) ------------------------


    ['p'] = {
        desc = '[p]references',
        cmd = false,
    },
    ['pc'] = {
        desc = 'Choose colorscheme',
        cmd = ''
    },
    ['pd'] = {
        desc = 'Toggle dark mode',
        cmd = ''
    },
    ['pw'] = {
        desc = 'Toggle word wrap',
        cmd = ''
    },
    ['pn'] = {
        desc = 'Toggle numbering',
        cmd = ''
    },
    ['pr'] = {
        desc = 'Toggle relative numbering',
        cmd = ''
    },
    ['pv'] = {
        desc = 'Toggle virtual editing',
        cmd = ''
    },
    ['ps'] = {
        desc = 'Toggle autosnippets',
        cmd = ''
    },
    ['pm'] = {
        desc = 'Toggle autocomplete',
        cmd = ''
    },
    ['pi'] = {
        desc = 'Toggle autoindent',
        cmd = ''
    },
    ['pl'] = {
        desc = 'Toggle conceal',
        cmd = ''
    },
    ['pz'] = {
        desc = 'Toggle spell-checker',
        cmd = ''
    },

-------------------------- search (s) ---------------------------

    ['s'] = {
        desc = '[s]earch',
        cmd = false,
    },
    ['se'] = {
        desc = 'System file [e]xplorer',
        cmd = ''
    },
    ['sf'] = {
        desc = '[s]earch [f]iles (root)',
        cmd = ''
    },
    ['sh'] = {
        desc = '[s]earch [h]idden files (root)',
        cmd = ''
    },
    ['sc'] = {
        desc = '[s]earch [c]ommand history',
        cmd = ''
    },
    ['ss'] = {
        desc = '[s]earch [s]earch history',
        cmd = ''
    },
    ['sm'] = {
        desc = '[s]earch/rep. [m]ulti. files',
        cmd = ''
    },
    ['sg'] = {
        desc = '[g]rep in file',
        cmd = ''
    },
    ['sG'] = {
        desc = '[G]rep in project',
        cmd = ''
    },
    ['sr'] = {
        desc = '[r]esume search',
        cmd = ''
    },
    ['sb'] = {
        desc = '[s]earch [b]ookmarks',
        cmd = ''
    },
    ['sy'] = {
        desc = '[s]earch [y]anks',
        cmd = ''
    },
    ['su'] = {
        desc = '[s]earch [u]ndo tree',
        cmd = ''
    },

---------------------- file management (f) ----------------------

    ['f'] = {
        desc = '[f]ile management',
        cmd = false,
    },
    ['fc'] = {
        desc = '[c]reate project',
        cmd = ''
    },
    ['fa'] = {
        desc = '[a]rchive project',
        cmd = ''
    },
    ['fe'] = {
        desc = '[e]dit project',
        cmd = ''
    },
    ['fn'] = {
        desc = '[n]ew file in project',
        cmd = ''
    },

----------------------- git and github (g) ----------------------

    ['g'] = {
        desc = '[g]it and github',
        cmd = false,
    },
    ['ga'] = {
        desc = 'Update [a]ll reg. repos',
        cmd = ''
    },
    ['gb'] = {
        desc = 'Update [b]uilt-in repos',
        cmd = ''
    },
    ['gu'] = {
        desc = 'Update [u]ser repos',
        cmd = ''
    },
    ['gr'] = {
        desc = 'Create [r]epo from project',
        cmd = ''
    },
    ['gc'] = {
        desc = '[c]reate project from repo',
        cmd = ''
    },
    ['gp'] = {
        desc = 'Toggle file [p]ublicity',
        cmd = ''
    },
    ['gP'] = {
        desc = 'Toggle project [p]ublicity',
        cmd = ''
    },
    ['gh'] = {
        desc = 'Configure [g]it[h]ub user',
        cmd = ''
    },

---------------------- tex operations (t) -----------------------

    ['t'] = {
        desc = '[t]ex operations',
        cmd = false,
    },
    ['tc'] = {
        desc = 'La[t]ex [c]ite',
        cmd = ''
    },
    ['tm'] = {
        desc = 'La[t]ex [m]atrices',
        cmd = ''
    },
    ['tt'] = {
        desc = 'La[t]ex [t]tables',
        cmd = ''
    },
    ['td'] = {
        desc = 'La[t]ex new [d]efinition',
        cmd = ''
    },
    ['tr'] = {
        desc = 'La[t]ex [r]eferences',
        cmd = ''
    },
    ['te'] = {
        desc = 'La[t]ex [e]rrors',
        cmd = ''
    },
    ['ts'] = {
        desc = 'La[t]ex sync[t]ex',
        cmd = ''
    },
    ['tx'] = {
        desc = 'La[t]ex clean au[x]',
        cmd = ''
    },

---------------------- code operations (c) ----------------------

    ['c'] = {
        desc = '[c]ode operations',
        cmd = false,
    },
    ['cf'] = {
        desc = '[f]ormat code',
        cmd = ''
    },
    ['cr'] = {
        desc = '[r]ename',
        cmd = ''
    },

---------------------- tex extensions (x) -----------------------

    ['x'] = {
        desc = 'tex e[x]tensions',
        cmd = false,
    },
    ['xo'] = {
        desc = 'e[x]tension: [o]verleaf',
        cmd = false
    },
    ['xc'] = {
        desc = 'e[x]tension: [c]ommutative diagrams',
        cmd = false
    },
    ['xq'] = {
        desc = 'e[x]tension: [q]uantum circuits',
        cmd = false
    },
    ['xk'] = {
        desc = 'e[x]tension: [k]nots',
        cmd = false
    },
    ['xg'] = {
        desc = 'e[x]tension: [g]raphs',
        cmd = false
    },
    ['xt'] = {
        desc = 'e[x]tension: [t]ikz editor',
        cmd = false
    },
    ['xi'] = {
        desc = 'e[x]tension: [i]nkscape',
        cmd = false
    },

}

-----------------------------------------------------------------
