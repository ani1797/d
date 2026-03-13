import QtQuick
import QtQuick.Layouts
import Quickshell

// System tray — right side of bar (simple indicators)
RowLayout {
    id: systemTray
    spacing: 16

    // ── Volume Indicator ────────────────────────────────────────────────
    Text {
        id: volumeIcon
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 14
        color: "#7aa2f7"
        text: "󰕾 VOL"

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                // Open volume control (pavucontrol)
                Qt.createQmlObject('import Quickshell.Io; Process { command: ["pavucontrol"]; running: true }', parent, "volumeControl");
            }
        }
    }

    // ── Separator ───────────────────────────────────────────────────────
    Rectangle {
        width: 1
        height: 18
        color: "#24283b"
        Layout.alignment: Qt.AlignVCenter
    }

    // ── Date + Time ─────────────────────────────────────────────────────
    Text {
        id: dateTimeText
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 13
        color: "#c0caf5"
        text: Qt.formatDateTime(new Date(), "ddd d MMM")

        Timer {
            interval: 60000
            running: true
            repeat: true
            onTriggered: dateTimeText.text = Qt.formatDateTime(new Date(), "ddd d MMM")
        }

        Component.onCompleted: {
            dateTimeText.text = Qt.formatDateTime(new Date(), "ddd d MMM")
        }
    }
}
