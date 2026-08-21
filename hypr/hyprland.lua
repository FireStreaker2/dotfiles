---@module 'hl'
hl.monitor({
    output = "",
    mode = "highres",
    position = "auto",
    scale = "auto"
})

-- environment variables

hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GDK_SCALE", 2)
hl.env("GTK_THEME", "Blue")
hl.env("XCURSOR_THEME", "GawrGura")
hl.env("XCURSOR_SIZE", 32)
hl.env("HYPRCURSOR_THEME", "GawrGuraHypr")
hl.env("HYPRCURSOR_SIZE", 32)

-- autostart

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("swaybg -m fill -i ~/Pictures/wallpaper2.png")
end)

-- system config

hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        touchpad = {
            natural_scroll = true
        },
        sensitivity = 0
    }
})

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 20,
        border_size = 2,
        layout = "dwindle",
        col = {
            active_border = {
                colors = {"rgba(33ccffee)", "rgba(0099cccc)"},
                angle = 45
            },
            inactive_border = "rgba(33ccffee)"
        }
    }
})

hl.config({
    misc = {
        disable_hyprland_logo = true
    }
})

hl.config({
    decoration = {
        rounding = 10,
        blur = {
            enabled = true,
            size = 7,
            passes = 3
        },
        shadow = {
            color = "rgba(1a1a1aee)"
        }
    }
})

hl.curve("myBezier", {
    type = "bezier",
    points = {{0.05, 0.9}, {0.1, 1.05}}
})
hl.config({
    animations = {
        enabled = true
    }
})
hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 7,
    bezier = "myBezier"
})
hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 7,
    bezier = "myBezier",
    style = "popin 80%"
})

hl.config({
    dwindle = {
        preserve_split = true
    }
})

hl.config({
    master = {
        new_status = "master"
    }
})

hl.config({
    xwayland = {
        force_zero_scaling = true
    }
})

-- window rules

hl.window_rule({
    match = {
        class = "^(code-url-handler|code|discord|vesktop|jetbrains-studio|Spotify)$"
    },
    opacity = "0.9 0.9"
})

hl.window_rule({
    match = {
        class = "^(kitty|thunar)$"
    },
    opacity = "0.8 0.8"
})

hl.window_rule({
    match = {
        class = "^(xdg-desktop-portal-gtk)$"
    },
    float = true,
    move = {10, 10},
    size = {800, 600}
})

-- keybinds

local mainMod = "SUPER"

hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("wofi"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("wlogout -b 5 -T 300 -B 300"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + escape", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + escape", hl.dsp.window.kill())
hl.bind(mainMod .. " + tab", hl.dsp.window.float())
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("grim -g \"$(slurp -b 00000000 -c 00000000)\" - | swappy -f -"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind("Print", hl.dsp.exec_cmd("grim - | wl-copy && notify-send \"Screenshot Taken!\""))

for _, direction in ipairs({"left", "right", "up", "down"}) do
    hl.bind(mainMod .. " + " .. direction, hl.dsp.focus({
        direction = direction
    }))
end

for i = 1, 10 do
    local key = i == 10 and 0 or i

    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({
        workspace = i
    }))
end

for i = 1, 10 do
    local key = i == 10 and 0 or i

    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({
        workspace = i
    }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({
    workspace = "e+1"
}))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({
    workspace = "e-1"
}))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), {
    mouse = true
})
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), {
    mouse = true
})

local resizeDirections = {
    left = {
        x = -50,
        y = 0
    },
    right = {
        x = 50,
        y = 0
    },
    up = {
        x = 0,
        y = -50
    },
    down = {
        x = 0,
        y = 50
    }
}

for direction, size in pairs(resizeDirections) do
    hl.bind(mainMod .. " + SHIFT + " .. direction, hl.dsp.window.resize({
        x = size.x,
        y = size.y,
        relative = true
    }))
end

hl.bind("SUPER + R", hl.dsp.exec_cmd("hyprctl keyword general:layout \"dwindle\""))
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("hyprctl keyword general:layout \"master\""))
hl.bind("SUPER + apostrophe", hl.dsp.layout("swapwithmaster master"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), {
    locked = true
})
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness +10"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness -10"))

hl.bind("SUPER + V", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))
hl.bind("SUPER + PERIOD", hl.dsp.exec_cmd("wofi-emoji"))
