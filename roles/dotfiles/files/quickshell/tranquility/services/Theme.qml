pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: root

    QtObject {
        id: catppuccin
        readonly property color background: "#1e1e2e"
        readonly property color surface:    "#313244"
        readonly property color foreground: "#cdd6f4"
        readonly property color subtle:     "#6c7086"
        readonly property color accent:     "#cba6f7"
        readonly property color green:      "#a6e3a1"
        readonly property color red:        "#f38ba8"
        readonly property color blue:       "#89b4fa"
    }

    QtObject {
        id: gruvbox
        readonly property color background: "#282828"
        readonly property color surface:    "#3c3836"
        readonly property color foreground: "#ebdbb2"
        readonly property color subtle:     "#928374"
        readonly property color accent:     "#d3869b"
        readonly property color green:      "#b8bb26"
        readonly property color red:        "#fb4934"
        readonly property color blue:       "#83a598"
    }

    readonly property var themes: ({
        "catppuccin": catppuccin,
        "gruvbox":    gruvbox
    })
}
