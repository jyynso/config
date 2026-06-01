local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local initial_cols = 78
local initial_rows = 19

-- appearance
config.color_scheme = 'GruvboxDark' 
config.font_size = 11
config.hide_tab_bar_if_only_one_tab = false
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 600
config.window_decorations = "RESIZE"
config.font = wezterm.font({ family = "BlexMono Nerd Font" })
config.front_end = "WebGpu"
config.animation_fps = 60
config.window_background_opacity = 0.80
config.initial_cols = initial_cols
config.initial_rows = initial_rows

config.window_padding = {
    left = 30,
    right = 30,
    top = 30,
    bottom = 30,
}

config.window_frame = {
    font = wezterm.font({ family = 'BlexMono Nerd Font', weight = 'Bold' }),
    font_size = 11,
}

-- default shell 
config.default_prog = { 'pwsh.exe', '-NoLogo' }

-- keybinds
config.keys = {
    {
        key = 'f',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SpawnCommandInNewTab {
            args = { 
                'wsl.exe',
                '-d',
                'FedoraLinux-44',
                '--cd',
                '~'
            },
        },
    },

    {
        key = 'v',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
    },

    {
        key = 'h',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
    },

    {
        key = 'LeftArrow',
        mods = 'ALT',
        action = wezterm.action.ActivatePaneDirection "Left"
    },

    {
        key = 'RightArrow',
        mods = 'ALT',
        action = wezterm.action.ActivatePaneDirection "Right"
    },

     {
        key = 'UpArrow',
        mods = 'ALT',
        action = wezterm.action.ActivatePaneDirection "Up"
    },

    {
        key = 'DownArrow',
        mods = 'ALT',
        action = wezterm.action.ActivatePaneDirection "Down"
    },

    {
        key = 'q',
        mods = 'ALT',
        action = wezterm.action.CloseCurrentPane { confirm = false },
    }
}


-- shows pwsh on the tab instead of full path
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local title = tab.active_pane.title

    if title == 'pwsh.exe' then
        title = 'pwsh'
    end

    return {
        { Text = ' ' .. title .. ' ' },
    }
end)

-- center window on launch only works for 125% scale :(
wezterm.on('gui-startup', function(cmd)
    local screen = wezterm.gui.screens().main
    cmd = cmd or {}
    local estimated_width = 960
    local estimated_height = 624

    cmd.position = {
        x = math.floor((screen.width - estimated_width) / 2),
        y = math.floor((screen.height - estimated_height) / 2),
    }

    wezterm.mux.spawn_window(cmd)
end)

-- powerline status bar from @alexpls
wezterm.on('update-status', function(window)
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  local segs = {
    { text = wezterm.strftime('%H:%M'), color = "#fabd2f" }, 
    { text = wezterm.hostname(), color = "#83a598" }, 
  }
  
  local elements = {}
  local prev_bg = "none"
  for i, seg in ipairs(segs) do
    local bg = seg.color

    table.insert(elements, { Foreground = { Color = bg } })
    table.insert(elements, { Background = { Color = prev_bg } })
    table.insert(elements, { Text = SOLID_LEFT_ARROW })

    table.insert(elements, { Background = { Color = bg } })
    table.insert(elements, { Foreground = { Color = "#282828" } })
    table.insert(elements, { Text = " " .. seg.text .. " " })

    prev_bg = bg
  end

  window:set_right_status(wezterm.format(elements))
end)

return config