-- Pull in wezterm api
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action
local mux = wezterm.mux

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font", {weight = 'Regular'})
config.font_size = 14

-- Window decorations and general settings
config.window_background_opacity = 0.9
config.color_scheme = "Catppuccin Macchiato"
config.audible_bell = "Disabled"
wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

config.keys = {}

-- Multiplexing
----------------
-- Leader
config.leader = {
    key = 'a',
    mods = 'CTRL',
    timemout_milliseconds = 2000,
}

-- Scrollback, select and copy
table.insert(config.keys,
{
    key = '[',
    mods = 'LEADER',
    action = act.ActivateCopyMode,
})

-- Zooming
----------
-- Gives a bit more room to give a certain pane more visual room
table.insert(config.keys,
{
    key = 'f',
    mods = 'ALT',
    action = act.TogglePaneZoomState,
})

-- Tabs/windows
----------------
config.tab_bar_at_bottom = true -- Move tabs to bottom
config.use_fancy_tab_bar = true -- Make it look more like tabs with better navigation
config.tab_max_width = 32 -- Don't let any single tab be too huge
config.switch_to_last_active_tab_when_closing_tab = true -- What it says on the tin

-- Create new tab
table.insert(config.keys,
{
    key = 't',
    mods = 'LEADER',
    action = act.SpawnTab 'CurrentPaneDomain',
})

-- Tab navigation
-- n (next) and p (previous)
table.insert(config.keys,
{
    key = '>',
    mods = 'LEADER|SHIFT',
    action = act.ActivateTabRelative(1),
})

table.insert(config.keys,
{
    key = '<',
    mods = 'LEADER|SHIFT',
    action = act.ActivateTabRelative(-1),
})

-- name tabs
table.insert(config.keys,
{
    key = ',',
    mods = 'LEADER',
    action = act.PromptInputLine {
        description = 'Enter new name for tab',
        action = wezterm.action_callback
        (
            function(window, pane, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end
        ),
    },
})

-- Index-based tab navigation
table.insert(config.keys,
{
    key = 'e',
    mods = 'LEADER',
    action = act.ShowTabNavigator,
})

-- Close current tab
table.insert(config.keys,
{
    key = 'w',
    mods = 'LEADER',
    action = act.CloseCurrentTab { confirm = true },
})

-- Multiplexer integration for nvim
local function is_vim(pane)
    -- set by plugin, unset on ExitPre in neovim
    return pane:get_user_vars().IS_NVIM == 'true'
end

local direction_keys = {
    h = 'Left',
    j = 'Down',
    k = 'Up',
    l = 'Right',
}

local function split_nav(resize_or_move, key)
    return {
        key = key,
        mods = resize_or_move == 'resize' and 'META' or 'CTRL',
        action = wezterm.action_callback(function(win, pane)
            if is_vim(pane) then
                win:perform_action({
                    SendKey = { key = key, mods = resize_or_move == 'resize' and 'META' or 'CTRL' },
                }, pane)
            else
                if resize_or_move == 'resize' then
                    win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
                else
                    win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
                end
            end
        end),
    }
end

-- move between panes
table.insert(config.keys, split_nav('move', 'h'))
table.insert(config.keys, split_nav('move', 'j'))
table.insert(config.keys, split_nav('move', 'k'))
table.insert(config.keys, split_nav('move', 'l'))

-- resize panes
table.insert(config.keys, split_nav('resize', 'h'))
table.insert(config.keys, split_nav('resize', 'j'))
table.insert(config.keys, split_nav('resize', 'k'))
table.insert(config.keys, split_nav('resize', 'l'))

-- Splitting panes
-- vertical
table.insert(config.keys,
{
    key = '|',
    mods = 'LEADER|SHIFT',
    action = act.SplitPane {
        direction = 'Right',
        size = { Percent = 50 },
    },
})

-- horizontal
table.insert(config.keys,
{
    key = '_',
    mods = 'LEADER|SHIFT',
    action = act.SplitPane {
        direction = 'Down',
        size = { Percent = 50 },
    },
})

-- close pane
table.insert(config.keys,
{
    key = 'x',
    mods = 'LEADER',
    action = act.CloseCurrentPane { confirm = true },
})

-- reposition pane
table.insert(config.keys,
{
    key = '{',
    mods = 'LEADER|SHIFT',
    action = act.PaneSelect { mode = 'SwapWithActiveKeepFocus' }
})

table.insert(config.keys,
{
    key = '{',
    mods = 'LEADER|SHIFT',
    action = act.PaneSelect { mode = 'SwapWithActiveKeepFocus' }
})

-- select pane
table.insert(config.keys,
{
    key = 'p',
    mods = 'LEADER',
    action = act.PaneSelect { mode = 'Activate' }
})

return config
