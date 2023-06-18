--[[------------------- resolution v0.1.0 -----------------------

autocommands for any tweaks (mostly taken from LazyVim)

-------------------------------------------------------------]]--

-- ----------------------- highlight on yank -----------------------
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
        timeout = 200, 
        higroup = 'Visual'
    })
  end,
})

------------------- close some pop-ups with q -------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "spectre_panel",
    "startuptime",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
        buffer = event.buf, 
        silent = true
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "*term*",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>ToggleTerm<cr>", {
        buffer = event.buf, 
        silent = true
    })
  end,
})

-------------- resize splits if window got resized --------------
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-----------------------------------------------------------------
