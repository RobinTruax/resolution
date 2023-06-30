--[[------------------- resolution v0.1.0 ---------------------

a menu for choosing a project

-------------------------------------------------------------]]

------------------------- dependencies --------------------------

local prefs = require('config.preferences')
local utilities = require('filesys.menus.utilities')
local cfg_filesys = require('config.advanced.filesys')

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local previewers = require('telescope.previewers')

--------------------- previewer components ----------------------

local function defaulter(f, default_opts)
    default_opts = default_opts or {}
    return {
        new = function(opts)
            if conf.preview == false and not opts.preview then
                return false
            end
            opts.preview = type(opts.preview) ~= "table" and {} or opts.preview
            if type(conf.preview) == "table" then
                for k, v in pairs(conf.preview) do
                    opts.preview[k] = vim.F.if_nil(opts.preview[k], v)
                end
            end
            return f(opts)
        end,
        __call = function()
            local ok, err = pcall(f(default_opts))
            if not ok then
                error(debug.traceback(err))
            end
        end,
    }
end

local cat = defaulter(function(opts)
    opts = opts or {}
    local cwd = opts.cwd or vim.loop.cwd()
    return previewers.new_buffer_previewer {
        title = "File Preview",
        dyn_title = function(_, entry)
            return utilities.most_recent_file(utilities.trim_path_dir(entry['value']['filepath']))
        end,

        get_buffer_by_name = function(_, entry)
            return utilities.most_recent_file(utilities.trim_path_dir(entry['value']['filepath']))
        end,

        define_preview = function(self, entry)
            local p = utilities.most_recent_file(utilities.trim_path_dir(entry['value']['filepath']))
            if p == nil or p == "" then
                return
            end
            conf.buffer_previewer_maker(p, self.state.bufnr, {
                bufname = self.state.bufname,
                winid = self.state.winid,
                preview = opts.preview,
                file_encoding = opts.file_encoding,
            })
        end,
    }
end, {})

--------------------------- main menu ---------------------------

local choose_project = function(opts)
    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "Open Project",
        finder = finders.new_table {
            results = utilities.compile_project_infos(),
            entry_maker = function(entry)
                -- local icon = cfg_filesys.project_type_icons[entry['type']] or ' '
                return {
                    value = entry,
                    display = entry['title'],
                    -- display = icon .. '   ' .. entry['title'],
                    ordinal = entry['title'],
                }
            end
        },
        sorter = conf.generic_sorter(opts),
        previewer = cat.new(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                vim.cmd('cd ' .. utilities.trim_path_dir(selection['value']['filepath']))
                require('filesys.menus.choose_files')()
            end)
            return true
        end,
    }):find()
end

-----------------------------------------------------------------

return choose_project

-----------------------------------------------------------------
