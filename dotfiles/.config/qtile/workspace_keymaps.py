from keys import keys, mod
from groups import groups
from libqtile.command import lazy
from libqtile.config import Key


def initialize_workspace_keymaps():
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


workspace_keymaps = initialize_workspace_keymaps()
