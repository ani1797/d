import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

// System tray — right side of bar (volume, battery indicator)
RowLayout {
    id: systemTray
    spacing: 12

    // ── Volume ──────────────────────────────────────────────────────────
    Text {
        id: volumeIcon
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 14
        color: "#c0caf5"
        text: "󰕾"

        property int volumeLevel: 50
        property bool muted: false

        function updateIcon() {
            if (muted) {
                text = "󰖁";
                color = "#565f89";
            } else if (volumeLevel > 66) {
                text = "󰕾";
                color = "#c0caf5";
            } else if (volumeLevel > 33) {
                text = "󰖀";
                color = "#c0caf5";
            } else if (volumeLevel > 0) {
                text = "󰕿";
                color = "#c0caf5";
            } else {
                text = "󰖁";
                color = "#565f89";
            }
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: volumeProcess.running = true
        }

        Process {
            id: volumeProcess
            command: ["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"]
        }

        // Poll volume level every 2 seconds
        Process {
            id: volumePoll
            command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
            running: true
            onExited: {
                var output = stdout.trim();
                // Output format: "Volume: 0.50 [MUTED]"
                var parts = output.split(" ");
                if (parts.length >= 2) {
                    volumeIcon.volumeLevel = Math.round(parseFloat(parts[1]) * 100);
                    volumeIcon.muted = output.indexOf("MUTED") >= 0;
                    volumeIcon.updateIcon();
                }
                volumePollTimer.restart();
            }
        }

        Timer {
            id: volumePollTimer
            interval: 2000
            running: true
            repeat: false
            onTriggered: volumePoll.running = true
        }
    }

    // ── Separator ───────────────────────────────────────────────────────
    Rectangle {
        width: 1
        height: 16
        color: "#24283b"
        Layout.alignment: Qt.AlignVCenter
    }

    // ── Date + Time (compact) ───────────────────────────────────────────
    Text {
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 12
        color: "#565f89"
        text: Qt.formatDateTime(new Date(), "ddd d MMM")

        Timer {
            interval: 60000
            running: true
            repeat: true
            onTriggered: parent.text = Qt.formatDateTime(new Date(), "ddd d MMM")
        }
    }
}
