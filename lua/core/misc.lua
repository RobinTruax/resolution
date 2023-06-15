-- Line-to-line horizontal wrapping
vim.opt.whichwrap:append('<')
vim.opt.whichwrap:append('>')
vim.opt.whichwrap:append('h')
vim.opt.whichwrap:append('l')

-- Movement in wrapped lines
local function vcountfunc(k)
    return ((vim.v.count == 0) and ('g' .. k)) or k
end

vim.keymap.set('', 'j',      function() return vcountfunc('j') end, { noremap = true, silent = true, expr = true, desc = 'Down' })
vim.keymap.set('', 'k',      function() return vcountfunc('k') end, { noremap = true, silent = true, expr = true, desc = 'Up'   })
vim.keymap.set('', '<Down>', function() return vcountfunc('j') end, { noremap = true, silent = true, expr = true, desc = 'Down' })
vim.keymap.set('', '<Up>',   function() return vcountfunc('k') end, { noremap = true, silent = true, expr = true, desc = 'Up'   })
