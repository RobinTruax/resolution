--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file implements some useful operations to do with manipulating files in a
way which is operating-system agnostic; that is, it should run correctly on both
Linux and Windows computers.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

local utilities = {}

--------------------------------- dependencies ---------------------------------

local prefs = require('config.preferences')
local cfg_filesys = require('config.advanced.filesys')

--------------------------------- system calls ---------------------------------

-- change dir
utilities.exec_in_dir = function(command, dir)
    if vim.g.windows == false then
        return vim.fn.system(string.format('(cd %s; %s)', dir, command))
    elseif vim.g.windows == true then
        error('Windows is not implemented yet.')
    else
        error('Unrecognized operating system.')
    end
end

--------------------------------- search tools ---------------------------------

-- get all files in a directory
utilities.get_files_in_directory = function(dir)
    -- initalize
    local files = {}
    local iterator = nil
    -- actual process
    if vim.g.windows == false then
        iterator = io.popen('ls -pa ' .. dir .. ' | grep -v /')
    elseif vim.g.windows == true then
        iterator = io.popen('dir "' .. dir .. '" /b')
    else
        error('Unrecognized operating system.')
    end
    -- file iterator into table
    if iterator ~= nil then
        for file in iterator:lines() do
            table.insert(files, dir .. file)
        end
    end
    return files
end

-- get all subdirectories of directory
utilities.get_subdirs_in_directory = function(dir)
    -- initialize
    local files = {}
    local iterator = nil
    -- actual process
    if vim.g.windows == false then
        iterator = io.popen('ls -d ' .. dir .. '/*')
    elseif vim.g.windows == true then
        error('Windows is not implemented yet.')
    else
        error('Unrecognized operating system.')
    end
    -- file iterator into table
    if iterator ~= nil then
        for file in iterator:lines() do
            table.insert(files, file)
        end
    end
    return files
end

----------------------------- file path operations -----------------------------

-- get filepath of current buffer
utilities.current_filepath = function()
    return vim.fn.expand('%:p')
end

-- get path to directory of current buffer
utilities.current_directory = function()
    return vim.fn.expand('%:p:h')
end

-- check if file exists and is readable
utilities.file_exists = function(path)
    if vim.fn.filereadable(path) == 0 then
        return false
    end
    return true
end

-- check if directory exists
utilities.directory_exists = function(path)
    return vim.fn.isdirectory(path)
end

-- get config path
utilities.config_path = function()
    return vim.fn.stdpath('config')
end

-- trim the path to directory
utilities.trim_path_dir = function(path)
    return vim.fn.fnamemodify(path, ':h')
end

-- trim the path to file
utilities.trim_path_file = function(path)
    return vim.fn.fnamemodify(path, ':t')
end

-- trim the path to file
utilities.trim_path_file_name_only = function(path)
    return vim.fn.fnamemodify(path, ':t:r')
end

-- read file to string, collapsing newlines
utilities.string_from_file = function(path)
    if not utilities.file_exists(path) then return '' end
    local lines = ''
    for line in io.lines(path) do
        lines = lines .. ' ' .. line
    end
    return lines
end

-- accepts table, writes json of table to file
utilities.write_table_to_file = function(table, path)
    vim.fn.writefile({ vim.json.encode(table) }, path)
end

-- accepts file, writes computed json to table
utilities.write_json_to_table = function(path)
    if utilities.string_from_file(path) == '' then
        return {}
    end
    return vim.json.decode(utilities.string_from_file(path))
end

----------------------------- related to projects ------------------------------

-- cuts path of current file to project
utilities.cut_path_to_project = function(path)
    -- checks that file is in project folder
    local root = prefs.project_root_path
    if path:match(root) == nil then
        return nil
    end
    -- searches for specific folder of project
    local _, x = path:find(root)
    _, x = path:find('[\\/]', x + 1)
    if x == nil then return nil end
    _, x = path:find('[\\/]', x + 1)
    if x == nil then return nil end
    _, x = path:find('[\\/]', x + 1)
    if x == nil then x = path:len() end
    if path:sub(x, x) == '/' then
        return path:sub(1, x)
    else
        return path:sub(1, x) .. '/'
    end
end

-- gets path of current project
utilities.current_project_path = function()
    return utilities.cut_path_to_project(utilities.current_filepath())
end

-- returns project name
utilities.get_project_name = function(path)
    -- get path, ensure that path is a project path
    local cut_path = utilities.cut_path_to_project(path)
    if cut_path == nil then
        return 'Not In Project'
    end

    -- get project info
    local proj_info = utilities.write_json_to_table(cut_path .. cfg_filesys.project_info_name)

    -- return project info
    if proj_info == nil then
        return 'Project Info Not Found'
    else
        if proj_info.title == nil then
            return 'Project Name Not Found'
        end
        return proj_info.title
    end
end

------------------------- file manipulation operations -------------------------

-- create symlink
utilities.symlink = function(oldloc, newloc)
    if vim.g.windows == false then
        vim.fn.system(string.format('ln -s %s %s', oldloc, newloc))
    elseif vim.g.windows == true then
        error('Windows not implemented.')
    else
        error('Unrecognized operating system.')
    end
end

-- create directory
utilities.create_directory = function(location)
    if vim.g.windows == false then
        vim.fn.system(string.format('mkdir %s', location))
    elseif vim.g.windows == true then
        vim.fn.system(string.format('md "%s"', location))
    else
        error('Unrecognized operating system.')
    end
end

-- move folder
utilities.move_folder = function(oldloc, newloc)
    if vim.g.windows == false then
        vim.fn.system(string.format('mv %s %s', oldloc, newloc))
    elseif vim.g.windows == true then
        vim.fn.system(string.format('move "%s" "%s"', oldloc, newloc))
    else
        error('Unrecognized operating system.')
    end
end

-- copy file
utilities.copy_file = function(from, to)
    if vim.g.windows == false then
        vim.fn.system(string.format('cp %s %s', from, to))
    elseif vim.g.windows == true then
        vim.fn.system(string.format('copy "%s" "%s"', from, to))
    else
        error('Unrecognized operating system.')
    end
end

-- write string to file (overwrites)
utilities.write_string_to_file = function(string, file)
    if vim.g.windows == false then
        vim.fn.system(string.format('echo "%s" > %s', string, file))
    elseif vim.g.windows == true then
        vim.fn.system(string.format('echo "%s" > %s', string, file))
    else
        error('Unrecognized operating system.')
    end
end

-- append string to file (does not overwrite)
utilities.append_string_to_file = function(string, file)
    if vim.g.windows == false then
        vim.fn.system(string.format('echo "%s" >> %s', string, file))
    elseif vim.g.windows == true then
        vim.fn.system(string.format('echo "%s" >> %s', string, file))
    else
        error('Unrecognized operating system.')
    end
end

------------------------------------ other -------------------------------------

utilities.has_value = function(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

--------------------------------------------------------------------------------

return utilities

--------------------------------------------------------------------------------
