import QtQuick
import Quickshell.Io

Item {
    id: root
    implicitWidth: connected ? vpnText.implicitWidth + Gruvbox.padding * 2 : 0
    implicitHeight: Gruvbox.barHeight
    visible: connected

    property bool connected: false

    Process {
        id: vpnCheck
        command: ["test", "-d", "/proc/sys/net/ipv4/conf/tun0"]
        running: true
        onExited: code => root.connected = (code === 0) // qmllint disable signal-handler-parameters
    }

    Timer {
        interval: 5000
        repeat: true
        running: true
        onTriggered: vpnCheck.running = true
    }

    Text {
        id: vpnText
        anchors.centerIn: parent
        text: "VPN "
        color: Gruvbox.aqua
        font.family: Gruvbox.font
        font.pixelSize: Gruvbox.fontSize
        font.bold: true
    }
}
