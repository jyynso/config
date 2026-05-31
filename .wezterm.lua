local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local initial_cols = 78
local initial_rows = 23

config.default_prog = { 'pwsh.exe', '-NoLogo' }
config.color_scheme = 'GruvboxDark' 
config.font_size = 12
config.hide_tab_bar_if_only_one_tab = true
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_decorations = "RESIZE"
config.font = wezterm.font({ family = "BlexMono Nerd Font" })
config.front_end = "WebGpu"
config.animation_fps = 60
config.window_background_opacity = 0.85
config.initial_cols = initial_cols
config.initial_rows = initial_rows
config.window_padding = {
    left = 30,
    right = 30,
    top = 30,
    bottom = 30,
}

onfig.keys = {
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
}

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local title = tab.active_pane.title

    if title == 'pwsh.exe' then
        title = 'pwsh'
    end

    return {
        { Text = ' ' .. title .. ' ' },
    }
end)

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



return config