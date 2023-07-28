--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file provides operations for the computational environment called the
Notebook.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

local notebook = {}

--------------------------------- dependencies ---------------------------------

local config_computation = require('config.advanced.computation')
local utilities = require('core.utilities')

------------------------------- state variables --------------------------------

notebook.intialized = {}

---------------------------------- utilities -----------------------------------

-- get notebook filename
notebook.get_notebook_filename = function()
    return utilities.current_directory() .. '/notebook.py'
end

-- create notebook
notebook.create_notebook = function(path)
    local default = utilities.config_path() .. '/lua/computation/py/notebook.py'
    if not utilities.file_exists(path) then
        utilities.copy(default, path)
    end
end

-- open notebook
notebook.open_notebook = function(path)
    vim.cmd('e ' .. path)
end

-- choose kernel
notebook.kernel_menu = function()
    vim.ui.select(config_computation.default_kernels, {
        prompt = ' Kernel to Launch in Project ',
        format_item = function(item)
            local spaces = item.name:len() + item.desc:len()
            if spaces > 0 then
                return string.format(' %s%s%s ', item.name, string.rep(' ', 38 - spaces), item.desc)
            else
                return string.format(' %s', item.name)
            end
        end,
    }, function(choice)
        if choice ~= nil then
            notebook.kernel_start(choice)
        end
    end)
end

-- start kernel
notebook.kernel_start = function(kernel)
    if kernel == nil then
        notebook.kernel_menu()
    else
        vim.cmd('MagmaInit ' .. kernel.cmd)
        notebook.initialization[utilities.current_filepath()] = true
    end
end

-- complete notebook initialization process
notebook.initialize = function()
    local path = notebook.get_notebook_filename()
    notebook.create_notebook(path)
    notebook.open_notebook(path)
    if notebook.initialized[path] ~= true then
        notebook.kernel_menu()
    end
end

------------------------------------ hooks -------------------------------------

-- send some text to the notebook
notebook.write_to_notebook = function(string)
    local path = notebook.get_notebook_filename()
    notebook.initialize()
    utilities.append_string_to_file('\n' .. string, path)
    vim.cmd('write')
end

-- name something and send some text to the notebook
notebook.write_to_notebook_named = function(string)
    vim.ui.input({ prompt = 'Enter name: ' }, function(input)
        if input:match("%W") or input:len() == 0 then
            notebook.write_to_notebook_named(string)
        else
            notebook.write_to_notebook(input .. ' = ' .. string)
        end
    end)
end

---------------------------------- operations ----------------------------------

-- operations which can be called from the hydra mode or directly
notebook.keybind_operations = {
    -- run cell: r or \r
    run = function()
        vim.cmd('norm viP:<C-u>')
        vim.cmd('MagmaEvaluateVisual')
    end,
    -- run cell and move down: R or \R
    run_move = function()
        vim.cmd('norm viP:<C-u>')
        vim.cmd('MagmaEvaluateVisual')
        vim.cmd('norm }}{j')
    end,
    -- move to next cell: j or \j
    next_cell = function()
        vim.cmd('norm }}{j')
    end,
    -- move to previous cell: k or \k
    prev_cell = function()
        vim.cmd('norm {{}k')
    end,
    -- select cell: v or \v (exits hydra)
    select_cell = function()
        vim.cmd('norm viP')
    end,
    -- comment_cell: c or \c
    comment_cell = function()
        vim.cmd('norm viPgcc')
    end,
    -- add cell above: a or \a
    add_cell_above = function()
        vim.cmd('norm {O')
        vim.cmd('norm o')
    end,
    -- add cell below: b or \b
    add_cell_below = function()
        vim.cmd('norm }o')
        vim.cmd('norm O')
    end,
    -- copy output: y or \y
    copy_output = function()
        vim.cmd('noautocmd MagmaEnterOutput')
        vim.cmd('norm jVGy')
        vim.cmd('wincmd p')
    end,
}

-----------------------------------------------------------------

return notebook

-----------------------------------------------------------------
