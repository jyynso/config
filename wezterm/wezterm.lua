local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local keymaps = require("keymaps")

config.keys = keymaps.keys
config.leader = keymaps.leader

config.color_scheme = 'GruvboxDark' 
config.font_size = 11
config.initial_cols = 90
config.initial_rows = 23
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = true
config.window_decorations = "RESIZE"
config.font = wezterm.font({ family = "BlexMono Nerd Font" })
config.window_close_confirmation = 'NeverPrompt'
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

config.inactive_pane_hsb = {
    saturation = 0.7,
    brightness = 0.7,
}

config.default_prog = { 'pwsh.exe', '-NoLogo' }
config.default_domain = 'local'
config.wsl_domains = wezterm.default_wsl_domains()

local function get_clean_title(tab)
  local title = tab.tab_title
  if title and #title > 0 then
    return title
  end

  local pane = tab.active_pane
  local cwd_uri = pane.current_working_dir

  if cwd_uri then
    local path = cwd_uri.file_path

    path = path:gsub("[/\\]+$", "")

    local breadcrumb = path:match("([^/\\]+[/\\][^/\\]+)$")

    if breadcrumb then
      return breadcrumb:gsub("\\", "/")
    else
      local single_folder = path:match("([^/\\]+)$")
      if single_folder then
        return single_folder
      end
    end
  end

  local process_name = pane.foreground_process_name or ""
  local clean_process = process_name:gsub("(.*[/\\])(.*)", "%2")
  return clean_process ~= "" and clean_process or "pwsh"
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local title = get_clean_title(tab)
  return {
    { Text = " " .. (tab.tab_index + 1) .. ": " .. title .. " " },
  }
end)

-- powerline status bar, referenced from @alexpls
wezterm.on('update-status', function(window)
  local arrow = utf8.char(0xe0b2)
  window:set_right_status(wezterm.format({
    { Foreground = { Color = "#83a598" } },
    { Background = { Color = "none" } },
    { Text = arrow },

    { Background = { Color = "#83a598" } },
    { Foreground = { Color = "#282828" } },
    { Text = " " .. wezterm.hostname() .. " " },
  }))
end)

return config
