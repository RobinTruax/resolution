local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local previewers = require('telescope.previewers')

local utilities = require('filesys.menus.utilities')
local template_directory = vim.fn.stdpath('config')..'/tex/templates/'

local choose_template_menu = function(opts)
    opts = opts or {}
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
                        local newfile = string.format('%s/%s', vim.fn.getcwd(), input)
                        utilities.copy_file(oldfile, newfile)
                    end
                end)
            end)
            return true
        end,
    }):find()
end

return choose_template_menu
