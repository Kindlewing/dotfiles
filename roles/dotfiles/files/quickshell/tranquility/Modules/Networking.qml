import QtQuick
import Quickshell.Io

Item {
    id: root
    implicitWidth: netText.implicitWidth + Gruvbox.padding * 2
    implicitHeight: Gruvbox.barHeight

    property string essid: ""
    property int strength: 0
    property bool connected: false
    property bool expanded: false

    property string icon: {
        if (!connected) return "󰤭"
        if (strength >= 80) return "󰤨"
        if (strength >= 60) return "󰤥"
        if (strength >= 40) return "󰤢"
        if (strength >= 20) return "󰤟"
        return "󰤯"
    }

    Process {
        id: iwProc
        command: ["nmcli", "-t", "-f", "active,ssid,signal", "dev", "wifi"]
        running: true
        stdout: SplitParser {
            onRead: line => {
                if (line.startsWith("yes:")) {
                    const parts = line.split(":")
                    root.connected = true
                    root.essid = parts[1] ?? ""
                    root.strength = parseInt(parts[2] ?? "0")
                }
            }
        }
        onExited: if (!root.connected) { root.essid = ""; root.strength = 0 } // qmllint disable signal-handler-parameters
    }

    Timer {
        interval: 10000; repeat: true; running: true
        onTriggered: { root.connected = false; iwProc.running = true }
    }

    Process {
        id: nmtuiProc
        command: ["kitty", "nmtui"]
    }

    Text {
        id: netText
        anchors.centerIn: parent
        text: root.expanded
            ? (root.connected ? `${root.icon}   ${root.essid}` : "󰤭   Disconnected")
            : (root.connected ? `${root.icon}   ${root.strength}%` : "󰤭   Disconnected")
        color: root.connected ? Gruvbox.blue : Gruvbox.gray
        font.family: Gruvbox.font
        font.pixelSize: Gruvbox.fontSize
        font.bold: true
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: (event) => {
            if (event.button === Qt.RightButton)
                nmtuiProc.running = true
            else
                root.expanded = !root.expanded
        }
    }
}
