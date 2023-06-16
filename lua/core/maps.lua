--[[
resolution v0.1.0
this file adds the keybinds set in config/leader-keybinds and config/other-keybinds.
--]]

require('config.preferences')
local leader_keybinds = require('config.leader-keybinds')
local other_keybinds = require('config.other-keybinds')

-- Other keybinds
for k, v in pairs(other_keybinds) do
    local opts = v.opts or {}
    opts['desc'] = v.desc
    if type(v.cmd) == 'string' then
        local mode = v.mode or 'n'
        vim.keymap.set(mode, k, v.cmd, opts)
    elseif type(v.cmd) == 'table' then
        for l, w in ipairs(v.cmd) do
            vim.keymap.set(v.mode[l], k, w, opts)
        end
    end
end

-- Leader keybinds
for k, v in pairs(leader_keybinds) do
    local opts = v.opts or {}
    opts['desc'] = v.desc
    if type(v.cmd) == 'string' then
        local mode = v.mode or 'n'
        vim.keymap.set(mode, vim.g.mapleader..k, v.cmd, opts)
    end
end

-- Various little fixes
local map = vim.keymap.set

-- Movement in wrapped lines
local function vcount(k)
    return ((vim.v.count == 0) and ('g' .. k)) or k
end
map('', 'j',      function() return vcount('j') end, { noremap = true, silent = true, expr = true, desc = 'Down' })
map('', 'k',      function() return vcount('k') end, { noremap = true, silent = true, expr = true, desc = 'Up'   })
map('', '<Down>', function() return vcount('j') end, { noremap = true, silent = true, expr = true, desc = 'Down' })
map('', '<Up>',   function() return vcount('k') end, { noremap = true, silent = true, expr = true, desc = 'Up'   })

-- Fixing movement in search (see vim galore)
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Break points for undoing (from LazyVim)
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Chaining indents (from LazyVim)
map("v", "<", "<gv")
map("v", ">", ">gv")
