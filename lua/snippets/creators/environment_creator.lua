--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computation math.

This file implements a snippet creator for environments.

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

local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require('luasnip.extras.fmt').fmta
local utilities = require('snippets.tex.utilities')

------------------------------ utility functions -------------------------------

-- label-generating function
local label_func = function(arg, _)
    return (arg[1][1]:gsub('%\\[%a]+%{', ''):gsub('[%s-]+', '_'):gsub('[^%w_]', ''))
end

-- mini function for sorting snippets
local switch = function(auto)
    if auto == true then
        return 'auto'
    else
        return 'manual'
    end
end

-------------------------- snippet creator functions ---------------------------

-- generate nodes automatically for environment snippets
local generate_nodes = function(options, label, content)
    -- decide if label is added
    local label_added = 1
    if label ~= 0 then
        label_added = 0
    end
    -- option nodes
    local nodes = {}
    for _ in options:gmatch('<>') do
        table.insert(nodes, i(#nodes + 1))
    end
    -- label node if necessary
    if label ~= 0 then
        table.insert(nodes, f(label_func, label))
    end
    -- content nodes (including visual capture)
    local visual_inserted = false
    for _ in content:gmatch('<>') do
        if visual_inserted == false then
            table.insert(nodes, d(#nodes + label_added, utilities.extend_visual))
            visual_inserted = true
        else
            table.insert(nodes, i(#nodes + label_added))
        end
    end
    -- return statement
    return nodes
end

-- environment creator
local environment_creator = function(params)
    -- sanitize information
    -- necessary
    local environment = params.environment
    local trigger = params.trigger
    -- format construction
    local content = params.content or '    <>'
    local options = params.options or ''
    local label = params.label or 0
    -- snippet options
    local line = params.line or 0
    local mathmode = params.mathmode or false
    local description = params.description or environment:gsub('^%l', string.upper) .. ' Environment'
    local priority = params.priority or 100
    -- other
    local auto = params.auto or false
    local snippets = params.snippets or {}

    -- create format
    -- label string if necessary
    local label_string = ''
    if label ~= 0 then
        label_string = '\\label{' .. trigger .. ':<>}'
    end

    -- format itself
    local format = string.format([[
\begin{%s}%s%s
%s
\end{%s}
    ]], environment, options, label_string, content, environment)

    -- get condition for expansion
    local cond = utilities.get_condition_line_behav(line, mathmode)

    -- create snippet(s) to return
    local snippets_to_return = {
        auto = {},
        manual = {}
    }
    if line ~= 2 then
        table.insert(
            snippets_to_return[switch(auto)],
            s({ trig = trigger, name = description, condition = cond, priority = priority }, fmta(format, generate_nodes(options, label, content)))
        )
    end
    if line == 2 then
        table.insert(
            snippets_to_return[switch(auto)],
            s({ trig = trigger, name = description, condition = cond[1], priority = priority }, fmta('\n\n' .. format .. '\n',
                generate_nodes(options, label, content)))
        )
        table.insert(
            snippets_to_return[switch(auto)],
            s({ trig = trigger, name = description, condition = cond[2], priority = priority + 1 }, fmta(format, generate_nodes(options, label, content)))
        )
    end

    -- create sub-snippet(s) to return
    for _,v in ipairs(snippets) do
        table.insert(
            snippets_to_return[switch(v.auto)],
            s({trig = v.trigger, name = v.expanded, condition = utilities.in_environment(environment), priority = 100}, {t(v.expanded)})
        )
    end

    return snippets_to_return
end

--------------------------------------------------------------------------------

return environment_creator

--------------------------------------------------------------------------------
