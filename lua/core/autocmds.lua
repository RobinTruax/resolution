local prefs = require('config.preferences')

-- ensure that there is no spell check or command line on startup screen
vim.api.nvim_create_autocmd(
    'BufEnter',
    {
        callback = function()
            vim.o.cmdheight = prefs.cmdheight
        end
    })
vim.api.nvim_create_autocmd(
    'FileType',
    {
        desc = 'Hide spellcheck',
        pattern = 'startup',
        callback = function()
            vim.cmd('setlocal nospell')
            vim.cmd('setlocal cmdheight=0')
        end,
    })

-- highlight on yank (from LazyVim)
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "spectre_panel",
    "startuptime",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "*term*",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>ToggleTerm<cr>", { buffer = event.buf, silent = true })
  end,
})
