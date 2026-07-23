local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.keys = require("keymaps")

config.color_scheme = 'GruvboxDark' 
config.font_size = 12
config.initial_cols = 100
config.initial_rows = 25
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = true
config.window_decorations = "RESIZE"
config.font = wezterm.font({ family = "BlexMono Nerd Font" })
config.front_end = "WebGpu"
config.window_background_opacity = 0.85

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

-- powerline status bar, referenced from @alexpls
wezterm.on('update-status', function(window)
  local LEFT_ARROW = utf8.char(0xe0b2)
  window:set_right_status(wezterm.format({
    { Foreground = { Color = "#83a598" } },
    { Background = { Color = "none" } },
    { Text = LEFT_ARROW },

    { Background = { Color = "#83a598" } },
    { Foreground = { Color = "#282828" } },
    { Text = " " .. wezterm.hostname() .. " " },
  }))
end)


return config