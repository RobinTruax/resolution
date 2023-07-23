--[[------------------- resolution v0.1.0 -----------------------

this file provides the operations for the environment

---------------------------------------------------------------]]

local notebook = {}

------------------------- dependencies --------------------------

local config_computation = require('config.advanced.computation')

------------------------ state variables ------------------------

notebook.intialized = nil

------------------------ initialization -------------------------

notebook.initialization_menu = function()
    vim.ui.select(config_computation.default_kernels, {
        prompt = ' Kernel to Launch in Project ',
        format_item = function(item)
            local spaces = item.name:len() + item.desc:len()
            if spaces > 0 then
                return string.format(' %s%s%s ', item.name, string.rep(' ', 38 - spaces), item.desc)
            else
                return string.format(' %s', item.name)
            end
        end,
    }, function(choice)
        if choice ~= nil then
            notebook.initialize(choice)
        end
    end)
end

notebook.initialize = function(kernel)
    if kernel == nil then
        notebook.initialization_menu()
    else
        vim.cmd('MagmaInit ' .. kernel.cmd)
    end
end

-------------------------- operations ---------------------------

notebook.napkin_to_notebook = function()
    if notebook.initialized == nil then
        notebook.initialize()
    end
end

notebook.napkin_to_notebook_named = function()
    if notebook.initialized == nil then
        notebook.initialize()
    end
end

notebook.send_to_latex = function()
    if notebook.initialized == nil then
        notebook.initialize()
    end
end

notebook.send_from_latex = function()
    if notebook.initialized == nil then
        notebook.initialize()
    end
end

-------------------------- hydra mode ---------------------------

-- operations required to support
-- send to latex
-- send to latex

------------------- communication with popup --------------------

-----------------------------------------------------------------

return notebook

-----------------------------------------------------------------
