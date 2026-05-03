import QtQuick
import Quickshell
import qs.modules.common

Scope {
    id: bar
    Variants {
        model: Quickshell.screens
        // qmllint disable uncreatable-type
        PanelWindow {
            id: barWindow
            required property ShellScreen modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 32
            color: Appearance.background
            Text {
                anchors.centerIn: parent
                text: "Hello from " + barWindow.screen.name
                color: "white"
            }
        }
    }
}
