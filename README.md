<div align="right">
  <a href="https://www.buymeacoffee.com/Hashino" target="_blank">
    <img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" 
    alt="Buy Me A Coffee" style="height: 24px !important;width: 104px !important;" >
  </a>
</div>

# speed.nvim

<a href="https://dotfyle.com/plugins/Hashino/speed.nvim">
	<img src="https://dotfyle.com/plugins/Hashino/speed.nvim/shield?style=flat" />
</a>

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
