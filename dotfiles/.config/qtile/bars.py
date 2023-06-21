from libqtile import bar, widget
from colors import colors

monitor_bar = bar.Bar(
    [
        widget.GroupBox(
            font='FontAwesome',
            fontsize=16,
            margin_y=-1,
            margin_x=0,
            padding_y=6,
            padding_x=5,
            borderwidth=0,
            disable_drag=True,
            active=colors[9],
            inactive=colors[5],
            rounded=False,
            highlight_method='text',
            this_current_screen_border=colors[8],
            foreground=colors[2],
            background=colors[1],
        ),
        widget.Sep(
            linewidth=0, padding=10, foreground=colors[2], background=colors[1]
        ),
        widget.CurrentLayout(
            font='Noto Sans Bold', foreground=colors[5], background=colors[1]
        ),
        widget.Sep(
            linewidth=0, padding=20, foreground=colors[2], background=colors[1]
        ),
        widget.WindowName(
            font='Noto Sans',
            fontsize=12,
            foreground=colors[5],
            background=colors[1],
        ),
        widget.Sep(
            linewidth=0, padding=10, foreground=colors[2], background=colors[1]
        ),
        widget.Memory(
            font='Noto Sans',
            format='Used: {MemPercent: .2f}% ({MemUsed: .2f} G)   /   Total: {MemTotal: .1f} G',
            measure_mem='G',
            update_interval=1,
            fontsize=10,
            foreground=colors[5],
            background=colors[1],
        ),
        widget.Sep(
            linewidth=0, padding=10, foreground=colors[2], background=colors[1]
        ),
        widget.TextBox(
            font='FontAwesome',
            text='  ',
            foreground=colors[3],
            background=colors[1],
            padding=0,
            fontsize=16,
        ),
        widget.Clock(
            foreground=colors[5],
            background=colors[1],
            fontsize=12,
            format='%A, %B %d - %H:%M',
        ),
        widget.Sep(
            linewidth=0, padding=20, foreground=colors[2], background=colors[1]
        ),
    ],
    30,
)

primary_bar = bar.Bar(
    [
        widget.GroupBox(
            font='FontAwesome',
            fontsize=16,
            margin_y=-1,
            margin_x=0,
            padding_y=6,
            padding_x=5,
            borderwidth=0,
            disable_drag=True,
            active=colors[9],
            inactive=colors[5],
            rounded=False,
            highlight_method='text',
            this_current_screen_border=colors[8],
            foreground=colors[2],
            background=colors[1],
        ),
        widget.Sep(
            linewidth=0, padding=10, foreground=colors[2], background=colors[1]
        ),
        widget.CurrentLayout(
            font='Noto Sans Bold', foreground=colors[5], background=colors[1]
        ),
        widget.Sep(
            linewidth=0, padding=20, foreground=colors[2], background=colors[1]
        ),
        widget.WindowName(
            font='Noto Sans',
            fontsize=12,
            foreground=colors[5],
            background=colors[1],
        ),
        widget.Sep(
            linewidth=0, padding=10, foreground=colors[2], background=colors[1]
        ),
        widget.Memory(
            font='Noto Sans',
            format='Used: {MemPercent: .2f}% ({MemUsed: .2f} G)   /   Total: {MemTotal: .1f} G',
            measure_mem='G',
            update_interval=1,
            fontsize=10,
            foreground=colors[5],
            background=colors[1],
        ),
        widget.Sep(
            linewidth=0, padding=10, foreground=colors[2], background=colors[1]
        ),
        widget.TextBox(
            font='FontAwesome',
            text='  ',
            foreground=colors[3],
            background=colors[1],
            padding=0,
            fontsize=16,
        ),
        widget.Clock(
            foreground=colors[5],
            background=colors[1],
            fontsize=12,
            format='%A, %B %d - %H:%M',
        ),
        widget.Sep(
            linewidth=0, padding=20, foreground=colors[2], background=colors[1]
        ),
        widget.Systray(background=colors[1], icon_size=20, padding=4),
    ],
    30,
)