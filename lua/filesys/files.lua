local files = {}
local states = require('core.global_states')

files.file_menu = function(opts)
    local opts = opts or {}
    opts.cwd = states.active_project_path
    opts.file_ignore_patterns = { '%.pdf', 'proj.info', '%environments.sty' }
    require('telescope.builtin').find_files(opts)
end

return files
