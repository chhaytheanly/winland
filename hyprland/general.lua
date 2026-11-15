-- Monitors
hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "auto",
    scale    = 1.25,
})

-- Input
hl.config({
    input = {
        kb_layout  = "us, kh",
        kb_options = "grp:alt_shift_toggle",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = {
            disable_while_typing = true,
            natural_scroll       = true,
            tap_to_click         = true,
        },
    },
})

-- Windows 11 Color Palette (Light Mode)
local c = {
    bg         = 0xfff3f3f3,
    surface    = 0xffe8e8e8,
    surface2   = 0xffd1d1d1,
    border     = 0xffcccccc,
    accent     = 0xff0078d4,
    accent_hov = 0xff60cdff,
    text       = 0xff1a1a1a,
    text2      = 0xff666666,
    error      = 0xffc42b1c,
}

-- Look and Feel
hl.config({
    general = {
        layout      = "dwindle",
        gaps_in     = 4,
        gaps_out    = 8,
        border_size = 1,
        col = {
            active_border   = c.accent,
            inactive_border = c.border,
        },
    },
    decoration = {
        rounding = 8,
        active_opacity = 0.90,
        inactive_opacity = 0.80,
        fullscreen_opacity = 1.0,
        blur = {
            enabled   = true,
            size      = 12,
            passes    = 4,
            vibrancy  = 0.1696,
            ignore_opacity = true,
        },
        shadow = {
            enabled      = true,
            range        = 20,
            render_power = 3,
            color        = 0x80000000,
        },
    },
    animations = {
        enabled = true,
    },
    misc = {
        disable_hyprland_logo = true,
        force_default_wallpaper = 0,
    },
    xwayland = {
        force_zero_scaling = true,
    },
})

-- Layouts
hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
})

-- Resize on Border
hl.config({
    general = {
        resize_on_border       = true,
        extend_border_grab_area = 15,
        hover_icon_on_border   = true,
    },
})

-- Gestures
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

hl.config({
    gestures = {
        workspace_swipe_distance = 300,
        workspace_swipe_invert   = true,
    },
})

-- Animations - Win11 feel
-- Smooth deceleration (like Win11 window open/close)
hl.curve("win11Ease",    { type = "bezier", points = { {0.16, 1.0}, {0.3, 1.0} } })
-- Spring overshoot for workspace switches
hl.curve("win11Spring",  { type = "bezier", points = { {0.34, 1.56}, {0.64, 1.0} } })
-- Fast snap for small UI elements
hl.curve("win11Snap",    { type = "bezier", points = { {0.4, 0.0},  {0.2, 1.0} } })
-- Windows open: slide in + fade, fast deceleration like Win11 maximize
hl.animation({ leaf = "windowsIn",  enabled = true, speed = 5, bezier = "win11Ease",   style = "slide" })
-- Windows close: quick popin shrink
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "win11Snap",   style = "popin 80%" })
-- Window move/resize: spring feel
hl.animation({ leaf = "windows",    enabled = true, speed = 5, bezier = "win11Ease" })
-- Border color transition
hl.animation({ leaf = "border",     enabled = true, speed = 8, bezier = "win11Snap" })
-- Fade in/out
hl.animation({ leaf = "fade",       enabled = true, speed = 4, bezier = "win11Ease" })
-- Workspace slide: spring bounce
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "win11Spring" })
-- Layers (waybar, rofi) slide up from bottom
hl.animation({ leaf = "layers",     enabled = true, speed = 4, bezier = "win11Ease",   style = "slide" })

-- Window Rules
hl.window_rule({
    name  = "float-pavucontrol",
    match = { class = "^pavucontrol$" },
    float = true,
    size  = {"900", "650"},
})

hl.window_rule({
    name   = "Wifi-tui",
    match  = { class = "^wifi-tui$" },
    float  = true,
    size   = {"1000", "650"},
    center = true,
})

-- Win11-style window rules
hl.window_rule({
    name  = "float-file-manager",
    match = { class = "^org.gnome.Nautilus$" },
    float = true,
    size  = {"900", "600"},
    center = true,
})

hl.window_rule({
    name  = "float-settings",
    match = { class = "^gnome-control-center$" },
    float = true,
    size  = {"900", "600"},
    center = true,
})

hl.window_rule({
    name  = "float-calc",
    match = { class = "^org.gnome.Calculator$" },
    float = true,
    size  = {"350", "500"},
    center = true,
})

hl.window_rule {
    name = "float-alacritty",

    match = {
        class = "^Alacritty$",
    },

    float = true,
    size = { "800", "600" },
    center = true,

    opacity = 0.95,
}