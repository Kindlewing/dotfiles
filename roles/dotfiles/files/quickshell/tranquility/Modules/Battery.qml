import QtQuick
import Quickshell.Io

Item {
    id: root
    implicitWidth: batText.implicitWidth + Gruvbox.padding * 2
    implicitHeight: Gruvbox.barHeight

    Process {
        id: capProc
        command: ["cat", "/sys/class/power_supply/BAT0/capacity"]
        running: true
        stdout: SplitParser {
            onRead: data => root.capacity = parseInt(data.trim())
        }
    }

    Process {
        id: statusProc
        command: ["cat", "/sys/class/power_supply/BAT0/status"]
        running: true
        stdout: SplitParser {
            onRead: data => root.status = data.trim()
        }
    }

    Timer {
        interval: 30000
        repeat: true
        running: true
        onTriggered: {
            capProc.running = true;
            statusProc.running = true;
        }
    }

    property int capacity: 100
    property string status: "Unknown"

    property string icon: {
        if (status === "Charging") return "󰂄";
        if (status === "Full")     return "󰚥";
        if (capacity >= 80) return " ";
        if (capacity >= 60) return " ";
        if (capacity >= 40) return " ";
        if (capacity >= 20) return " ";
        return " ";
    }

    property color textColor: {
        if (status === "Charging") return Gruvbox.green;
        if (capacity <= 20) return Gruvbox.red;
        if (capacity <= 40) return Gruvbox.orange;
        if (capacity >= 85) return Gruvbox.yellow;
        return Gruvbox.green;
    }

    Text {
        id: batText
        anchors.centerIn: parent
        text: `${root.capacity}%  ${root.icon}`
        color: root.textColor
        font.family: Gruvbox.font
        font.pixelSize: Gruvbox.fontSize
        font.bold: true
    }
}
