--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file implements an m by n snippet creator.

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

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local utilities = require('snippets.tex.utilities')

------------------------------- snippet creator --------------------------------

-- dynamic node creator
local m_by_n_dynamic_node = function(m_by_n_object)
    -- required parameters
    local environment = m_by_n_object.environment
    local program = m_by_n_object.program
    local default = m_by_n_object.default or ''

    -- the dynamic snippet itself
    return function(args, snip)
        -- get m and n
        local m = tonumber(snip.captures[program.m])
        local n = tonumber(snip.captures[program.n])

        -- get prefix
        local prefix = ''
        if type(program.prefix) == 'number' then
            prefix = snip.captures[program.prefix]
        elseif type(program.prefix) == 'function' then
            prefix = program.prefix(m, n)
        end

        -- get suffix
        local suffix = ''
        if type(program.suffix) == 'number' then
            suffix = snip.captures[program.prefix]
        elseif type(program.suffix) == 'function' then
            suffix = program.suffix(m, n)
        end

        -- create list of nodes
        -- beginning
        local node_list = { t({ '\\begin{' .. prefix .. environment .. '}' .. suffix, '    ' }) }
        -- main
        for k = 1, m, 1 do
            for j = 1, n, 1 do
                table.insert(node_list, i(n * (k - 1) + j, default))
                if j < n then
                    table.insert(node_list, t(' & '))
                elseif k < m then
                    table.insert(node_list, t({ ' \\\\', '    ' }))
                end
            end
        end
        -- ending
        table.insert(node_list, t({ '', '\\end{' .. prefix .. environment .. '}' }))

        -- return a snippet node for dynamic node
        return sn(nil, node_list)
    end
end

-- main m by n creator
local m_by_n_creator = function(m_by_n_object)
    -- required parameters
    local environment = m_by_n_object.environment
    local trig = m_by_n_object.trig
    -- optional parameters
    local description = m_by_n_object.description or environment:gsub('^%l', string.upper)
    local mathmode = m_by_n_object.mathmode or false

    return s(
        {
            trig = trig,
            name = description,
            regTrig = true,
            condition = utilities.get_condition(mathmode)
        },
        {
            d(1, m_by_n_dynamic_node(m_by_n_object))
        }
    )
end

--------------------------------------------------------------------------------

return m_by_n_creator

--------------------------------------------------------------------------------
