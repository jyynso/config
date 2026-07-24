local wezterm = require("wezterm")

local config_leader = {
    key = "a",
    mods = "ALT",
    timeout_milliseconds = 1000,
}

local keys = {
    {
        key = 'f',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SpawnTab {
            DomainName = 'WSL:FedoraLinux-44'
        },
    },
    {
        key = 't',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SpawnTab {
            DomainName = 'local'
        },
    },

    -- splits
    {
        key = 'v',
        mods = 'LEADER',
        action = wezterm.action.SplitVertical {
            domain = "CurrentPaneDomain"
        },
    },
    {
        key = 'h',
        mods = 'LEADER',
        action = wezterm.action.SplitHorizontal {
            domain = "CurrentPaneDomain"
        },
    },

    -- navigation
    {
        key = 'h',
        mods = 'ALT',
        action = wezterm.action.ActivatePaneDirection "Left",
    },
    {
        key = 'j',
        mods = 'ALT',
        action = wezterm.action.ActivatePaneDirection "Down",
    },
    {
        key = 'k',
        mods = 'ALT',
        action = wezterm.action.ActivatePaneDirection "Up",
    },
    {
        key = 'l',
        mods = 'ALT',
        action = wezterm.action.ActivatePaneDirection "Right",
    },

    -- resize pane
    {
	key = 'h',
	mods = 'LEADER|SHIFT',
	action = wezterm.action.AdjustPaneSize { "Left", 5 },
    },
    {
	key = 'j',
	mods = 'LEADER|SHIFT',
	action = wezterm.action.AdjustPaneSize { "Down", 5 },
    },
    {
	key = 'k',
	mods = 'LEADER|SHIFT',
	action = wezterm.action.AdjustPaneSize { "Up", 5 },
    },
    {
	key = 'l',
	mods = 'LEADER|SHIFT',
	action = wezterm.action.AdjustPaneSize { "Right", 5 },
    },

    -- close
    {
        key = 'q',
        mods = 'ALT',
        action = wezterm.action.CloseCurrentPane {
            confirm = false,
        },
    },
}

-- switch tabs
for i = 1, 9 do
    table.insert(keys, {
        key = tostring(i),
        mods = "ALT",
        action = wezterm.action.ActivateTab(i - 1),
    })
end

return { keys = keys, leader = config_leader }
