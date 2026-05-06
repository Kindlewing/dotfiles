import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import qs.modules.common

Scope {
    id: bar

    Variants {
        model: Quickshell.screens
        // qmllint disable uncreatable-type
        PanelWindow {
            id: barWindow
            required property ShellScreen modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }
            implicitHeight: 34
            color: Appearance.background

            PwObjectTracker {
                objects: [Pipewire.defaultAudioSink]
            }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 12
                anchors.rightMargin: 8
                spacing: 0

                // Arch logo
                Text {
                    text: ""
                    color: Appearance.blue
                    font.pixelSize: 20
                    font.family: "NotoSans Nerd Font"
                    Layout.rightMargin: 8
                }

                Item {
                    Layout.fillWidth: true
                }

                // Clock
                Text {
                    id: clockText
                    color: Appearance.foreground
                    font.pixelSize: 13
                    font.family: "NotoSans Nerd Font"

                    function refresh() {
                        text = Qt.formatDateTime(new Date(), "ddd, MMM d  hh:mm");
                    }
                    Component.onCompleted: refresh()

                    Timer {
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: clockText.refresh()
                    }
                }

                Item {
                    Layout.fillWidth: true
                }

                // Volume
                RowLayout {
                    id: volumeRow
                    spacing: 4
                    Layout.rightMargin: 10

                    readonly property PwNode sink: Pipewire.defaultAudioSink
                    readonly property real vol: sink?.audio?.volume ?? 0.0
                    readonly property bool muted: sink?.audio?.muted ?? false

                    Text {
                        text: {
                            if (volumeRow.muted || volumeRow.vol === 0.0)
                                return "󰖁";
                            if (volumeRow.vol >= 0.67)
                                return "󰕾";
                            if (volumeRow.vol >= 0.33)
                                return "󰖀";
                            return "󰕿";
                        }
                        color: volumeRow.muted ? Appearance.subtle : Appearance.green
                        font.pixelSize: 15
                        font.family: "NotoSans Nerd Font"
                    }

                    Text {
                        text: volumeRow.muted ? "mute" : Math.round(volumeRow.vol * 100) + "%"
                        color: volumeRow.muted ? Appearance.subtle : Appearance.foreground
                        font.pixelSize: 13
                        font.family: "NotoSans Nerd Font"
                        horizontalAlignment: Text.AlignRight
                        Layout.minimumWidth: 38
                    }
                }

                // System tray
                RowLayout {
                    spacing: 4
                    Repeater {
                        model: SystemTray.items

                        delegate: Item {
                            id: trayDelegate
                            required property SystemTrayItem modelData

                            implicitWidth: 22
                            implicitHeight: 22
                            Layout.alignment: Qt.AlignVCenter

                            IconImage {
                                anchors.centerIn: parent
                                width: 16
                                height: 16
                                source: trayDelegate.modelData.icon
                            }

                            // QsMenuAnchor derives window automatically from anchor.item;
                            // do NOT set anchor.window — setWindow() calls setItem(null)
                            // which then crashes in onItemWindowChanged.
                            QsMenuAnchor {
                                id: trayMenu
                                anchor.item: trayDelegate
                                menu: trayDelegate.modelData.menu
                            }

                            MouseArea {
                                anchors.fill: parent
                                acceptedButtons: Qt.LeftButton | Qt.RightButton
                                onClicked: mouse => {
                                    if (mouse.button === Qt.RightButton) {
                                        if (trayDelegate.modelData.hasMenu) {
                                            if (trayMenu.visible)
                                                trayMenu.close();
                                            else
                                                trayMenu.open();
                                        }
                                    } else {
                                        trayDelegate.modelData.activate();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
