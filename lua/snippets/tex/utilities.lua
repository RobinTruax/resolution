local utilities = {}

utilities.in_math = function()
    return (vim.api.nvim.eval('vimtex#syntax#in_mathzone()') == 1)
end

return utilities
