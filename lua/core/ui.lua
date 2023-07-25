--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file provides utility functions for resolution's standardized UI interface.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

local ui = {}

--------------------------------- get borders ----------------------------------

ui.get_borders = function()
    return { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }
end

ui.get_borderless = function()
    return { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }
end

--------------------- better buffer deletion functionality ---------------------

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

--------------------------------------------------------------------------------

return ui

--------------------------------------------------------------------------------
