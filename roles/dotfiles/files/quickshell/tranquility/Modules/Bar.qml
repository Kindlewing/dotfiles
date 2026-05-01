import QtQuick
import QtQuick.Layouts
import Quickshell

// qmllint disable uncreatable-type
PanelWindow {
    id: bar
    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: Gruvbox.barHeight
    exclusiveZone: Gruvbox.barHeight

    color: Gruvbox.bg

    // Bottom border — #1d2021, 2px
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 2
        color: Gruvbox.bg_h
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // ── Left (empty for now) ──────────────────────
        Item {
            Layout.fillWidth: true
        }

        // ── Center ───────────────────────────────────
        Clock {
            Layout.alignment: Qt.AlignVCenter
        }

        // ── Right ─────────────────────────────────────
        Item {
            Layout.fillWidth: true
        }

        RowLayout {
            spacing: 0
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight

            VPN {}
            Networking {}
            Battery {}
            Microphone {}
            Volume {}
        }
    }
}
