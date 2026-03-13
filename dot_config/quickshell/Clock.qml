import QtQuick
import QtQuick.Layouts

// Clock widget — center of bar
Item {
    id: clock
    implicitWidth: timeText.implicitWidth + 16
    implicitHeight: parent.height

    property bool showDate: false

    Text {
        id: timeText
        anchors.centerIn: parent
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 13
        font.bold: true
        color: "#c0caf5"
        text: Qt.formatDateTime(new Date(), showDate ? "ddd, MMM d  HH:mm" : "HH:mm")
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: timeText.text = Qt.formatDateTime(
            new Date(),
            clock.showDate ? "ddd, MMM d  HH:mm" : "HH:mm"
        )
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: clock.showDate = !clock.showDate
    }
}
