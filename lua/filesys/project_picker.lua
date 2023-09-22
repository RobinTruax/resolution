--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file implements a tool for creating pickers for any action on projects.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

--------------------------------- dependencies ---------------------------------

-- resolution
local config_filesys = require('config.advanced.filesys')
local states = require('core.states')
local core_utils = require('core.utilities')
local utilities = require('filesys.utilities')

-- telescope
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

------------------------------------ sorter ------------------------------------

local Sorter = require("telescope.sorters").Sorter

local get_fzy_sorter = function(opts)
    opts = opts or {}
    local fzy = opts.fzy_mod or require "telescope.algos.fzy"
    local OFFSET = -fzy.get_score_floor()

    return Sorter:new {
        discard = true,

        scoring_function = function(_, prompt, line)
            if line:match("Create new project...") ~= nil then
                return 0
            end

            if not fzy.has_match(prompt, line) then
                return -1
            end

            local fzy_score = fzy.score(prompt, line)

            if fzy_score == fzy.get_score_min() then
                return 1
            end

            return 1 / (fzy_score + OFFSET)
        end,

        highlighter = function(_, prompt, display)
            return fzy.positions(prompt, display)
        end,
    }
end

------------------------------------- main -------------------------------------

local project_picker = function(prompt_title, previewer, function_on_selection, additional)
    return function(opts)
        -- get options
        opts = opts or {}
        -- get result population
        local results = utilities.compile_project_infos()
        if additional ~= nil then
            results = core_utils.table_concat(results, additional)
        end
        -- create picker
        pickers.new(opts, {
            prompt_title = prompt_title,
            -- obtain project information
            finder = finders.new_table({
                results = results,
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
            }),
            -- default sorter
            sorter = get_fzy_sorter(opts),
            -- specified previewer
            previewer = previewer.new(opts),
            -- action on selection
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    function_on_selection(action_state.get_selected_entry(), opts)
                end)
                return true
            end,
        }):find()
    end
end

-----------------------------------------------------------------

return project_picker

-----------------------------------------------------------------
