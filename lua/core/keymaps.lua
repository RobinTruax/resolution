--[[------------------- resolution v0.1.0 -----------------------

set up all keymaps; those in config as well as some tweaks

-------------------------------------------------------------]]--

local preferences = require('config.preferences') -- this ~is~ used
local leader_keybinds = require('config.leader-keybinds')
local other_keybinds = require('config.other-keybinds')
local map = vim.keymap.set

--------------------- add 'other keybinds' ----------------------

for k, v in pairs(other_keybinds) do
    local opts = v.opts or {}
    opts['desc'] = v.desc
    if type(v.cmd) == 'table' then
        for l, w in ipairs(v.cmd) do
            map(v.mode[l], k, w, opts)
        end
    elseif type(v.cmd) ~= 'boolean' then
        local mode = v.mode or 'n'
        map(mode, k, v.cmd, opts)
    end
end

--------------------- add 'leader keybinds' ---------------------

for k, v in pairs(leader_keybinds) do
    local opts = v.opts or {}
    opts['desc'] = v.desc
    if type(v.cmd) == 'table' then
        for l, w in ipairs(v.cmd) do
            map(v.mode[l], vim.g.mapleader..k, w, opts)
        end
    elseif type(v.cmd) ~= 'boolean' then
        local mode = v.mode or 'n'
        map(mode, vim.g.mapleader..k, v.cmd, opts)
    end
end

------------------- movement in wrapped lines  ------------------

local function vcount(k)
    return ((vim.v.count == 0) and ('g' .. k)) or k
end

local down_opts = { noremap = true, silent = true, expr = true, desc = 'Down' }
local up_opts   = { noremap = true, silent = true, expr = true, desc = 'Up'   }

map('', 'j',      function() return vcount('j') end, down_opts)
map('', 'k',      function() return vcount('k') end, up_opts  )
map('', '<Down>', function() return vcount('j') end, down_opts)
map('', '<Up>',   function() return vcount('k') end, up_opts  )

----------- better search movement (vim galore) ------------

map('n', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('n', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

---------------- add undo break points (LazyVim) ----------------

map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')

------------------ chaining indents (LazyVim) -------------------

map('v', '<', '<gv')
map('v', '>', '>gv')

--------------- let horizontal movement line-wrap ---------------

vim.opt.whichwrap:append('<')
vim.opt.whichwrap:append('>')
vim.opt.whichwrap:append('h')
vim.opt.whichwrap:append('l')

---------------- simplifying various textobjects ----------------

map('o', 'aP', 'ap') -- [P]aragraphs
map('o', 'iP', 'ip')
map('v', 'aP', 'ap')
map('v', 'iP', 'ip')
map('o', 'ap', 'a)') -- [p]arentheses
map('o', 'ip', 'i)')
map('v', 'ap', 'a)')
map('v', 'ip', 'i)')
map('o', 'ar', 'a]') -- [r]ectangular bracket
map('o', 'ir', 'i]')
map('v', 'ar', 'a]')
map('v', 'ir', 'i]')
map('o', 'ac', 'a}') -- [c]urly bracket
map('o', 'ic', 'i}')
map('v', 'ac', 'a}')
map('v', 'ic', 'i}')

-----------------------------------------------------------------
