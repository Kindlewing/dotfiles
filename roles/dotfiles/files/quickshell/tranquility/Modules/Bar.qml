import QtQuick
import QtQuick.Layouts
import Quickshell

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: Theme.barHeight
    color: Theme.background

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 12

        Text {
            text: "  "
            color: Theme.foreground
            font.pixelSize: Theme.fontSize
        }

        Item {
            Layout.fillWidth: true
        }

        Clock {}

        Item {
            Layout.fillWidth: true
        }

        Text {
            text: "100%"
            color: Theme.foreground
            font.pixelSize: Theme.fontSize
        }
    }
}
