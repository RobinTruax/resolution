-- Line-to-line horizontal wrapping
vim.opt.whichwrap:append('<')
vim.opt.whichwrap:append('>')
vim.opt.whichwrap:append('h')
vim.opt.whichwrap:append('l')

-- Movement in wrapped lines
vim.cmd("nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')")
vim.cmd("nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')")
vim.cmd("nnoremap <expr> <Down> (v:count == 0 ? 'gk' : 'k')")
vim.cmd("nnoremap <expr> <Up> (v:count == 0 ? 'gj' : 'j')")
