import QtQuick
import Quickshell.Io
import Quickshell.Services.Pipewire

Item {
    id: root
    implicitWidth: volText.implicitWidth + Gruvbox.padding * 2
    implicitHeight: Gruvbox.barHeight

    PwObjectTracker {
        id: sinkTracker
        objects: Pipewire.defaultAudioSink ? [Pipewire.defaultAudioSink] : []
    }

    property var sink: sinkTracker.objects[0] ?? null
    property bool muted: sink?.audio?.muted ?? false
    property real volume: sink?.audio?.volume ?? 0

    Process {
        id: mixerProc
        command: ["kmix"]
    }

    property string icon: {
        if (muted)
            return "󰝟";
        if (volume > 0.66)
            return "󰕾";
        if (volume > 0.33)
            return "󰖀";
        return "󰕿";
    }

    Text {
        id: volText
        anchors.centerIn: parent
        text: root.muted ? `${root.icon}  Muted` : `${root.icon}  ${Math.round(root.volume * 100)}%`
        color: root.muted ? Gruvbox.gray : Gruvbox.purple
        font.family: Gruvbox.font
        font.pixelSize: Gruvbox.fontSize
        font.bold: true
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: event => {
            if (event.button === Qt.LeftButton && root.sink)
                root.sink.audio.muted = !root.sink.audio.muted;
            else if (event.button === Qt.RightButton)
                mixerProc.running = true;
        }
        onWheel: event => {
            if (!root.sink)
                return;
            const delta = event.angleDelta.y > 0 ? 0.01 : -0.01;
            root.sink.audio.volume = Math.max(0, Math.min(1, root.volume + delta));
        }
    }
}
