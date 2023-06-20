--[[------------------- resolution v0.1.0 ---------------------

a menu for choosing a project

-------------------------------------------------------------]]

local projects = {}

------------------------- dependencies --------------------------

local prefs = require('config.preferences')
local states = require('core.global_states')

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local previewers = require('telescope.previewers')

------------------------- configuration -------------------------

local project_info_pattern = "'proj.info'"

local project_type_icons = {
    Writing    = '󰴓',
    Class      = '󰑴',
    Research   = '',
    Experiment = '',
    Code       = '',
}

----------------------- utility functions -----------------------

local function get_all_project_infos()
    local files = {}
    local string_of_files = io.popen('find ' .. prefs.project_root_path .. ' -name ' .. project_info_pattern)
    for filename in string_of_files:lines() do
        files[#files + 1] = filename
    end
    string_of_files:close()
    return files
end

local function read_file(path)
    local file = io.open(path, "rb")
    if not file then return nil end
    local content = file:read "*a"
    file:close()
    return content
end

local function compile_project_infos(force)
    if force == true then
        states.project_info_compiled = false
    end
    if states.project_info_compiled == false or force == true then
        local table_of_project_infos = {}
        for _, project_info in pairs(get_all_project_infos()) do
            local decoded_project_info = vim.json.decode(read_file(project_info))
            decoded_project_info['filepath'] = project_info
            table_of_project_infos[#table_of_project_infos + 1] = decoded_project_info
        end
        states.table_of_project_infos = table_of_project_infos
        states.project_info_compiled = true
    end
    return states.table_of_project_infos
end

local trim_path = function(str, sep)
    sep = sep or '/'
    return str:match("(.*" .. sep .. ")")
end

local most_recent_file = function(path, force)
    if states.most_recent_files[path] == nil or force == true then
        local cmd = 'ls -t ' .. path .. '*.tex | head -n1'
        local untrimmed = vim.fn.system(cmd)
        states.most_recent_files[path] = untrimmed:sub(1, -2)
    end
    return states.most_recent_files[path]
end

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
            return most_recent_file(trim_path(entry['value']['filepath']))
        end,

        get_buffer_by_name = function(_, entry)
            return most_recent_file(trim_path(entry['value']['filepath']))
        end,

        define_preview = function(self, entry)
            local p = most_recent_file(trim_path(entry['value']['filepath']))
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

projects.project_menu = function(opts)
    vim.cmd('TelescopeLoad')
    local opts = require('core.menus.default_opts')
    pickers.new(opts, {
        prompt_title = "Open Project",
        finder = finders.new_table {
            results = compile_project_infos(),
            entry_maker = function(entry)
                local icon = project_type_icons[entry['type']] or ' '
                return {
                    value = entry,
                    display = icon .. '   ' .. entry['title'],
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
                prefs.active_project_path = trim_path(selection['value']['filepath'])
                vim.cmd('cd ' .. prefs.active_project_path)
            end)
            return true
        end,
    }):find()
end

-----------------------------------------------------------------

return projects

-----------------------------------------------------------------
