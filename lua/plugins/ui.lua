--[[------------------- resolution v0.1.0 -----------------------

all plugins relating to UI which are not called on startup

-------------------------------------------------------------]]--

return {

-------------- toggleterm.nvim: a better terminal ---------------
    {
        'akinsho/toggleterm.nvim',
        version = '*',

        cmd = 'ToggleTerm',

        config = true,
    },

----------------- neo-tree.nvim: file explorer ------------------
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',

        cmd = 'Neotree',

        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
    },

----------------- lazygit.nvim: git integration -----------------
    {
        'kdheepak/lazygit.nvim',

        cmd = 'LazyGit',

        dependencies = {
            'nvim-lua/plenary.nvim',
        },
    },

------ nvim-spectre: search/replace across multiple files -------
    {
        'nvim-pack/nvim-spectre',

        cmd = 'Spectre',

        config = function()
            require('spectre').setup()
        end,
    },

-------------- which-key.nvim: keybind-based menus --------------
    {
        'folke/which-key.nvim',

        cmd = 'WhichKey',
        event = { 'BufReadPost', 'BufNewFile' },

        config = function()
            vim.o.timeout = true

            local flat_other_keybinds = {}
            local other_keybinds = require('config.other-keybinds')
            for k, v in pairs(other_keybinds) do
                if v.cmd == false then
                    flat_other_keybinds[k] = { name = v.desc }
                end
            end

            local flat_leader_keybinds = {}
            local leader_keybinds = require('config.leader-keybinds')
            for k, v in pairs(leader_keybinds) do
                if v.cmd == false then
                    flat_leader_keybinds['<leader>' .. k] = { name = v.desc }
                end
            end

            local wk = require('which-key')
            wk.setup({
                layout = {
                    height = {min = 4, max = 10},
                    width = {min = 20, max = 40},
                    spacing = 3,
                    align = 'center',
                }
            })
            wk.register(flat_other_keybinds)
            wk.register(flat_leader_keybinds)
        end,
    },
}

-----------------------------------------------------------------
