local Config = {}

local HEIGHT = 1
local WIDTH = 13

---@class SpeedOptions
---@field enabled boolean wether plugin is enabled
---@field edit_win_config table window config for the edit window
Config.default_opts = {
  enabled = true,

  -- window configs of the floating tasks editor
  -- see :h nvim_open_win() for available options
  edit_win_config = {
    relative = "editor",

    width = WIDTH,
    height = HEIGHT,
    col = vim.o.columns - WIDTH,
    row = vim.o.lines - 3 - vim.o.cmdheight - HEIGHT,

    style = "minimal",
    border = "rounded",

    noautocmd = true,
  },
}

Config.options = Config.default_opts

return Config
