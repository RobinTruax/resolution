--[[------------------- resolution v0.1.0 ---------------------

a menu for choosing a project to edit the project info for

-------------------------------------------------------------]]

------------------------- dependencies --------------------------

local config_filesys = require('config.advanced.filesys')
local states = require('core.states')
local utilities = require('filesys.menus.utilities')
local previewer = require('filesys.menus.project_info_previewer')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

--------------------------- main menu ---------------------------

local edit_project = function(opts)
    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "Edit Project Information",
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
                local to_edit = utilities.trim_path_dir(selection['value']['filepath']) .. '/' .. config_filesys.project_info_name
                vim.notify(string.format('Project %s Information Opened', selection['value']['title']), vim.log.levels.INFO)
                vim.cmd('edit '..to_edit)
                vim.lsp.buf.format()
                vim.cmd('write')
                states.project_info_compiled = false
            end)
            return true
        end,
    }):find()
end

edit_project()

-----------------------------------------------------------------

return edit_project

-----------------------------------------------------------------
