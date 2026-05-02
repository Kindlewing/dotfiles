import QtQuick
import Quickshell.Services.Pipewire

Item {
    id: root
    implicitHeight: Gruvbox.bar_height
    implicitWidth: muted ? 0 : mic_text.implicitWidth + Gruvbox.padding * 2
    visible: !muted

    PwObjectTracker {
        id: source_tracker
        objects: Pipewire.defaultAudioSource ? [Pipewire.defaultAudioSource] : []
    }

    property var source: source_tracker.objects[0] ?? null
    property bool muted:  source?.audio?.muted  ?? false
    property real volume: source?.audio?.volume ?? 0

    Text {
        id: mic_text
        anchors.centerIn: parent
        text: `  ${Math.round(root.volume * 100)}%`
        color: Gruvbox.aqua
        font.family: Gruvbox.font
        font.pixelSize: Gruvbox.font_size
        font.bold: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: if (root.source) root.source.audio.muted = !root.source.audio.muted
        onWheel: (event) => {
            if (!root.source) return
            const delta = event.angleDelta.y > 0 ? 0.02 : -0.02
            root.source.audio.volume = Math.max(0, Math.min(1, root.volume + delta))
        }
    }
}
