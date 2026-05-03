import QtQuick
import Quickshell
import qs.modules.bar
import qs.modules.common

ShellRoot {
    id: shell_root
    Component.onCompleted: Appearance.theme = "gruvbox"
    Bar {}
}
