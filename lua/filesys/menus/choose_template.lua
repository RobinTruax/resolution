--[[------------------- resolution v0.1.0 -----------------------

menu for choosing template for new file

---------------------------------------------------------------]]

------------------------- dependencies --------------------------

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local previewers = require('telescope.previewers')

local utilities = require('filesys.menus.utilities')

-------------------------- menu itself --------------------------

local template_directory = vim.fn.stdpath('config') .. '/tex/templates/'

local choose_template_menu = function(opts)
    if utilities.cut_path_to_project(vim.fn.getcwd()) == nil then
        require('filesys.menus.choose_project')({
            pick_files_after = false,
            callback_function = require('filesys.menus.choose_template'),
            prompt_title = 'Open Project First'
        })
    end
    if utilities.cut_path_to_project(vim.fn.getcwd()) ~= nil then
        opts = opts or {}
        local filepath = opts.filepath or vim.fn.getcwd()
        pickers.new(opts, {
            prompt_title = opts.prompt_title or 'Create File',
            finder = finders.new_table {
                results = utilities.get_files_in_directory(template_directory),
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = utilities.trim_path_file(entry),
                        ordinal = entry,
                    }
                end
            },
            sorter = conf.generic_sorter(opts),
            previewer = previewers.vim_buffer_cat.new(opts),
            attach_mappings = function(prompt_bufnr, _)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    vim.ui.input({
                        prompt = 'Enter new file name: ',
                        default = utilities.trim_path_file(selection['value']),
                        relative = 'editor',
                    }, function(input)
                        if input ~= nil then
                            local oldfile = selection['value']
                            local newfile = string.format('%s/%s', filepath, input)
                            utilities.copy_file(oldfile, newfile)
                            vim.cmd('edit ' .. newfile)
                        end
                    end)
                end)
                return true
            end,
        }):find()
    end
end

-----------------------------------------------------------------

return choose_template_menu

-----------------------------------------------------------------
