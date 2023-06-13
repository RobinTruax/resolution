--[[
resolution v0.1.0
this file contains all options provided by resolution other than keybinds and aesthetics
--]]

local prefs = {}

------------------------- redefinitions -------------------------

local opt = vim.opt
local glb = vim.g
local cfg = vim.fn.stdpath('config')

----------------------- necessary settings ----------------------

prefs.project_root_path = '/home/roshan/Documents/Mathematics/'

------------------------ visual elements ------------------------

opt.cursorline = true -- cursor line highlighting
opt.number = true -- line numbering
opt.relativenumber = true -- relative line numbering
opt.wrap = true -- soft line wrapping
opt.linebreak = true -- no line breaks in the middle of words
opt.list = false -- no line breaks in middle of word

opt.scrolloff = 8 -- # of guaranteed lines at top & bottom
opt.pumheight = 5 -- maximum size of pop-up menu

prefs.cmdheight = 1 -- height of command line prompt
opt.showmode = false -- show INSERT MODE message in command line

opt.updatetime = 1000 -- time before keybind menu opens

-------------------- snippets and completion --------------------

prefs.autosnippets = true -- default behavior of auto-expanding snippets
prefs.automath_snippets = true -- default behavior of auto-mathing snippets
prefs.autocomplete = true -- default behavior of autocompletion
opt.spell = true -- spell checker

---------------------- tabs and indentation ---------------------

opt.expandtab = true -- expand tabs into spaces
opt.tabstop = 4 -- width of tab character
opt.softtabstop = 4 -- # of spaces per tab keypress
opt.shiftwidth = 4 -- # of spaces per indent
opt.autoindent = true -- enable autoindentation

------------------------ search settings -------------------------

vim.opt.hlsearch = true -- highlight search results
vim.opt.incsearch = true -- incremental searching
vim.opt.ignorecase = true -- searching is not case-sensitive
vim.opt.smartcase = true -- searching is smartly case-sensitive

---------------- undo/backups/swapfiles/sessions ----------------

opt.undodir = cfg .. '/utilities/undo//' -- undo directory
opt.backupdir = cfg .. '/utilities/backup//' -- backup directory
opt.directory = cfg .. '/utilities/swap//' -- swap file directory
glb.auto_session_root_dir = cfg .. '/utilities/sessopms//' -- session directory

opt.undolevels = 1000 -- max number of undos
opt.undofile = false -- enable permanent undo file
opt.backup = true -- enable backups
opt.swapfile = false -- enable swapfiles

--------------------------- clipboard ---------------------------

vim.opt.clipboard = 'unnamedplus' -- unify system & vim clipboard

return prefs
