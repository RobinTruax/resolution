--[[------------------- resolution v0.1.0 -----------------------

all non-aesthetic non-keybind options (including vim options)

-------------------------------------------------------------]]--

local prefs = {}

------------------------- redefinitions -------------------------

local opt = vim.opt
local glb = vim.g
local cfg = vim.fn.stdpath('config')

----------------------- necessary settings ----------------------

prefs.project_root_path = '/home/roshan/Documents/Mathematics/'
prefs.format_style_file = vim.fn.stdpath('config')..'/tex/format-style.yaml'
prefs.dictionary_files = {
    vim.fn.stdpath('config')..'/tex/dictionary/proof-of-concept.txt'
}

-------------------------- leader keys --------------------------

vim.g.mapleader = ' '       -- set leader key
vim.g.maplocalleader = '\\' -- local leader key

------------------------ visual elements ------------------------

opt.termguicolors  = true  -- better colors, no reason to change this in 2023
opt.cursorline     = true  -- cursor line highlighting
opt.number         = true  -- line numbering
opt.relativenumber = true  -- relative line numbering
opt.wrap           = true  -- soft line wrapping
opt.linebreak      = true  -- no line breaks in the middle of words
opt.list           = false -- no line breaks in middle of word

opt.scrolloff      = 5     -- # of guaranteed lines at top & bottom
opt.pumheight      = 5     -- maximum size of pop-up menu
opt.cmdheight      = 0     -- height of command line prompt
opt.showmode       = false -- show INSERT MODE message in command line
opt.updatetime     = 1000  -- time before keybind menu opens

-------------------- snippets and completion --------------------

prefs.autosnippets      = true  -- default behavior of auto-expanding snippets
prefs.automath_snippets = true  -- default behavior of auto-mathing snippets
prefs.autocomplete      = true  -- default behavior of autocompletion
opt.spell               = false -- spell checker

---------------------- tabs and indentation ---------------------

opt.expandtab   = true -- expand tabs into spaces
opt.tabstop     = 4    -- width of tab character
opt.softtabstop = 4    -- # of spaces per tab keypress
opt.shiftwidth  = 4    -- # of spaces per indent
opt.autoindent  = true -- enable autoindentation

------------------------ search settings -------------------------

opt.hlsearch   = true -- highlight search results
opt.incsearch  = true -- incremental searching
opt.ignorecase = true -- searching is not case-sensitive
opt.smartcase  = true -- searching is smartly case-sensitive

---------------- undo/backups/swapfiles/sessions ----------------

opt.undodir               = cfg .. '/utilities/undo//'     -- undo directory
opt.backupdir             = cfg .. '/utilities/backup//'   -- backup directory
opt.directory             = cfg .. '/utilities/swap//'     -- swap file directory
glb.auto_session_root_dir = cfg .. '/utilities/sessions//' -- session directory

opt.undolevels            = 1000                           -- max number of undos
opt.undofile              = true                           -- enable permanent undo file
opt.backup                = true                           -- enable backups
opt.swapfile              = false                          -- enable swapfiles
opt.autoread              = true                           -- automatically reread buffers

------------------------- miscellaneous -------------------------

-- don't edit these unless you're at least an intermediate user

opt.clipboard             = 'unnamedplus' -- unify system & vim clipboard
opt.foldmethod            = 'marker'      -- folding using triple curly brackets
prefs.number_recent_files = 5             -- number of recent files in startup screen
prefs.timestamp_backup    = true          -- timestamped backups (leave this ON in alpha)
opt.fillchars             = { eob = ' ' } -- remove end-of-file characters
opt.ea                    = false         -- let rsltn handle window resizing

-----------------------------------------------------------------

return prefs

-----------------------------------------------------------------
