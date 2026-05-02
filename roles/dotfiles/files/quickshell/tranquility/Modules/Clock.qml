import QtQuick
import Quickshell

Item {
    id: root
    implicitWidth: clock_text.implicitWidth + Gruvbox.padding * 2
    implicitHeight: Gruvbox.bar_height

    property bool expanded: false

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Text {
        id: clock_text
        anchors.centerIn: parent
        text: root.expanded
            ? Qt.formatDateTime(clock.date, "dddd  |  hh:mm  |  d MMMM")
            : "󰣇  " + Qt.formatDateTime(clock.date, "hh:mm")
        color: Gruvbox.yellow
        font.family: Gruvbox.font
        font.pixelSize: Gruvbox.font_size
        font.bold: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.expanded = !root.expanded
    }
}
