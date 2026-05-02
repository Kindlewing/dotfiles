import QtQuick
import Quickshell.Io

Item {
    id: root
    implicitWidth: bat_text.implicitWidth + Gruvbox.padding * 2
    implicitHeight: Gruvbox.bar_height

    Process {
        id: cap_proc
        command: ["cat", "/sys/class/power_supply/BAT0/capacity"]
        running: true
        stdout: SplitParser {
            onRead: data => root.capacity = parseInt(data.trim())
        }
    }

    Process {
        id: status_proc
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
            cap_proc.running = true;
            status_proc.running = true;
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

    property color text_color: {
        if (status === "Charging") return Gruvbox.green;
        if (capacity <= 20) return Gruvbox.red;
        if (capacity <= 40) return Gruvbox.orange;
        if (capacity >= 85) return Gruvbox.yellow;
        return Gruvbox.green;
    }

    Text {
        id: bat_text
        anchors.centerIn: parent
        text: `${root.capacity}%  ${root.icon}`
        color: root.text_color
        font.family: Gruvbox.font
        font.pixelSize: Gruvbox.font_size
        font.bold: true
    }
}
