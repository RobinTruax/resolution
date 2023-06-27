local utilities = {}

----------------------- context-detection -----------------------

utilities.line_begin = function(line_to_cursor, matched_trigger)
    return line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
end

utilities.in_math = function()
    return (vim.api.nvim.eval('vimtex#syntax#in_mathzone()') == 1)
end

utilities.in_text = function()
    return (vim.api.nvim.eval('vimtex#syntax#in_mathzone()') == 0)
end

utilities.in_math_line_begin = function(line_to_cursor, matched_trigger)
    if utilities.line_begin(line_to_cursor, matched_trigger) then
        return (vim.api.nvim.eval('vimtex#syntax#in_mathzone()') == 1)
    else
        return false
    end
end

utilities.in_text_line_begin = function(line_to_cursor, matched_trigger)
    if utilities.line_begin(line_to_cursor, matched_trigger) then
        return (vim.api.nvim.eval('vimtex#syntax#in_mathzone()') == 0)
    else
        return false
    end
end

utilities.in_environment = function(name)
    return function()
        local is_inside = vim.fn['vimtex#env#is_inside'](name)
        return (is_inside[1] > 0 and is_inside[2] > 0)
    end
end

utilities.in_environment_line_begin = function(name)
    return function(line_to_cursor, matched_trigger)
        if utilities.line_begin(line_to_cursor, matched_trigger) then
            local is_inside = vim.fn['vimtex#env#is_inside'](name)
            return (is_inside[1] > 0 and is_inside[2] > 0)
        else
            return false
        end
    end
end

----------------------------- other -----------------------------

local function extend_visual(_, parent)
    return sn(nil, { t(parent.snippet.env.SELECT_RAW), i(1) })
end

---------------------------- return -----------------------------

return utilities
