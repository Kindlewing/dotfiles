import os
from re import sub
import subprocess
from libqtile import hook

from keys import keys   # NOQA # pyright: ignore
from workspace_keymaps import workspace_keymaps   # NOQA # pyright: ignore
from screens import screens   # NOQA # pyright: ignore
from layouts import layouts   # NOQA # pyright: ignore
from groups import groups   # NOQA #pyright: ignore
from floating_windows import floating_layout   # NOQA # pyright: ignore

home = os.path.expanduser('~')


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~/.config/qtile/scripts/autostart.sh')
    subprocess.call([home])


@hook.subscribe.startup
def start_polybar():
    home = os.path.expanduser('~/.config/qtile/scripts/start_polybar.sh')
    subprocess.call([home])


@hook.subscribe.startup
def start_always():
    # Set the cursor to something sane in X
    subprocess.Popen(['xsetroot', '-cursor_name', 'left_ptr'])


@hook.subscribe.startup
def set_wallpaper():
    path = '$HOME/.config/qtile/wallpapers/Mist.png'
    os.system('feh --bg-scale ' + path)


dgroups_key_binder = None
dgroups_app_rules = []


main = None


follow_mouse_focus = True
bring_front_click = False
cursor_warp = False


auto_fullscreen = True

focus_on_window_activation = 'focus'   # or smart

wmname = 'LG3D'
