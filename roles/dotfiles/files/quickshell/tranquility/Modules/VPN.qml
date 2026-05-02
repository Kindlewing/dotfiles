import QtQuick
import Quickshell.Io

Item {
    id: root
    implicitWidth: connected ? vpn_text.implicitWidth + Gruvbox.padding * 2 : 0
    implicitHeight: Gruvbox.bar_height
    visible: connected

    property bool connected: false

    Process {
        id: vpn_check
        command: ["test", "-d", "/proc/sys/net/ipv4/conf/tun0"]
        running: true
        onExited: code => root.connected = (code === 0) // qmllint disable signal-handler-parameters
    }

    Timer {
        interval: 5000
        repeat: true
        running: true
        onTriggered: vpn_check.running = true
    }

    Text {
        id: vpn_text
        anchors.centerIn: parent
        text: "VPN "
        color: Gruvbox.aqua
        font.family: Gruvbox.font
        font.pixelSize: Gruvbox.font_size
        font.bold: true
    }
}
