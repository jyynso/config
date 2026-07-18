local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.keys = require("keymaps")

-- appearance
config.color_scheme = 'GruvboxDark' 
config.font_size = 12
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = true
config.window_decorations = "RESIZE"
config.font = wezterm.font({ family = "BlexMono Nerd Font" })
config.front_end = "WebGpu"
config.window_background_opacity = 0.80
config.initial_cols = 100
config.initial_rows = 25

config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = "#b8bb26",
      fg_color = "#282828",
    },
  },
}
config.window_padding = {
    left = 30,
    right = 30,
    top = 30,
    bottom = 10,
}

config.window_frame = {
    font = wezterm.font({ family = 'BlexMono Nerd Font', weight = 'Bold' }),
    font_size = 9,
}

config.default_prog = { 'pwsh.exe', '-NoLogo' }
config.default_domain = 'local'
config.wsl_domains = wezterm.default_wsl_domains()

-- powerline status bar from @alexpls
wezterm.on('update-status', function(window)
  local LEFT_ARROW = utf8.char(0xe0b2)
  local segs = {
    { text = wezterm.hostname(), color = "#83a598" }, 
  }
  
  local elements = {}
  local prev_bg = "none"
  for i, seg in ipairs(segs) do
    local bg = seg.color

    table.insert(elements, { Foreground = { Color = bg } })
    table.insert(elements, { Background = { Color = prev_bg } })
    table.insert(elements, { Text = LEFT_ARROW })

    table.insert(elements, { Background = { Color = bg } })
    table.insert(elements, { Foreground = { Color = "#282828" } })
    table.insert(elements, { Text = " " .. seg.text .. " " })

    prev_bg = bg
  end

  window:set_right_status(wezterm.format(elements))
end)



return config
