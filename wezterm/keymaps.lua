local wezterm = require("wezterm")

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
        key = 'h',
        mods = 'ALT|SHIFT',
        action = wezterm.action.SplitVertical {
            domain = "CurrentPaneDomain"
        },
    },

    {
        key = 'v',
        mods = 'ALT|SHIFT',
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

    -- close
    {
        key = 'q',
        mods = 'ALT',
        action = wezterm.action.CloseCurrentPane {
            confirm = false,
        },
    },
}

-- Alt+1 through Alt+9 switch tabs
for i = 1, 9 do
    table.insert(keys, {
        key = tostring(i),
        mods = "ALT",
        action = wezterm.action.ActivateTab(i - 1),
    })
end

return keys
