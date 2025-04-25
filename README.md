# speed.nvim
keyboard speedometer for neovim

https://github.com/user-attachments/assets/42f5b239-3b2a-4394-ba32-c3314a8a2a01

## Install

with lazy.nvim
```lua
{
    "Hashino/speed.nvim",
    opts = {},
}
```

## Commands
- `:Speed toggle` toggles the plugin

## Integration

can be used as a statusbar component by disabling the floating buffer like so:

```lua
{
    "Hashino/speed.nvim",
    opts = {
        float_buffer = false,
    },
}
```

and calling `speed.current()`. for example with heirline, it's done like so:
```lua
{
  provider = function()
    return require("speed").current()
  end,

  update = {
    "User",
    pattern = "SpeedUpdate",
  },
}
```

with lualine instead:
```lua
require('lualine').setup {
    ...
    sections = {
        ...
        lualine_c = require("speed").current
        ...
    }
}
```
