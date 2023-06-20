local files = {}
local states = require('core.global_states')

files.file_menu = function()
    local opts = require('core.menus.default_opts')
    opts.cwd = states.active_project_path
    opts.file_ignore_patterns = { '%.pdf', 'proj.info', '%environments.sty' }
    require('telescope.builtin').find_files(opts)
end

return files
