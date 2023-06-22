from libqtile.layout import (
    xmonad,
    max,
    matrix,
    floating,
    bsp,
    ratiotile,
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
    xmonad.MonadTall(
        margin=8,
        border_width=2,
        border_focus='#5e81ac',
        border_normal='#4c566a',
    ),
    xmonad.MonadWide(
        margin=8,
        border_width=2,
        border_focus='#5e81ac',
        border_normal='#4c566a',
    ),
    matrix.Matrix(**layout_theme),
    bsp.Bsp(**layout_theme),
    floating.Floating(**layout_theme),
    ratiotile.RatioTile(**layout_theme),
    max.Max(**layout_theme),
]
