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

local shells = { pwsh = true, powershell = true, cmd = true }

local function is_shell(title)
  local name = title:match("([^/\\]+)$") or title
  name = name:gsub("%.exe$", ""):lower()
  return shells[name]
end

local function get_cwd_breadcrumb(pane)
  local cwd = pane.current_working_dir
  if not cwd then return nil end

  local path = cwd.file_path:gsub("[/\\]+$", "")
  local breadcrumb = path:match("([^/\\]+[/\\][^/\\]+)$") or path:match("([^/\\]+)$")
  return breadcrumb and breadcrumb:gsub("\\", "/")
end

local function get_clean_title(tab)
  if tab.tab_title and #tab.tab_title > 0 then
    return tab.tab_title
  end

  local pane = tab.active_pane
  if pane.title ~= "" and not is_shell(pane.title) then
    return (pane.title:gsub("%.exe$", ""))
  end

  return get_cwd_breadcrumb(pane) or "pwsh"
end

local function get_process_name(pane)
  local mux_pane = wezterm.mux.get_pane(pane.pane_id)
  local info = mux_pane and mux_pane:get_foreground_process_info()
  if not info then return "" end

  local function newest_leaf(node)
    local newest
    for _, child in pairs(node.children or {}) do
      if not newest or child.start_time > newest.start_time then
        newest = child
      end
    end
    return newest and newest_leaf(newest) or node
  end

  local name = newest_leaf(info).name or ""
	wezterm.log_error(name)
  return (name:gsub("%.exe$", ""))
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
