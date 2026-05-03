pragma Singleton
import QtQuick
import Quickshell
import qs.services

Singleton {
    id: root

    property string theme: "catppuccin"

    readonly property var active: Theme.themes[theme] ?? Theme.themes["catppuccin"]

    readonly property color background: active.background
    readonly property color surface:    active.surface
    readonly property color foreground: active.foreground
    readonly property color subtle:     active.subtle
    readonly property color accent:     active.accent
    readonly property color green:      active.green
    readonly property color red:        active.red
    readonly property color blue:       active.blue
}
