--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file adds snippets as specified in /config/snippets.lua.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

local manual_snippets = {}
local auto_snippets = {}

----------------------------------- creators -----------------------------------

local command_creator = require('snippets.creators.command_creator')
local environment_creator = require('snippets.creators.environment_creator')
local symbol_creator = require('snippets.creators.symbol_creator')
local modifier_creator = require('snippets.creators.modifier_creator')
local delimiter_creator = require('snippets.creators.delimiter_creator')
local m_by_n_creator = require('snippets.creators.m_by_n_creator')

------------------------------- adding snippets --------------------------------

-- add environment snippets
for _, v in ipairs(require('config.snippets').environments) do
    local all_snippets = environment_creator(v)
    for _, w in ipairs(all_snippets.manual) do
        table.insert(manual_snippets, w)
    end
    for _, w in ipairs(all_snippets.auto) do
        table.insert(auto_snippets, w)
    end
end

-- add non-math command snippets
for _, v in ipairs(require('config.snippets').nonmath_commands) do
    if v.auto == true then
        table.insert(auto_snippets, command_creator(v, false))
    else
        table.insert(manual_snippets, command_creator(v, false))
    end
end

-- add math command snippets
for _, v in ipairs(require('config.snippets').math_commands) do
    if v.auto == true then
        table.insert(auto_snippets, command_creator(v, true))
    else
        table.insert(manual_snippets, command_creator(v, true))
    end
end

-- add symbol snippets
for _, v in ipairs(require('config.snippets').math_symbols) do
    if v.auto == true then
        table.insert(auto_snippets, symbol_creator(v))
    else
        table.insert(manual_snippets, symbol_creator(v))
    end
end

-- add modifiers snippets
for _, v in ipairs(require('config.snippets').modifiers) do
    local all_snippets = modifier_creator(v)
    for _, w in ipairs(all_snippets.manual) do
        table.insert(manual_snippets, w)
    end
    for _, w in ipairs(all_snippets.auto) do
        table.insert(auto_snippets, w)
    end
end

-- add delimiter snippets
for _, v in ipairs(require('config.snippets').delimiters) do
    table.insert(manual_snippets, delimiter_creator(v))
end

-- add m by n object snippets
for _, v in ipairs(require('config.snippets').m_by_n_objects) do
    if v.auto == true then
        table.insert(auto_snippets, m_by_n_creator(v))
    else
        table.insert(manual_snippets, m_by_n_creator(v))
    end
end

--------------------------------------------------------------------------------

return manual_snippets, auto_snippets

--------------------------------------------------------------------------------
