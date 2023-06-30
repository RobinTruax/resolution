local utilities = {}

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local previewers = require('telescope.previewers')

local prefs = require('config.preferences')
local cfg_filesys = require('config.advanced.filesys')

utilities.file_exists = function(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

utilities.string_from_file = function(file)
    if not utilities.file_exists(file) then return '' end
    local lines = ''
    for line in io.lines(file) do
        lines = lines .. ' ' .. line
    end
    return lines
end

utilities.get_files_in_directory = function(dir)
    local files = {}
    local iterator = nil
    if vim.g.windows == false then
        iterator = io.popen('ls -pa ' .. dir .. ' | grep -v /')
    elseif vim.g.windows == true then
        iterator = io.popen('dir "' .. dir .. '" /b')
    else
        error('Windows variable has unrecognized value in function which makes system call.')
    end
    for file in iterator:lines() do
        table.insert(files, dir .. file)
    end
    return files
end

utilities.get_subdirs_in_directory = function(dir)
    local files = {}
    local iterator = nil
    if vim.g.windows == false then
        iterator = io.popen('ls -d ' .. dir .. '*')
    elseif vim.g.windows == true then
        error('Not implemented yet.')
    else
        error('Windows variable has unrecognized value in function which makes system call.')
    end
    for file in iterator:lines() do
        table.insert(files, file)
    end
    return files
end

utilities.copy_file = function(oldfile, newfile)
    if vim.g.windows == false then
        vim.fn.system(string.format('cp %s %s', oldfile, newfile))
    elseif vim.g.windows == true then
        vim.fn.system(string.format('copy %s %s', oldfile, newfile))
    else
        error('Windows variable has unrecognized value in function which makes system call.')
    end
end

utilities.make_dir = function(location)
    if vim.g.windows == false then
        vim.fn.system(string.format('mkdir %s', location))
    elseif vim.g.windows == true then
        error('Not implemented yet.')
    else
        error('Windows variable has unrecognized value in function which makes system call.')
    end
end

utilities.trim_path_dir = function(path)
    return vim.fn.fnamemodify(path, ':h')
end

utilities.trim_path_file = function(path)
    return vim.fn.fnamemodify(path, ':t')
end

utilities.write_table_to_file = function(table, path)
    vim.fn.writefile({ vim.json.encode(table) }, path)
end

utilities.cut_path_to_project = function(path)
    local root = prefs.project_root_path:gsub('(.-)[\\/]+$', '%1')
    if path:match(root) == nil then
        return nil
    end
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
        return path:sub(1, x)..'/'
    end
end

utilities.get_project_name = function(path)
    local cut_path = utilities.cut_path_to_project(path)
    if cut_path == nil then
        return 'Not In Project'
    end
    local proj_info = cut_path .. cfg_filesys.project_info_name
    local proj_info_string = utilities.string_from_file(proj_info)
    if proj_info_string == nil then
        return 'Project Name Not Found'
    end
    return vim.json.decode(proj_info_string).title
end

return utilities
