--[[------------------- resolution v0.1.0 -----------------------

this function searches all files in /tex/dictionary/ 
to get all entries to the math dictionary

---------------------------------------------------------------]]

------------- utility functions from stackexchange --------------

-- check if file exists
local function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

-- get lines from file
local function lines_from(file)
    if not file_exists(file) then return {} end
    local lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = line
    end
    return lines
end

-------------------- function to read files ---------------------

local function get_dictionary_entries(files)
    local entries = {}
    for _,f in pairs(files) do
        local lines = lines_from(f)
        for _,l in pairs(lines) do
            table.insert(entries, {label = l})
        end
    end

    return entries
end

return get_dictionary_entries
