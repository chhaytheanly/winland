hl.config({
    binds = {
        workspace_back_and_forth = true,
    },
})

local mod = "SUPER"

-- Terminal
hl.bind(mod .. " + Return", hl.dsp.exec_cmd("alacritty"))

-- Start Menu (SUPER key alone toggles rofi)
hl.bind(mod, hl.dsp.exec_cmd("rofi -show drun -show-icons"))
hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd("rofi -show drun -show-icons"))

-- Window management
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + P", hl.dsp.window.pseudo())

-- Win11 snap layouts (left/right half)
hl.bind(mod .. " + left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move windows
hl.bind(mod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "d" }))

-- Exit / reload
hl.bind(mod .. " + SHIFT + E", hl.dsp.exit())
hl.bind(mod .. " + CTRL + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mod .. " + CTRL + B",  hl.dsp.exec_cmd("killall waybar"))
hl.bind(mod .. " + SHIFT + B", hl.dsp.exec_cmd("waybar -c ~/.config/hypr/waybar/config -s ~/.config/hypr/waybar/style.css &"))

-- Workspaces 1-10
for i = 1, 10 do
    local key = i % 10
    hl.bind(mod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- logout

hl.bind(mod .. " + L ", hl.dsp.exec_cmd("hyprlock &"))

-- Wallpapers
hl.bind(mod .. " + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper.sh"))

-- Mouse workspace switching
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Mouse move/resize
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshot (Win11-style: Print key)
hl.bind("Print", hl.dsp.exec_cmd("sh -c 'grim -g \"$(slurp)\" - | wl-copy'"))

-- Control Center / Notifications
hl.bind(mod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- Audio
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh up"),   { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh down"), { repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh mute"))
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))

-- Brightness
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh up"),   { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh down"), { repeating = true })
