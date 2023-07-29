--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file implements the menu for choosing a template for a new file.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

--------------------------------- dependencies ---------------------------------

-- resolution
local core_utils = require('core.utilities')

-- telescope
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local previewers = require('telescope.previewers')

--------------------------------- menu itself ----------------------------------

-- find template directory
local template_directory = core_utils.config_path() .. '/tex/templates/'

local choose_template_menu = function(opts)
    -- make sure users are in a project
    if core_utils.current_project_path() == nil then
        vim.notify('Choose Project First', vim.log.levels.WARN)
        require('filesys.actions.choose_project')({
            pick_files_after = false,
            callback_function = require('filesys.actions.choose_template'),
            prompt_title = 'Open Project First'
        })
    -- otherwise
    else
        -- get options
        opts = opts or {}
        -- get filepath
        local filepath = opts.filepath or vim.fn.getcwd()
        -- create picker
        pickers.new(opts, {
            prompt_title = opts.prompt_title or 'Create File',
            -- finder
            finder = finders.new_table {
                results = core_utils.get_files_in_directory(template_directory),
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = core_utils.trim_path_file(entry),
                        ordinal = entry,
                    }
                end
            },
            -- default sorter and previewer
            sorter = conf.generic_sorter(opts),
            previewer = previewers.vim_buffer_cat.new(opts),
            -- action on selection
            attach_mappings = function(prompt_bufnr, _)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    -- enter new filename
                    vim.ui.input({
                        -- options
                        prompt = 'Enter new file name: ',
                        default = core_utils.trim_path_file(selection['value']),
                        relative = 'editor',
                    }, function(input)
                        -- if name is not nil, then create the file using that name
                        if input ~= nil then
                            local oldfile = selection['value']
                            local newfile = string.format('%s/%s', filepath, input)
                            if core_utils.file_exists(newfile) == true then
                                vim.notify('File Exists Already, Cancelling', vim.log.levels.ERROR)
                                return
                            end
                            vim.notify('Creating File...', vim.log.levels.INFO)
                            core_utils.copy_file(oldfile, newfile)
                            vim.cmd('edit ' .. newfile)
                        end
                    end)
                end)
                return true
            end,
        }):find()
    end
end

--------------------------------------------------------------------------------

return choose_template_menu

--------------------------------------------------------------------------------
