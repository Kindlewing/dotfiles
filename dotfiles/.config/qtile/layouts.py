from libqtile.layout import (
    xmonad,
    ratiotile,
)
from colors import catppuccin

window_gap_size = 8


layouts = [
    xmonad.MonadTall(
        margin=window_gap_size,
        border_width=2,
        border_focus=catppuccin['mauve'],
        border_normal=catppuccin['black'],
    ),
    ratiotile.RatioTile(
        margin=window_gap_size,
        border_width=2,
        border_focus=catppuccin['mauve'],
        border_normal=catppuccin['black'],
    ),
]
