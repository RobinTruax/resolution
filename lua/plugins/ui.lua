--[[------------------- resolution v0.1.0 -----------------------

all plugins relating to UI which are not called on startup

-------------------------------------------------------------]]--
--        event = { 'BufReadPost', 'BufNewFile' },
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
        'nvim-tree/nvim-tree.lua',
        version = '*',
        cmd = {'NvimTreeOpen', 'NvimTreeToggle', 'NvimTreeFindFile', 'NvimTreeFindFileToggle'},
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = true,
    },

----------------- lazygit.nvim: git integration -----------------
    {
        'kdheepak/lazygit.nvim',
        cmd = {'LazyGit', 'LazyGitCurrentFile'},
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function ()
            vim.g.lazygit_floating_window_border_chars = require('core.ui').get_borders_or_less()
            vim.g.lazygit_floating_window_scaling_factor = 0.8
        end
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

            -- register "other"-type keybinds
            local flat_other_keybinds = {}
            local other_keybinds = require('config.other-keybinds')
            for k, v in pairs(other_keybinds) do
                if v.cmd == false then
                    flat_other_keybinds[k] = { name = v.desc }
                end
            end

            -- register "leader"-type keybinds
            local flat_leader_keybinds = {}
            local leader_keybinds = require('config.leader-keybinds')
            for k, v in pairs(leader_keybinds) do
                if v.cmd == false then
                    flat_leader_keybinds['<leader>' .. k] = { name = v.desc }
                end
            end

            local border = 'none'
            if require('config.aesthetics').ui_borderless == false then
                border = 'single'
            end

            -- ui customization and setup
            local wk = require('which-key')
            wk.setup({
                window = {
                    winblend = 10,
                    border = border,
                },
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
