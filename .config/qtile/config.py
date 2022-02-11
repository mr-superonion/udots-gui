import os
import subprocess
from datetime import datetime
from libqtile import layout, bar, widget, hook, extension
from libqtile.config import Drag, Group, Key, Match, Screen
from libqtile.command import lazy

mod     =   "mod1"
win     =   "mod4"
myTerm  =   "xterm"
wmname  =   "LG3D"
# colors  =   ["#6F9FE3","#222D32","#FFFFFF","#002b36"]
colors  =   ["#6F9FE3","#222D32","#FFFFFF","#1f8780","#181512","#1d272a","#1d2021"]

layout_theme={"border_width": 3,
            "margin": 0,
            "border_focus": colors[0],
            "border_normal":colors[1]
            }

widget_defaults = dict(
    font='DejaVu Sans Mono',
    fontsize=17,
    padding=5,
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
    Key([mod, "control"], "w", lazy.spawn('brave')),
    Key([mod, "control"], "m", lazy.spawn('thunderbird')),
    Key([mod, "control"], "f", lazy.spawn('exploreLocal')),
    Key([mod, "control"], "n", lazy.spawn('nm-connection-editor')),
    Key([mod, "control"], "Return",
        lazy.run_extension(extension.DmenuRun(
        dmenu_prompt=" ➜ ",
        dmenu_font="Ubuntu",
        background=colors[5],
        selected_background=colors[3],
        ))),
    # lazy.spawn("dmenu_run -i -fn %s -p dmenu: "
    # %('Ubuntu'))
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
    # layout.TreeTab(
    #      font = "Ubuntu",
    #      fontsize = 10,
    #      sections = ["FIRST", "SECOND"],
    #      section_fontsize = 11,
    #      bg_color = "141414",
    #      active_bg = "90C435",
    #      active_fg = "000000",
    #      inactive_bg = "384323",
    #      inactive_fg = "a0a0a0",
    #      padding_y = 5,
    #      section_top = 10,
    #      panel_width = 320
    #      ),
    ]

def init_screen1():
    return Screen(
        top=bar.Bar(
            widgets=[
                widget.CurrentLayoutIcon(
                    scale=0.75,
                    foreground=colors[3],
                    ),
                widget.Sep(
                    **widget_defaults
                    ),
                widget.GroupBox(
                    active  =   '#FFFF99',
                    inactive=   colors[2],
                    urgent_alert_method='block',
                    highlight_method='block',
                    this_current_screen_border=colors[3],
                    this_screen_border=colors[0],
                    other_current_screen_border=colors[3],
                    other_screen_border=colors[0],
                    disable_drag=True,
                    spacing =   0,
                    padding_x=  6,
                    visible_groups=['a', 's', 'd', 'f'],
                    use_mouse_wheel=False,
                    **widget_defaults
                    ),
                widget.Sep(
                    **widget_defaults
                    ),
                widget.Prompt(
                       padding = 10,
                   ),
                widget.TaskList(
                    border  =   colors[5],
                    max_title_width=150,
                    highlight_method='block',
                    spacing =   0,
                    margin  =   0,
                    padding_x=  12,
                    fontsize=   14,
                    txt_floating='[x]',
                    icon_size=  0,
                    rounded=False,
                    ),
                widget.Systray(
                    background  = colors[6],
                    **widget_defaults,
                    ),
                widget.BatteryIcon(
                    theme_path= '/home/xiangchong/.config/qtile/battery-icons/',
                    background= colors[4],
                    spacing =   3,
                    padding_x =   6,
                    ),
                widget.CPU(
                    foreground=colors[3],
                    background=colors[4],
                    max_chars=  12,
                    format='CPU:{load_percent:02.0f}%;',
                    spacing =   0,
                    padding_x =   6,
                    ),
                widget.Memory(
                    foreground=colors[3],
                    background=colors[4],
                    max_chars=  12,
                    measure_mem='G',
                    measure_swap='G',
                    spacing =   1,
                    padding_x = 6,
                    format  =   'Mem:{MemUsed:02.0f}{mm}/{MemTotal:.0f}{mm}',
                    ),
                widget.Countdown(
                    background  = colors[6],
                    date=datetime(2022,4,1),
                    format='{D} Days;',
                    update_interval=3600,
                    # background = colors[1],
                    foreground = colors[0],
                    spacing =   1,
                    padding_x = 6,
                    ),
                widget.Clock(
                    background  = colors[6],
                    foreground  = colors[0],
                    format="%a, %m-%d; %H:%M",
                    ),
            ],
            opacity=.95,
            size=26,
            background='#12141a',
        )
    )

def init_screen2():
    return Screen(
        top=bar.Bar(
            widgets=[
                widget.CurrentLayoutIcon(
                    scale=0.75,
                    foreground=colors[3],
                    ),
                widget.Sep(
                    **widget_defaults
                    ),
                widget.GroupBox(
                    active  =   '#FFFF99',
                    inactive=   colors[2],
                    urgent_alert_method='block',
                    highlight_method='block',
                    this_current_screen_border=colors[3],
                    this_screen_border=colors[0],
                    other_current_screen_border=colors[3],
                    other_screen_border=colors[0],
                    disable_drag=True,
                    spacing =   0,
                    padding_x=  6,
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
                # widget.WindowName(
                #        padding = 0
                #    ),
                widget.TaskList(
                    border=colors[5],
                    max_title_width=150,
                    highlight_method='block',
                    spacing =   0,
                    margin  =   0,
                    padding_x=  12,
                    fontsize=   14,
                    txt_floating='[x]',
                    icon_size=  0,
                    rounded=False,
                    ),
                widget.Clock(
                    background  = colors[6],
                    foreground  = colors[0],
                    format="%a, %m-%d; %H:%M",
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
#dgroups_app_rules = []
main = None
follow_mouse_focus = False
bring_front_click = False
cursor_warp = True
auto_fullscreen = False
focus_on_window_activation = "smart"



floating_layout = layout.Floating(float_rules=[
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class= 'dialog'),
    Match(wm_class= 'download'),
    Match(wm_class= 'error'),
    Match(wm_class= 'file_progress'),
    Match(wm_class= 'notification'),
    Match(wm_class= 'splash'),
    Match(wm_class= 'toolbar'),
    Match(wm_class= 'confirmreset'),
    Match(wm_class= 'makebranch'),
    Match(wm_class= 'maketag'),
    Match(wm_class= 'Gimp'),
    Match(wm_class= 'zoom'),
    Match(wm_class= 'skype'),
    Match(wm_class= 'Display-im6.q16'),
    Match(wm_class= 'ds9.tcl'),
    Match(wm_class= 'Matplotlib'),
    Match(wm_class= 'cube'),
    Match(wm_class= 'nres'),
    Match(wm_class= 'Toplevel'),
    Match(wm_class= 'Nm-connection-editor'),
    Match(wm_class= 'ssh-askpass'),
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    Match(wm_type= 'Module'),
    Match(wm_type= 'Terminator Preferences'),
    Match(wm_type= 'Search Dialog'),
    Match(wm_type= 'Goto'),
    Match(wm_type= 'IDLE Preferences'),
    Match(wm_type= 'Sozi'),
    Match(wm_type= 'Create new database'),
    Match(wm_type= 'Preferences'),
    Match(wm_type= 'File Transfer'),
    Match(wm_type= 'branchdialog'),
    Match(wm_type= 'pinentry'),
    Match(wm_type= 'confirm'),
    ],
    **layout_theme)

# @hook.subscribe.client_new
# def set_floating(client):
#     with open("fname", "a+") as file:
#         file.write(client.window.get_wm_class()[1])
#         file.write(client.window.get_wm_class()[1])
#         file.write('\\')

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
