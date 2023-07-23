--[[------------------- resolution v0.1.0 -----------------------

utility functions for rsltn's standardized ui interface

-------------------------------------------------------------]]

local ui = {}
local aesthetics = require('config.aesthetics')

-------------------- macro recording snippet --------------------

ui.macro_recording_sl = function()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return "      "
    else
        return "rec @" .. recording_register
    end
end

---------- get borders based on aesthetic preferences -----------

ui.get_borders = function()
    return { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }
end

ui.get_borderless = function()
    return { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }
end

-------------- better buffer delete functionality ---------------

ui.buf_del_wrapper = function()
    if require('nvim-tree.view').is_visible() then
        vim.cmd('NvimTreeToggle')
        vim.cmd('Bdelete')
        vim.cmd('NvimTreeToggle')
        vim.cmd('wincmd w')
    else
        vim.cmd('Bdelete')
    end
end

ui.buf_del_all_wrapper = function()
    if require('nvim-tree.view').is_visible() then
        vim.cmd('NvimTreeToggle')
        vim.cmd('bufdo :Bdelete')
        vim.cmd('NvimTreeToggle')
        vim.cmd('wincmd w')
    else
        vim.cmd('bufdo :Bdelete')
        require('mini.starter').open()
    end
end

-----------------------------------------------------------------

return ui
