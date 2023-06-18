--[[------------------- resolution v0.1.0 -----------------------

utility functions for rsltn's standardized ui interface

-------------------------------------------------------------]]
                                                                --

local ui = {}
local aesthetics = require('config.aesthetics')

---------- get borders based on aesthetic preferences -----------

ui.get_borders = function()
    if aesthetics.ui_sharp == true then
        return { '┌', '┐', '┘', '└', '─', '│' }
    else
        return { '╭', '╮', '╯', '╰', '─', '│' }
    end
end

-----------------------------------------------------------------

-------------- better buffer delete functionality ---------------

-- count number of buffers
ui.buf_count = function()
    local bufs_loaded = 0
    for i,buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) ~= '' then
            bufs_loaded = bufs_loaded + 1
        end
    end
    return bufs_loaded
end

-- if there is just one valid buffer, reset to the start screen
-- otherwise, delete buffer in such a way that splits are respected.
ui.buf_del_execute = function()
    if ui.buf_count() == 1 then
        require('mini.starter').open()
        vim.cmd('bd #')
    else
        vim.cmd('bp | bd #')
    end
end

ui.buf_del_wrapper = function()
    if require('nvim-tree.view').is_visible() then
        vim.cmd('NvimTreeToggle')
        ui.buf_del_execute()
        vim.cmd('NvimTreeToggle')
    else
        ui.buf_del_execute()
    end
end

return ui
