import Quickshell

ShellRoot {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: window
            property var modelData

            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 32
            Bar {
                anchors.fill: parent
                screen: window.screen
            }
        }
    }
}
