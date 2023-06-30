local utilities = require('filesys.menus.utilities')
local choose_files = require('filesys.menus.choose_files')
local choose_project = require('filesys.menus.choose_project')

local choose_project_and_file = function()
    if utilities.get_path_to_project(vim.fn.getcwd()) == nil then
        choose_project()
    else
        choose_files()
    end
end

return choose_project_and_file
