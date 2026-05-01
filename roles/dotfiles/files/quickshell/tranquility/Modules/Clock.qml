import QtQuick

Text {
    color: Theme.foreground
    font.pixelSize: Theme.fontSize
    text: Qt.formatDateTime(new Date(), "hh:mm")

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: parent.text = Qt.formatDateTime(new Date(), "hh:mm")
    }
}
