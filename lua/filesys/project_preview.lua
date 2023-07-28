--[[------------------- resolution v0.1.0 -----------------------

previewer for project-based pickers

---------------------------------------------------------------]]

------------------------- dependencies --------------------------

local utilities = require('filesys.menus.utilities')
local conf = require('telescope.config').values
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

local previewer = defaulter(function(opts)
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

-----------------------------------------------------------------

return previewer

-----------------------------------------------------------------
