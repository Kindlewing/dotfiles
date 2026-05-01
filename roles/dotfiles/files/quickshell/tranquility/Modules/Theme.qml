pragma Singleton
import QtQuick
import "Themes"

QtObject {
    property string variant: "gruvbox"

    property Catppuccin _catppuccin: Catppuccin {}
    property Gruvbox _gruvbox: Gruvbox {}

    readonly property QtObject _active: variant === "gruvbox" ? _gruvbox : _catppuccin

    readonly property color background: _active.background
    readonly property color surface: _active.surface
    readonly property color foreground: _active.foreground
    readonly property color subtle: _active.subtle
    readonly property color accent: _active.accent
    readonly property color green: _active.green
    readonly property color red: _active.red
    readonly property color blue: _active.blue

    readonly property int barHeight: 32
    readonly property int fontSize: 13
}
