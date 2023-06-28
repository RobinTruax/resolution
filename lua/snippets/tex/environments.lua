--[[------------------- resolution v0.1.0 -----------------------

environment snippets as configured in config.snippets.environment

---------------------------------------------------------------]]

--------------------- luasnip abbreviations ---------------------

local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require('luasnip.extras.fmt').fmta

---------------------- other dependencies -----------------------

local utilities = require('snippets.tex.utilities')

----------------------- utility functions -----------------------

-- strips commands, spaces, and symbols from the entered text
local parse_label = function(input)
    return (input:gsub('%\\[%a]+%{', ''):gsub('[%s-]+', '_'):gsub('[^%w_]', ''))
end

-- function to be passed to function snippet
local label_func = function(arg, _)
    return parse_label(arg[1][1])
end

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

-- get expansion condition for environment snippets
local get_condition = function(line, mathmode)
    if line == 0 and mathmode == false then
        return utilities.in_text_line_begin
    elseif line == 0 and mathmode == true then
        return utilities.in_math_line_begin
    elseif line == 1 and mathmode == false then
        return utilities.in_text
    elseif line == 1 and mathmode == true then
        return utilities.in_math
    elseif line == 2 and mathmode == false then
        return { utilities.in_text, utilities.in_text_line_begin }
    elseif line == 2 and mathmode == true then
        return { utilities.in_math, utilities.in_math_line_begin }
    else
        return function() return true end
    end
end

-- mini function for sorting snippets
local switch = function(auto)
    if auto == true then
        return 'auto'
    else
        return 'manual'
    end
end

------------------------ snippet creator ------------------------

local environment_snippet = function(params)
    -- sanitize information
    -- necessary
    local environment  = params.environment
    local trigger      = params.trigger
    -- format construction
    local content      = params.content or '    <>'
    local options      = params.options or ''
    local label        = params.label or 0
    -- snippet options
    local line         = params.line or 0
    local mathmode     = params.mathmode or false
    local description  = params.description or environment:gsub('^%l', string.upper) .. ' Environment'
    local priority     = params.priority or 100
    -- other
    local auto         = params.auto or false
    local snippets     = params.snippets or {}

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
    local cond = get_condition(line, mathmode)

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

----------------------- snippet addition ------------------------

local manual_snippets = {}
local auto_snippets = {}

for _, v in ipairs(require('config.snippets').environments) do
    local all_snippets = environment_snippet(v)
    for _, w in ipairs(all_snippets.manual) do
        table.insert(manual_snippets, w)
    end
    for _, w in ipairs(all_snippets.auto) do
        table.insert(auto_snippets, w)
    end
end

-----------------------------------------------------------------

return manual_snippets, auto_snippets
