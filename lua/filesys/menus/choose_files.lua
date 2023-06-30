--[[------------------- resolution v0.1.0 -----------------------

file choice menu

---------------------------------------------------------------]]

local config_filesys = require('config.advanced.filesys')

local choose_files = function(opts)
    opts = opts or {}
    opts.cwd = vim.fn.getcwd()
    opts.file_ignore_patterns = { '%.pdf', config_filesys.project_info_name }
    require('telescope.builtin').find_files(opts)
end

return choose_files
