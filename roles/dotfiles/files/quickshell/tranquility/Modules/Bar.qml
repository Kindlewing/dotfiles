import QtQuick
import QtQuick.Layouts
import Quickshell

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }
    height: 32
    color: "#1e1e2e"

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 12

        // Left: Workspaces / launcher
        Text {
            text: "  "
            color: "#cdd6f4"
        }

        Item {
            Layout.fillWidth: true
        }  // spacer

        // Center: Clock
        Text {
            id: clock
            text: Qt.formatDateTime(new Date(), "hh:mm")
            color: "#cdd6f4"

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: parent.text = Qt.formatDateTime(new Date(), "hh:mm")
            }
        }

        Item {
            Layout.fillWidth: true
        }

        // Right: placeholder for system tray / stats
        Text {
            text: "100%"
            color: "#cdd6f4"
        }
    }
}
