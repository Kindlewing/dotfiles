import QtQuick
import Quickshell.Io
import Quickshell.Services.Pipewire

Item {
    id: root
    implicitWidth: vol_text.implicitWidth + Gruvbox.padding * 2
    implicitHeight: Gruvbox.bar_height

    readonly property real max_volume: 1.0

    PwObjectTracker {
        id: sink_tracker
        objects: Pipewire.defaultAudioSink ? [Pipewire.defaultAudioSink] : []
    }

    property var sink: sink_tracker.objects[0] ?? null
    property bool muted: sink?.audio?.muted ?? false
    property real volume: sink?.audio?.volume ?? 0

    function clamp_output_volume(vol: real): real {
        if (vol === undefined || isNaN(vol)) {
            return 0;
        }
        return Math.max(0, Math.min(root.max_volume, vol));
    }

    Process {
        id: mixer_proc
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
        id: vol_text
        anchors.centerIn: parent
        text: root.muted ? `${root.icon}  Muted` : `${root.icon}  ${Math.round(root.volume * 100)}%`
        color: root.muted ? Gruvbox.gray : Gruvbox.purple
        font.family: Gruvbox.font
        font.pixelSize: Gruvbox.font_size
        font.bold: true
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: event => {
            if (event.button === Qt.LeftButton && root.sink)
                root.sink.audio.muted = !root.sink.audio.muted;
            else if (event.button === Qt.RightButton)
                mixer_proc.running = true;
        }
        onWheel: event => {
            if (!root.sink)
                return;
            const delta = event.angleDelta.y > 0 ? 0.01 : -0.01;
            root.sink.audio.volume = Math.max(0, Math.min(1, root.volume + delta));
        }
    }
}
