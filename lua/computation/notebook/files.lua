--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file provides file operations for the computational environment called the 
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

local notebook_files = {}

--------------------------------- dependencies ---------------------------------

local config           = require('config.advanced.computation')
local utilities        = require('core.utilities')
local notebook_actions = require('computation.notebook.actions')

-------------------------- list of initialized pages ---------------------------

notebook_files.initialized = {}

-------------------------------- get page path ---------------------------------

notebook_files.get_folder_path = function()
    -- get path
    local path = string.format('%snotebook',
        utilities.current_project_path())
    -- return
    return path
end

notebook_files.get_path = function(page)
    -- format page name
    local formatted_page = string.format('%03d', page)
    -- get path
    local path = string.format('%snotebook/%s.py',
        utilities.current_project_path(),
        formatted_page)
    -- return
    return path
end

------------------------------ get list of pages -------------------------------

notebook_files.get_pages = function()
    -- paths
    local project_path = utilities.robust_current_project_path()
    local notebook_path = project_path .. 'notebook/'
    -- get pages
    local files = utilities.get_files_in_directory(notebook_path)
    return files
end

-------------------------------- choose kernel ---------------------------------

notebook_files.choose_kernel = function(path)
    -- menu of kernel options
    vim.ui.select(config.kernel_list, {
        prompt = ' Kernel to Launch in Project ',
        -- format item
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
            -- start kernel
            vim.schedule(function()
                if path ~= nil then
                    local folder_path = notebook_files.get_folder_path()
                    if utilities.directory_exists(folder_path) ~= true then
                        utilities.create_directory(folder_path)
                    end
                    notebook_files.create_page(path, choice)
                    vim.cmd('e ' .. path)
                end
                vim.notify('Launching kernel for notebook', vim.log.levels.INFO)
                vim.cmd('MagmaInit ' .. choice.cmd)
                notebook_actions.register_keybinds()
                notebook_files.initialized[utilities.current_filepath()] = true
            end)
        end
    end)
end

----------------------------------- add page -----------------------------------

-- direct creation routine
notebook_files.create_page = function(path, kernel)
    -- location of default file
    local default = string.format('%s/lua/computation/templates/%s.%s',
        utilities.config_path(),
        kernel.folder,
        kernel.extension
    )
    -- copy default file to location
    if not utilities.file_exists(path) then
        vim.notify('Creating notebook file', vim.log.levels.INFO)
        utilities.copy_file(default, path)
    end
end

-- complete page-adding routine
notebook_files.add_page = function()
    -- list of all pages
    local pages = notebook_files.get_pages()
    local numbers = {}
    for _,page in ipairs(pages) do
        numbers[#numbers + 1] = tonumber(utilities.trim_path_file_name_only(page))
    end
    -- find smallest number not in list
    local smallest = 0
    while true do
        if utilities.has_value(numbers, smallest) == false then
            break
        end
        smallest = smallest + 1
    end
    -- create path
    local path = notebook_files.get_path(smallest)
    -- create file
    notebook_files.choose_kernel(path)
end

---------------------------------- open page -----------------------------------

notebook_files.open_page = function()
    -- get pages
    local pages = notebook_files.get_pages()
    if #pages == 0 then
        vim.notify('No pages to choose from. Create a page first.', vim.log.levels.WARN)
        notebook_files.add_page()
    else
    -- page choice menu
        vim.ui.select(pages, {
            prompt = ' Open page ',
            format_item = function(item)
                return utilities.trim_path_file(item)
            end,
        }, function(choice)
            -- open page
            if choice ~= nil then
                vim.cmd('e ' .. choice)
                if notebook_files.initialized[choice] ~= true then
                    notebook_files.choose_kernel(nil)
                end
            end
        end)
    end
end

------------------------------------- main -------------------------------------

notebook_files.main = function()
    vim.ui.select(
        -- options
        {
            {'open', ' Open page '},
            {'create', ' Create page '},
        },
        {
            -- prompt
            prompt = 'Open or create page',
            -- format item
            format_item = function(item)
                return item[2]
            end
        }, function(choice)
            if choice == nil then
                return
            else
                -- open
                if choice[1] == 'open' then
                    notebook_files.open_page()
                -- create
                elseif choice[1] == 'create' then
                    notebook_files.add_page()
                end
            end
        end)
end

--------------------------------------------------------------------------------

return notebook_files

--------------------------------------------------------------------------------
