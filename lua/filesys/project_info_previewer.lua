--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file implements a project information previewer.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

-------------------------------- dependencies ----------------------------------

local core_utils = require('core.utilities')
local conf = require('telescope.config').values
local previewers = require('telescope.previewers')
local config_filesys = require('config.advanced.filesys')

---------------------------- previewer components ------------------------------

-- sets defaults for a Telescope object (taken from telescope.nvim code)
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

-- actual previewer
local previewer = defaulter(function(opts)
    opts = opts or {}
    local cwd = opts.cwd or vim.loop.cwd()
    return previewers.new_buffer_previewer {
        title = 'File Preview',
        -- dynamic title if enabled
        dyn_title = function(_, entry)
            return core_utils.trim_path_dir(entry['value']['filepath']) .. '/' .. config_filesys.project_info_name
        end,
        -- get buffer
        get_buffer_by_name = function(_, entry)
            return core_utils.trim_path_dir(entry['value']['filepath']) .. '/' .. config_filesys.project_info_name
        end,
        -- preview window
        define_preview = function(self, entry)
            local p = core_utils.trim_path_dir(entry['value']['filepath']) .. '/' .. config_filesys.project_info_name
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

--------------------------------------------------------------------------------

return previewer

--------------------------------------------------------------------------------
