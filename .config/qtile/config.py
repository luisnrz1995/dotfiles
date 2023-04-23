# Imports.
import os
import subprocess
import time
from libqtile import bar, hook, layout, widget
from libqtile.config import Click, Drag, DropDown, Group, Key, Match, ScratchPad, Screen
from libqtile.lazy import lazy
from widgets import battery, brightness, clock, network, volume

# Autostart.
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])

# Keybindings.
keys = [
    # Move focus between windows
    Key(["mod4"], "h", lazy.layout.left(), desc="Move focus to left"),
    Key(["mod4"], "l", lazy.layout.right(), desc="Move focus to right"),
    Key(["mod4"], "j", lazy.layout.down(), desc="Move focus down"),
    Key(["mod4"], "k", lazy.layout.up(), desc="Move focus up"),
    Key(["mod4"], "space", lazy.layout.next(), desc="Move focus to the next window"),

    # Move windows between columns or stacks
    Key(["mod4", "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to left"),
    Key(["mod4", "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to right"),
    Key(["mod4", "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key(["mod4", "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Resize windows
    Key(["mod4", "mod1"], "i", lazy.layout.grow(), desc="Increase window size"),
    Key(["mod4", "mod1"], "d", lazy.layout.shrink(), desc="Decrease window size"),
    Key(["mod4", "mod1"], "n", lazy.layout.reset(), desc="Reset window size"),

    # Toggle floating window mode
    Key(["mod4", "shift"], "f", lazy.window.toggle_floating(), desc="Toggle floating mode"),

    # Change between layout
    Key(["mod4"], "Tab", lazy.next_layout(), desc="Switch to next layout"),
    Key(["mod4", "shift"], "Tab", lazy.prev_layout(), desc="Switch to previous layout"),

    # Close window
    Key(["mod4"], "w", lazy.window.kill(), desc="Kill focused window"),

    # Toggle the system tray widget
    Key(["mod4", "shift"], "s", lazy.widget["tray"].toggle(), desc="Toggle system tray widget"),

    # Reload and shutdown qtile
    Key(["mod4", "control"], "r", lazy.reload_config(), desc="Reload the qtile configuration file"),
    Key(["mod4", "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),

    # Launch terminal
    Key(["mod4"], "Return", lazy.spawn("alacritty --class 'alacritty'"), desc="Open a new alacritty terminal"),

    # Launch terminal
    Key(["mod4"], "p", lazy.spawn("dmenu_run -l 10 -i -p 'Run:'"), desc="Open the run prompt"),

    # Brightness control
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +5%"), desc="Increase brightness"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5%-"), desc="Decrease brightness"),

    # Audio control
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer -i 5"), desc="Increase volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer -d 5"), desc="Decrease volume"),
    Key([], "XF86AudioMute", lazy.spawn("pamixer -t"), desc="Mute audio"),

    # Application launchers
    Key(["mod4"], "b", lazy.spawn("brave"), desc="Launch web browser"),
    Key(["mod4"], "f", lazy.spawn("pcmanfm"), desc="Launch file manager"),
    Key(["mod4"], "r", lazy.spawn("alacritty --class=ranger --title=ranger -e ranger"), desc="Launch console file manager"),
    Key(["mod4"], "n", lazy.spawn("alacritty --class=nvim --title=nvim -e nvim"), desc="Launch console text editor"),

    # Take screenshots
    Key([], "Print", lazy.spawn("screenshot"), desc="Take full screenshot"),
    Key(["mod4"], "Print", lazy.spawn("screenshot --select"), desc="Take screenshot of selected area"),
    Key(["mod1"], "Print", lazy.spawn("screenshot --window"), desc="Take screenshot of active window"),

    # Lock screen
    Key(["mod4"], "period", lazy.spawn("slock"), desc="Lock screen"),

    # Custom scripts
    Key(["mod4", "mod1"], "k", lazy.spawn("dmkill"), desc="Kill process using dmenu"),
    Key(["mod4", "mod1"], "e", lazy.spawn("dmemoji"), desc="Insert emoji using dmenu"),
    Key(["mod4", "mod1"], "x", lazy.spawn("dmpower"), desc="Power off, reboot, or log out using dmenu"),

    # Redshift control
    Key(["mod4"], "XF86MonBrightnessUp", lazy.spawn("redshift LAT:LON"), desc="Start Redshift"),
    Key(["mod4"], "XF86MonBrightnessDown", lazy.spawn("pkill redshift"), desc="Stop Redshift"),
]

# Workspaces.
groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # Go to workspace.
            Key(
                ["mod4"],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),

            # Send window to workspace.
            Key(
                ["mod4", "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True), desc="Switch to & move focused window to group {}".format(i.name)
            ),

            # Move to the previous/next workspace (not empty).
            Key(["mod4"], "left", lazy.screen.prev_group(skip_empty=True), desc="Move to the previous non-empty workspace"),
            Key(["mod4"], "right", lazy.screen.next_group(skip_empty=True), desc="Move to the next non-empty workspace")
        ]
    )

# Scratchpads.
groups.append(ScratchPad("scratchpad", [
    DropDown("terminal", "alacritty --class 'alacritty'", width=0.7, height=0.7, x=0.15, y=0.15, opacity=0.9),
    DropDown("ranger", "alacritty --title=ranger -e ranger", width=0.7, height=0.7, x=0.15, y=0.15, opacity=0.9),
    DropDown("htop", "alacritty --title=htop -e htop", width=0.7, height=0.7, x=0.15, y=0.15, opacity=0.9),
    DropDown("cmus", "alacritty --title=cmus -e cmus", width=0.7, height=0.7, x=0.15, y=0.15, opacity=0.9)
]))

keys.extend([
    Key(["control", "mod1"], "t", lazy.group["scratchpad"].dropdown_toggle("terminal")),
    Key(["control", "mod1"], "r", lazy.group["scratchpad"].dropdown_toggle("ranger")),
    Key(["control", "mod1"], "h", lazy.group["scratchpad"].dropdown_toggle("htop")),
    Key(["control", "mod1"], "m", lazy.group["scratchpad"].dropdown_toggle("cmus"))
])

# Colors.
colors = [
    "#282828",
    "#444444",
    "#bbbbbb",
    "#434C5E"

]

# Layouts.
layouts = [
    layout.MonadTall(
        border_focus=colors[3],
        border_normal=colors[0],
        border_width=1,
        margin=2,
        name="[]=",
        ratio=0.5
    ),
    layout.Floating(
        border_focus=colors[3],
        name="[floating]="
    ),
    layout.Max(
        border_focus=colors[3],
        border_width=1,
        margin=2,
        name="[M]="
    )
]

def network_manager():
    qtile.cmd_spawn('connman-gtk --tray')

# Widgets.
def primary_widgets():
    return [
        widget.GroupBox(
            active=colors[2],
            borderwidth=0,
            hide_unused=True,
            highlight_method="block",
            inactive=colors[2],
            margin_y=4,
            padding_x=7,
            rounded=False,
            this_current_screen_border=colors[3]
        ),
        widget.CurrentLayout(
            fmt="{}",
            margin_y=0,
            padding=5
        ),
        widget.WindowName(
            format="{name}"
        ),
        widget.Sep(
            background=colors[0],
            foreground=colors[0],
            linewidth=2
        ),
        widget.GenPollText(
            background=colors[0],
            fmt="{}",
            fontsize=12.5,
            func=network.network,
            mouse_callbacks={'Button1': network_manager},
            name="network",
            padding=1,
            update_interval=0.01
        ),
        widget.TextBox(
            background=colors[0],
            padding=5,
            text="|"
        ),
        widget.GenPollText(
            background=colors[0],
            fmt="{}",
            fontsize=12.5,
            func=battery.battery,
            padding=1,
            update_interval=0.01
        ),
        widget.TextBox(
            background=colors[0],
            padding=5,
            text="|"
        ),
        widget.GenPollText(
            background=colors[0],
            fmt="{}",
            fontsize=12.5,
            func=volume.volume,
            padding=1,
            update_interval=0.01
        ),
        widget.TextBox(
            background=colors[0],
            padding=5,
            text="|"
        ),
        widget.GenPollText(
            background=colors[0],
            fmt="{}",
            fontsize=12.5,
            func=brightness.brightness,
            padding=1,
            update_interval=0.01
        ),
        widget.TextBox(
            background=colors[0],
            padding=5,
            text="|"
        ),
        widget.GenPollText(
            background=colors[0],
            fmt="{}",
            fontsize=12.5,
            func=clock.clock,
            padding=1,
            update_interval=0.01
        ),
        widget.WidgetBox(
            widgets=[
                widget.Systray(
                    icon_size=14,
                    padding=4
                )
            ],
            name="tray",
            text_closed="",
            text_open=""
        ),
        widget.Sep(
            background=colors[0],
            foreground=colors[0],
            linewidth=2
        )
    ]

widget_defaults = dict(
    background=colors[0],
    font="FiraCode Nerd Font",
    fontsize=12,
    padding=3,
    foreground=colors[2]
)
extension_defaults = widget_defaults.copy()

# Screens
screens = [
    Screen(
        top=bar.Bar(
            [
                *primary_widgets()
            ],
            22,
            border_width=[-1, 0, 0, -2]
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(["mod4"], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag(["mod4"], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click(["mod4"], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

# floating windows rules.
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of 'xprop' to see the program properties.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="Connman-gtk"),  # connman-gtk
        Match(wm_class="Galculator"),  # galculator
        Match(wm_class="KeePassXC"),  # keepassxc
        Match(wm_class="Pavucontrol"),  # pavucontrol
        # Match(wm_class="SimpleScreenRecorder"),
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(title="Free Download Manager"),  # Free Download Manager
    ],
    border_focus=colors[3],
    border_normal=colors[0]
)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
wmname = "qtile"
