import os
import socket
import subprocess
from datetime import datetime
from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook

mod     =   "mod1"
win     =   "mod4"
myTerm  =   "xterm"
wmname  =   "LG3D"
colors  =   ["#6F9FE3","#222D32","#FFFFFF","#002b36"]

layout_theme={"border_width": 2,
            "margin": 2,
            "border_focus": colors[0],
            "border_normal":colors[1]
            }

widget_defaults = dict(
    font='Arial',
    fontsize=17,
    padding=3,
)

def iAdjust_float(client,screen,rmin=1./5,rmax=1./1.5):
    # Adjust the size
    client.width=int(max(min(client.width,screen.width*rmax),screen.width*rmin))
    client.height=int(max(min(client.height,screen.height*rmax),screen.height*rmin))
    center_x = screen.x + screen.width / 2
    center_y = screen.y + screen.height / 2

    ratio=0.618
    if client.height/client.width<ratio:
        client.height=client.width*ratio
    elif client.width/client.height<ratio:
        client.width=client.height*ratio
    x = int(center_x - client.width / 2)
    y = int(center_y - client.height / 2)
    client.x = int(round(x))
    client.y = int(round(y))
    return

def itoggFloat():
    @lazy.function
    def __inner(qtile):
        window=qtile.current_window
        screen=qtile.current_screen
        if window.floating:
            window.cmd_toggle_floating()
        else:
            iAdjust_float(window,screen,1./1.5,1./1.2)
            window.cmd_set_position_floating(window.x,window.y)
            window.cmd_set_size_floating(window.width,window.height)
    return __inner

def iSwindowH():
    @lazy.function
    def __inner(qtile):
        window=qtile.current_window
        if window.floating:
            window.cmd_move_floating(-10,0)
        else:
            layout=qtile.current_group.layout
            layout.cmd_shuffle_left()
    return __inner

def iSwindowL():
    @lazy.function
    def __inner(qtile):
        window=qtile.current_window
        if window.floating:
            window.cmd_move_floating(10,0)
        else:
            layout=qtile.current_group.layout
            layout.cmd_shuffle_right()
    return __inner

def iSwindowJ():
    @lazy.function
    def __inner(qtile):
        window=qtile.current_window
        if window.floating:
            window.cmd_move_floating(0,10)
        else:
            layout=qtile.current_group.layout
            layout.cmd_shuffle_down()
    return __inner

def iSwindowK():
    @lazy.function
    def __inner(qtile):
        window=qtile.current_window
        if window.floating:
            window.cmd_move_floating(0,-10)
        else:
            layout=qtile.current_group.layout
            layout.cmd_shuffle_up()
    return __inner

def iWinSwap():
    @lazy.function
    def __inner(qtile):
        group=qtile.current_group
        group.cmd_next_window()
        window=qtile.current_window
        if window.floating:
            window.cmd_bring_to_front()
    return __inner

keys = [
    # Sound control
    Key([], "XF86AudioMute",
        lazy.spawn("pactl set-sink-mute 0 toggle")
    ),
    #Microphone control
    Key([], "XF86AudioMicMute",
        lazy.spawn("pactl set-source-mute 1 toggle")
    ),
    Key([], "XF86WLAN",
        lazy.spawn("netTogg")
    ),
    Key([], "XF86Tools",
        lazy.spawn('xdg-open /home/xiangchong/.config/qtile/config.py')
    ),
    Key(
        [win], "m",
        lazy.next_layout()
    ),
    Key([win],"n",itoggFloat()),

    # Move windows in current stack
    Key([win, "shift"], "j",iSwindowJ()),
    Key([win, "shift"], "k",iSwindowK()),
    Key([win, "shift"], "h",iSwindowH()),
    Key([win, "shift"], "l",iSwindowL()),

    # Adjust size of windows
    Key([win, "control"], "l",
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        # lazy.layout.grow_right(),
        # lazy.layout.delete(),
        ),
    Key([win, "control"], "h",
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        # lazy.layout.grow_left(),
        # lazy.layout.add(),
        ),
    # Key([win, "control"], "k",
    #     lazy.layout.grow_up(),
    #     lazy.layout.grow(),
    #     lazy.layout.decrease_nmaster(),
    #     ),
    # Key([win, "control"], "j",
    #     lazy.layout.grow_down(),
    #     lazy.layout.shrink(),
    #     lazy.layout.increase_nmaster(),
    #     ),

    # Switch between windows in current stack pane
    Key([win], "j", lazy.layout.down()),
    Key([win], "k", lazy.layout.up()),
    Key([win], "h", lazy.layout.left()),
    Key([win], "l", lazy.layout.right()),
    Key([win], "Tab",iWinSwap()),
    Key([win], "f", lazy.window.bring_to_front()),


    # Lunch useful softwares
    Key([mod, "control"], "t", lazy.spawn('localTerm')),
    Key([mod, "control"], "w", lazy.spawn('firefox')),
    Key([mod, "control"], "m", lazy.spawn('thunderbird')),
    Key([mod, "control"], "f", lazy.spawn('exploreLocal')),
    Key([mod, "control"], "n", lazy.spawn('nm-connection-editor')),
    Key([mod, "control"], "Return",
        lazy.spawn("dmenu_run -i -fn %s -p dmenu: "
        %(widget_defaults['font']))
        ),
    Key([mod], "p", lazy.spawn('snapShot')),
    Key([mod], "v", lazy.spawn('recordClipBoard')),
    Key([mod], "F4", lazy.window.kill()),
    # Brightness control
    Key([mod], 'k',
        lazy.spawn('xbacklight -inc 8')
    ),
    Key([mod], 'j',
        lazy.spawn('xbacklight -dec 8')
    ),
    # Sound control
    Key([mod], 'l',
        lazy.spawn("pulseaudio-ctl up")
    ),
    Key([mod], 'h',
        lazy.spawn("pulseaudio-ctl down")
    ),
    Key([mod, "control"], "x", lazy.window.kill()),
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.spawn('leavePC')),
]

groups = [Group(i) for i in 'asdfbqwer']


def go_to_group(gn):
    @lazy.function
    def __inner(qtile):
        if qtile.current_group.name ==  gn:
            return
        if gn in ['a','s','d','f']:
            qtile.cmd_to_screen(0)
            if qtile.current_group.name != gn:
                qtile.groups_map[gn].cmd_toscreen(0)
        elif gn in ['q','w','e','r']:
            qtile.cmd_to_screen(1)
            if qtile.current_group.name != gn:
                qtile.groups_map[gn].cmd_toscreen(1)
        return
    return __inner

def mov_win_to_group(gn):
    @lazy.function
    def __inner(qtile):
        if qtile.current_group.name ==  gn:
            return
        try:
            window=qtile.current_window
            window.cmd_togroup(gn)
            if gn in ['a','s','d','f']:
                qtile.cmd_to_screen(0)
                if qtile.current_group.name != gn:
                    qtile.groups_map[gn].cmd_toscreen(0)
            elif gn in ['q','w','e','r']:
                qtile.cmd_to_screen(1)
                if qtile.current_group.name != gn:
                    qtile.groups_map[gn].cmd_toscreen(1)
        except:
            if gn in ['a','s','d','f']:
                qtile.cmd_to_screen(0)
                if qtile.current_group.name != gn:
                    qtile.groups_map[gn].cmd_toscreen(0)
            elif gn in ['q','w','e','r']:
                qtile.cmd_to_screen(1)
                if qtile.current_group.name != gn:
                    qtile.groups_map[gn].cmd_toscreen(1)
            return
    return __inner



for i in groups:
    keys.append(
        Key([win], i.name, go_to_group(i.name))
    )
    keys.append(
        Key([win, "shift"], i.name, mov_win_to_group(i.name))
    )

layouts = [
    # layout.Bsp(
    #     fair=True,
    #     lower_right=True,
    #     grow_amount=5,
    #     **layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.TreeTab(
         font = "Ubuntu",
         fontsize = 10,
         sections = ["FIRST", "SECOND"],
         section_fontsize = 11,
         bg_color = "141414",
         active_bg = "90C435",
         active_fg = "000000",
         inactive_bg = "384323",
         inactive_fg = "a0a0a0",
         padding_y = 5,
         section_top = 10,
         panel_width = 320
         ),
    ]

def init_screen1():
    return Screen(
        top=bar.Bar(
            widgets=[
                widget.TextBox(
                    text=" ☵",
                    foreground=colors[0],
                    **widget_defaults
                    ),
                widget.CurrentLayout(
                    **widget_defaults
                    ),
                widget.Sep(
                    **widget_defaults
                    ),
                widget.GroupBox(
                    active  =   '#FFFF99',
                    inactive=   colors[2],
                    urgent_alert_method='block',
                    highlight_method='block',
                    this_current_screen_border=colors[0],
                    this_screen_border=colors[3],
                    other_current_screen_border=colors[0],
                    other_screen_border=colors[3],
                    disable_drag=True,
                    spacing =   4,
                    visible_groups=['a', 's', 'd', 'f'],
                    use_mouse_wheel=False,
                    **widget_defaults
                    ),
                widget.Sep(
                    **widget_defaults
                    ),
                # widget.TaskList(
                #     border  =   colors[3],
                #     max_title_width=150,
                #     highlight_method='block',
                #     spacing =   3,
                #     padding =   2,
                #     fontsize=   14,
                #     ),
                widget.Prompt(
                       padding = 10,
                   ),
                widget.WindowName(
                       padding = 0
                   ),
                widget.Systray(
                    background = colors[1],
                    **widget_defaults,
                    ),
                widget.BatteryIcon(
                    theme_path='/home/xiangchong/.config/qtile/battery-icons/',
                    spacing =   3,
                    padding =   4,
                    background = colors[1],
                    opacity=.1,
                    ),
                widget.Sep(
                    **widget_defaults,
                    background = colors[1],
                    ),
                widget.Countdown(
                    date=datetime(2021,7,1),
                    format='{D} Days',
                    update_interval=3600,
                    background = colors[1],
                    foreground = colors[0],
                    opacity=.1,
                    spacing =   3,
                    padding =   4,
                    ),
                widget.Clock(
                    background = colors[1],
                    foreground = colors[0],
                    format="%a, %m-%d  %H:%M",
                    opacity=.1,
                    ),
            ],
            opacity=.85,
            size=26,
            background='#12141a',
        )
    )

def init_screen2():
    return Screen(
        top=bar.Bar(
            widgets=[
                widget.TextBox(
                    text=" ☵",
                    foreground=colors[0],
                    **widget_defaults
                    ),
                widget.CurrentLayout(
                    **widget_defaults
                    ),
                widget.Sep(
                    **widget_defaults
                    ),
                widget.GroupBox(
                    active  =   '#FFFF99',
                    inactive=   colors[2],
                    urgent_alert_method='text',
                    highlight_method='block',
                    this_current_screen_border=colors[0],
                    this_screen_border=colors[3],
                    other_current_screen_border=colors[0],
                    other_screen_border=colors[3],
                    disable_drag=True,
                    spacing =   4,
                    visible_groups=['q','w','e','r'],
                    use_mouse_wheel=False,
                    **widget_defaults
                    ),
                widget.Sep(
                    **widget_defaults
                    ),
                widget.Prompt(
                       padding = 10,
                   ),
                widget.WindowName(
                       padding = 0
                   ),
                # widget.TaskList(
                #     border=colors[1],
                #     max_title_width=150,
                #     highlight_method='block',
                #     spacing =   3,
                #     padding =   2,
                #     fontsize=   14,
                #     ),
                widget.Sep(
                    **widget_defaults,
                    ),
                widget.Clock(
                    background = colors[1],
                    foreground = colors[0],
                    format="%a, %m-%d  %H:%M"
                    ),
            ],
            opacity=0.95,
            size=26,
            background='#12141a',
        )
    )

screens = [
    init_screen1(),
    init_screen2(),
]

# Drag floating layouts.
mouse = [
    Drag([win], "Button1", lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([win], "Button3", lazy.window.set_size_floating(),
        start=lazy.window.get_size())
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"

floating_layout = layout.Floating(float_rules=[
    {"role": "EventDialog"},
    {"role": "Msgcompose"},
    {"role": "Preferences"},
    {"role": "pop-up"},
    {"role": "task_dialog"},
    {"role": "viewer"},
    {"role": "GtkFileChooserDialog"},
    {"wname": "Module"},
    {"wname": "Terminator Preferences"},
    {"wname": "Search Dialog"},
    {"wname": "Goto"},
    {"wname": "IDLE Preferences"},
    {"wname": "Sozi"},
    {"wname": "Create new database"},
    {"wname": "Preferences"},
    {"wname": "File Transfer"},
    {"wname": 'branchdialog'},
    {"wname": 'pinentry'},
    {"wname": 'confirm'},
    {"wmclass": 'dialog'},
    {"wmclass": 'download'},
    {"wmclass": 'error'},
    {"wmclass": 'file_progress'},
    {"wmclass": 'notification'},
    {"wmclass": 'splash'},
    {"wmclass": 'toolbar'},
    {"wmclass": 'confirmreset'},
    {"wmclass": 'makebranch'},
    {"wmclass": 'maketag'},
    {"wmclass": "Gimp"},
    {"wmclass": "zoom"},
    {"wmclass": "skype"},
    {"wmclass": "Display-im6.q16"},
    {"wmclass": "Ds9.tcl"},
    {"wmclass": "Toplevel"},
    {"wmclass": "Nm-connection-editor"},
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
],**layout_theme)

@hook.subscribe.client_new
def set_floating(client):
    floating_types = ["notification", "toolbar", "splash", "dialog"]
    if (client.window.get_wm_type() in floating_types
    or client.window.get_wm_transient_for()):
        client.floating = True

@hook.subscribe.client_name_updated
def set_name(client):
    client.name=client.name.split(' ')[-1]
    client.name=client.name.split('/')[-1]
    client.name=client.name.split('.')[0]

@hook.subscribe.client_focus
def float_to_front(client):
    if client.floating:
        client.cmd_bring_to_front()

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])
    return
