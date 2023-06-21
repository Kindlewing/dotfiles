import os
import subprocess

from libqtile import hook, layout
from libqtile.command import lazy
from libqtile.config import Group, Key, Match

from keys import initialize_keys, mod
from screens import initialize_screens
from groups import initialize_groups


# import arcobattery

home = os.path.expanduser('~')


@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)


@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


keys = initialize_keys()
groups = initialize_groups()
screens = initialize_screens()


for i in groups:
    keys.extend(
        [
            # CHANGE WORKSPACES
            Key([mod], i.name, lazy.group[i.name].toscreen()),
            Key([mod], 'Tab', lazy.screen.next_group()),
            Key([mod, 'shift'], 'Tab', lazy.screen.prev_group()),
            Key(['mod1'], 'Tab', lazy.screen.next_group()),
            Key(['mod1', 'shift'], 'Tab', lazy.screen.prev_group()),
            # MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND STAY ON WORKSPACE
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
            # MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND FOLLOW MOVED WINDOW TO WORKSPACE
            Key(
                [mod, 'shift'],
                i.name,
                lazy.window.togroup(i.name),
                lazy.group[i.name].toscreen(),
            ),
        ]
    )


def init_layout_theme():
    return {
        'margin': 5,
        'border_width': 2,
        'border_focus': '#5e81ac',
        'border_normal': '#4c566a',
    }


layout_theme = init_layout_theme()


layouts = [
    layout.MonadTall(
        margin=8,
        border_width=2,
        border_focus='#5e81ac',
        border_normal='#4c566a',
    ),
    layout.MonadWide(
        margin=8,
        border_width=2,
        border_focus='#5e81ac',
        border_normal='#4c566a',
    ),
    layout.Matrix(**layout_theme),
    layout.Bsp(**layout_theme),
    layout.Floating(**layout_theme),
    layout.RatioTile(**layout_theme),
    layout.Max(**layout_theme),
]

dgroups_key_binder = None
dgroups_app_rules = []


main = None


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/scripts/autostart.sh'])


@hook.subscribe.startup
def start_always():
    # Set the cursor to something sane in X
    subprocess.Popen(['xsetroot', '-cursor_name', 'left_ptr'])


@hook.subscribe.client_new
def set_floating(window):
    if (
        window.window.get_wm_transient_for()
        or window.window.get_wm_type() in floating_types
    ):
        window.floating = True


floating_types = ['notification', 'toolbar', 'splash', 'dialog']


follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='branchdialog'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
        Match(wm_class='Arcolinux-welcome-app.py'),
        Match(wm_class='Archlinux-tweak-tool.py'),
        Match(wm_class='Arcolinux-calamares-tool.py'),
        Match(wm_class='confirm'),
        Match(wm_class='dialog'),
        Match(wm_class='download'),
        Match(wm_class='error'),
        Match(wm_class='file_progress'),
        Match(wm_class='notification'),
        Match(wm_class='splash'),
        Match(wm_class='toolbar'),
        Match(wm_class='Arandr'),
        Match(wm_class='feh'),
        Match(wm_class='Galculator'),
        Match(wm_class='archlinux-logout'),
        Match(wm_class='xfce4-terminal'),
    ],
    fullscreen_border_width=0,
    border_width=0,
)
auto_fullscreen = True

focus_on_window_activation = 'focus'   # or smart

wmname = 'LG3D'
