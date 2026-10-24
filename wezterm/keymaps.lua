local wezterm = require("wezterm")
local act = wezterm.action

local config_leader = {
    key = "a",
    mods = "ALT",
    timeout_milliseconds = 1000,
}

local keys = {
    -- spawn tabs
    {
        key = "f",
        mods = "CTRL|SHIFT",
        action = act.SpawnTab { DomainName = "WSL:FedoraLinux-44" },
    },
    {
        key = "t",
        mods = "CTRL|SHIFT",
        action = act.SpawnTab { DomainName = "local" },
    },

    -- splits
    {
        key = "v",
        mods = "LEADER",
        action = act.SplitVertical { domain = "CurrentPaneDomain" },
    },
    {
        key = "h",
        mods = "LEADER",
        action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
    },

    -- pane navigation
    {
        key = "h",
        mods = "ALT",
        action = act.ActivatePaneDirection "Left",
    },
    {
        key = "j",
        mods = "ALT",
        action = act.ActivatePaneDirection "Down",
    },
    {
        key = "k",
        mods = "ALT",
        action = act.ActivatePaneDirection "Up",
    },
    {
        key = "l",
        mods = "ALT",
        action = act.ActivatePaneDirection "Right",
    },

    -- sequential tab switching
    {
        key = "h",
        mods = "ALT|SHIFT",
        action = act.ActivateTabRelative(-1),
    },
    {
        key = "l",
        mods = "ALT|SHIFT",
        action = act.ActivateTabRelative(1),
    },

    -- resize pane
    {
        key = "h",
        mods = "CTRL|SHIFT",
        action = act.AdjustPaneSize { "Left", 5 },
    },
    {
        key = "j",
        mods = "CTRL|SHIFT",
        action = act.AdjustPaneSize { "Down", 5 },
    },
    {
        key = "k",
        mods = "CTRL|SHIFT",
        action = act.AdjustPaneSize { "Up", 5 },
    },
    {
        key = "l",
        mods = "CTRL|SHIFT",
        action = act.AdjustPaneSize { "Right", 5 },
    },

    -- close pane
    {
        key = "q",
        mods = "ALT",
        action = act.CloseCurrentPane { confirm = false },
    },
}

-- switch tabs by number (Alt + 1-9)
for i = 1, 9 do
    table.insert(keys, {
        key = tostring(i),
        mods = "ALT",
        action = act.ActivateTab(i - 1),
    })
end

return { keys = keys, leader = config_leader }