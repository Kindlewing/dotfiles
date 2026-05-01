import QtQuick
import Quickshell

Item {
    id: root
    implicitWidth: clockText.implicitWidth + Gruvbox.padding * 2
    implicitHeight: Gruvbox.barHeight

    property bool expanded: false

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Text {
        id: clockText
        anchors.centerIn: parent
        text: root.expanded
            ? Qt.formatDateTime(clock.date, "dddd  |  hh:mm  |  d MMMM")
            : "󰣇  " + Qt.formatDateTime(clock.date, "hh:mm")
        color: Gruvbox.yellow
        font.family: Gruvbox.font
        font.pixelSize: Gruvbox.fontSize
        font.bold: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.expanded = !root.expanded
    }
}
