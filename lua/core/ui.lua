--[[------------------- resolution v0.1.0 -----------------------

utility functions for rsltn's standardized ui interface

-------------------------------------------------------------]]

local ui = {}
local aesthetics = require('config.aesthetics')

-------------------- macro recording snippet --------------------

ui.macro_recording_sl = function()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "rec @" .. recording_register
    end
end

---------- get borders based on aesthetic preferences -----------

ui.get_borders = function()
    if aesthetics.ui_sharp == true then
        return { '┌', '─', '┐', '│', '┘', '─', '└', '│' }
    else
        return { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }
    end
end

ui.get_borders_or_less = function()
    if aesthetics.ui_borderless == true then
        return { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }
    else
        return ui.get_borders()
    end
end

-----------------------------------------------------------------

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
return ui
