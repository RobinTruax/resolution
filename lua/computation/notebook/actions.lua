--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file provides action operations for the computational environment called the 
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

local notebook_actions = {}

--------------------------------- dependencies ---------------------------------

local config    = require('config.advanced.computation')
local utilities = require('core.utilities')
local wk        = require('which-key')
local map       = vim.keymap.set

----------------------------------- keybinds -----------------------------------

notebook_actions.register_keybinds = function()
    -- overwrite keymap to move to notebook locally
    vim.keymap.set('n', '<leader>C', '<cmd>WhichKey <LT>leader>C<cr>', { buffer = true })
    -- add local keymaps (direct and hydra)
    local flat_direct = {}
    local flat_hydra = {}
    -- create keybinds
    for k, v in pairs(config.keybinds) do
        -- direct keybinds
        map('n', '<localleader>' .. k, v[1], { desc = v[2], buffer = true, silent = true })
        -- hydra keybinds
        map('n', '<leader>C' .. k, function()
            v[1]()
            vim.cmd('WhichKey <leader>C')
        end, { desc = v[2], buffer = true, silent = true })
        -- prepping for registration
        flat_direct['<localleader>' .. k] = v[2]
        local description = v[2] .. ' hydra'
        flat_hydra['<leader>C' .. k] = description
    end
    -- register keybinds
    wk.register(flat_direct)
    wk.register(flat_hydra)
end

-- operations which can be called from the hydra mode or directly
notebook_actions.keybind_operations = {
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
    -- copy cell: y or \y
    copy_cell = function()
        vim.cmd('norm yiP')
    end,
    -- copy output: o or \o
    copy_output = function()
        local start_win = vim.fn.win_getid()
        vim.cmd('noautocmd MagmaEnterOutput')
        if vim.fn.win_getid() ~= start_win then
            vim.cmd('norm jvG$y')
            vim.cmd('wincmd p')
        end
    end,
    -- create or open
    create_or_open = function()
        vim.cmd('norm $')
        require('computation.notebook.files').main()
    end,
}

------------------------------------ hooks -------------------------------------

notebook_actions.choose_page_callback = function(callback_function)
    local notebook_files = require('computation.notebook.files')
    local pages = notebook_files.get_pages()
    if #pages == 0 then
        vim.notify('No pages to choose from.', vim.log.levels.WARN)
        notebook_files.add_page()
    else
    -- page choice menu
        vim.ui.select(pages, {
            prompt = ' Open page ',
            format_item = function(item)
                return utilities.trim_path_file(item)
            end,
        }, function(choice)
            -- initiate callback
            if choice ~= nil then
                callback_function(choice)
            end
        end)
    end
end

-- send some text to the notebook
notebook_actions.write_to_notebook = function(string)
    notebook_actions.choose_page_callback(function(choice)
        utilities.append_string_to_file('\n' .. string, choice)
        vim.notify('Code sent to the notebook', vim.log.levels.INFO)
    end)
end

-- name something and send some text to the notebook
notebook_actions.write_to_notebook_named = function(string)
    vim.ui.input({ prompt = 'Enter name: ' }, function(input)
        if input:match("%W") or input:len() == 0 then
            notebook_actions.write_to_notebook_named(string)
        else
            notebook_actions.write_to_notebook(input .. ' = ' .. string)
        end
    end)
end


--------------------------------------------------------------------------------

return notebook_actions

-------------------------------------------------------------------------------
