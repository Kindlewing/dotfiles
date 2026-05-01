import QtQuick
import QtQuick.Layouts
import Quickshell

Item {
    id: root
    property ShellScreen screen: null

    readonly property bool barIsVertical: false  // or wire to a setting
    readonly property real barHeight: 32

    anchors.fill: parent

    Item {
        id: bar
        x: 0
        y: 0
        width: parent.width
        height: parent.barHeight

        Rectangle {
            anchors.fill: parent
            color: Theme.base
        }
        // Horizontal layout
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 8
            anchors.rightMargin: 8

            // LEFT — your widgets go here
            RowLayout {
                spacing: 4
                // e.g. WorkspaceWidget {}
            }

            Item {
                Layout.fillWidth: true
            }  // spacer

            // RIGHT — your widgets go here
            RowLayout {
                spacing: 4
                // e.g. ClockWidget {}
            }
        }
    }
}
