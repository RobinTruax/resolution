--------------------------------------------------------------------------------

local utilities = {}

----------------------------- file path operations -----------------------------

utilities.current_filepath = function()
    return vim.fn.expand('%:p')
end

utilities.current_directory = function()
    return vim.fn.expand('%:p:h')
end

utilities.file_exists = function(path)
    return vim.fn.filereadable(path)
end

utilities.config_path = function()
    return vim.fn.stdpath('config')
end

------------------------- file manipulation operations -------------------------

utilities.copy_file = function(from, to)
    if vim.g.windows == false then
        vim.fn.system(string.format('cp %s %s', from, to))
    else
        error('Windows has not been implemented yet.')
    end
end

utilities.append_to_file = function(string, file)
    if vim.g.windows == false then
        vim.fn.system(string.format('echo "%s" >> %s', string, file))
    else
        error('Windows has not been implemented yet.')
    end
end

--------------------------------------------------------------------------------

return utilities

--------------------------------------------------------------------------------
