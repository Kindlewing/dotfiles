from libqtile.config import Screen
from bars import primary_bar, monitor_bar

primary_screen = Screen(top=primary_bar)
monitor_screen = Screen(top=monitor_bar)


screens = [primary_screen, monitor_screen]
