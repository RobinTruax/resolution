--[[------------------- resolution v0.1.0 ---------------------

a menu for choosing a project to archive

-------------------------------------------------------------]]

------------------------- dependencies --------------------------

local config_filesys = require('config.advanced.filesys')
local prefs = require('config.preferences')
local states = require('core.states')
local utilities = require('filesys.menus.utilities')
local previewer = require('filesys.menus.project_previewer')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

--------------------------- main menu ---------------------------

local archive_project = function(opts)
    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "Archive Project",
        finder = finders.new_table {
            results = utilities.compile_project_infos(),
            entry_maker = function(entry)
                local icon = ' '
                for _, v in ipairs(config_filesys.project_icons) do
                    if v[1] == entry['type'] then
                        icon = v[2]
                    end
                end
                return {
                    value = entry,
                    display = icon .. '   ' .. entry['title'],
                    ordinal = entry['title'],
                }
            end
        },
        sorter = conf.generic_sorter(opts),
        previewer = previewer.new(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                local archive = prefs.project_root_path:gsub('(.-)[\\/]+$', '%1') .. '/' .. config_filesys.archive_project_folder .. '/' .. vim.fn.fnamemodify(selection['value']['filepath'], ':h:t')
                local current = utilities.trim_path_dir(selection['value']['filepath'])
                vim.notify(string.format('Project %s Archived', selection['value']['title']), vim.log.levels.WARN)
                utilities.mv_folder(current, archive)
                states.project_info_compiled = false
                require('filesys.menus.archive_project')()
            end)
            return true
        end,
    }):find()
end

-----------------------------------------------------------------

return archive_project

-----------------------------------------------------------------
