local should_profile = os.getenv("NVIM_PROFILE")
if should_profile then
  require("profile").instrument_autocmds()
  if should_profile:lower():match("^start") then
    require("profile").start("*")
  else
    require("profile").instrument("*")
  end
end

local function toggle_profile()
  local prof = require("profile")
  if prof.is_recording() then
    prof.stop()
    vim.ui.input({ prompt = "Save profile to:", completion = "file", default = "profile.json" }, function(filename)
      if filename then
        prof.export(filename)
        vim.notify(string.format("Wrote %s", filename))
      end
    end)
  else
    prof.start("*")
  end
end
vim.keymap.set("", "<f2>", toggle_profile)

--[[------------------- resolution v0.1.0 -----------------------

init file; nexus for all other files

-------------------------------------------------------------]]--

-- preferences
require('config.preferences')

-- set up plugins
require('core.plugins')

-- set up keybinds
require('core.keymaps')

-- set autocmds
require('core.autocmds.all')

-- set any lingering neovim options
require('core.execute-cnfg')
