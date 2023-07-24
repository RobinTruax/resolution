--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computation math.

This file implements a snippet creator for delimiters.

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
local i = ls.insert_node
local sn = ls.snippet_node
local t = ls.text_node
local d = ls.dynamic_node
local fmta = require('luasnip.extras.fmt').fmta
local utilities = require('snippets.tex.utilities')

------------------------ visual node creation function -------------------------

-- check if string is bounded by delimiters
local function check_if_bounded_by_delims(string, left, right)
    -- check if the string begins with the delimiter
    local start,_ = string:find(left, 1, true)
    if start ~= 1 then
        return false
    end

    -- check if the string ends with the delimiter
    if string:sub(-string.len(right)) ~= right then
        return false
    end

    -- if the same, return true
    if left == right then
        return true
    end

    -- otherwise, check there are always more opens than closers except at the end
    local count = 0
    for occurence in string.gmatch(string, '['..'%'..left..'%'..right..']') do
        if occurence == left then
            count = count + 1
        if count <= 0 then
            return false
        end
        elseif occurence == right then
            count = count - 1
        end
    end

    return true

end

-- rewrite iterator over letters to string
local iterator_to_string = function(iter)
    s = ''
    for _,j in pairs(iter) do
        s = s..j..' '
    end
    return s:sub(1,#s-1)
end

-- generate function for delimiter nodes
local visual_delims_generator = function(left, right)
    return function(_, parent)
        -- get the selected string
        local selected = iterator_to_string(parent.snippet.env.LS_SELECT_RAW)
        -- if the selected string is nonempty
        if (#parent.snippet.env.LS_SELECT_RAW > 0) then
            -- if the string is bounded by parentheses, strip them
            if check_if_bounded_by_delims(selected, left, right) == true then
                return sn(nil, t(selected:sub(1+left:len(),#selected-right:len())))
            -- otherwise, just return the given snippet
            else
                return sn(nil, t(parent.snippet.env.LS_SELECT_RAW))
            end
        -- finally, if the selected string is nonempty, return a space to write more
        else
            return sn(nil, i(1))
        end
    end
end

------------------------------- snippet creator --------------------------------

-- delimiter creator
local delimiter_creator = function(delimiter)
    local left = delimiter.left
    local right = delimiter.right
    local cmd_left = delimiter.cmd_left or left
    local cmd_right = delimiter.cmd_right or right
    local description = delimiter.description or left..right

    local trigger = left..right
    local format_left = cmd_left:gsub('<', '<<'):gsub('>', '>>')
    local format_right = cmd_right:gsub('<', '<<'):gsub('>', '>>')
    local format = '\\left'..format_left..'<>'..'\\right'..format_right

    local nodes = {d(1, visual_delims_generator(cmd_left, cmd_right))}

    return s({
        trig = trigger,
        wordTrig = false,
        name = description,
        condition = utilities.in_math,
        priority = 100,
    }, fmta(format, nodes))
end

--------------------------------------------------------------------------------

return delimiter_creator

--------------------------------------------------------------------------------
