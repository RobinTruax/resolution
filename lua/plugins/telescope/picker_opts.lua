--[[------------------- resolution v0.1.0 -----------------------

setting the default options for individual telescope pickers

---------------------------------------------------------------]]

return {
    live_grep = {
        prompt_title = 'Grep in Buffer',
        entry_maker = require('plugins.telescope.grep_entry_maker')({path_hidden = true}),
    },
    grep_string = {
        prompt_title = 'Grep Visual Selection',
        entry_maker = require('plugins.telescope.grep_entry_maker')(),
    },
    buffers = {
        prompt_title = 'Choose Buffer',
    },
    lsp_document_symbols = {
        prompt_title = 'Jump in Document',
        ignore_symbols = { 'enum', 'enummember', 'constant' },
        entry_maker = require('plugins.telescope.symbols_entry_maker')({path_hidden = true})
    },
    lsp_workspace_symbols = {
        prompt_title = 'Jump in Project',
        entry_maker = require('plugins.telescope.symbols_entry_maker')({path_hidden = false, fname_width = 20})
    }
}

-----------------------------------------------------------------
