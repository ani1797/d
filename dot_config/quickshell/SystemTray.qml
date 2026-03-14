import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

// System tray — right side of bar (enhanced with interactive controls)
RowLayout {
    id: systemTray
    spacing: 16

    // ── Dynamic Volume Indicator ────────────────────────────────────────
    Text {
        id: volumeIndicator
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 14
        color: "#7aa2f7"
        text: "󰕾 100%"

        property string volumeIcon: "󰕾"
        property string volumeColor: "#7aa2f7"
        property int volumePercent: 100

        // Poll volume status every 500ms
        Timer {
            interval: 500
            running: true
            repeat: true
            onTriggered: {
                // Read volume status from script
                var process = Qt.createQmlObject(
                    'import Quickshell.Io; Process { command: ["/home/anirudh/.config/hypr/scripts/volume-status.sh"]; running: true }',
                    volumeIndicator,
                    "volumeStatusProcess"
                );

                process.finished.connect(function() {
                    var output = process.stdout.trim();
                    if (output) {
                        var parts = output.split('|');
                        if (parts.length === 3) {
                            volumeIndicator.volumeIcon = parts[0];
                            volumeIndicator.volumeColor = parts[1];
                            volumeIndicator.volumePercent = parseInt(parts[2]);
                            volumeIndicator.text = volumeIndicator.volumeIcon + " " + volumeIndicator.volumePercent + "%";
                            volumeIndicator.color = volumeIndicator.volumeColor;
                        }
                    }
                    process.destroy();
                });
            }
        }

        // Initial load
        Component.onCompleted: {
            var process = Qt.createQmlObject(
                'import Quickshell.Io; Process { command: ["/home/anirudh/.config/hypr/scripts/volume-status.sh"]; running: true }',
                volumeIndicator,
                "volumeStatusInit"
            );

            process.finished.connect(function() {
                var output = process.stdout.trim();
                if (output) {
                    var parts = output.split('|');
                    if (parts.length === 3) {
                        volumeIndicator.volumeIcon = parts[0];
                        volumeIndicator.volumeColor = parts[1];
                        volumeIndicator.volumePercent = parseInt(parts[2]);
                        volumeIndicator.text = volumeIndicator.volumeIcon + " " + volumeIndicator.volumePercent + "%";
                        volumeIndicator.color = volumeIndicator.volumeColor;
                    }
                }
                process.destroy();
            });
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            // Click to open pavucontrol
            onClicked: {
                Qt.createQmlObject(
                    'import Quickshell.Io; Process { command: ["pavucontrol"]; running: true }',
                    parent,
                    "pavucontrol"
                );
            }

            // Scroll to adjust volume
            onWheel: function(wheel) {
                if (wheel.angleDelta.y > 0) {
                    // Scroll up - increase volume
                    Qt.createQmlObject(
                        'import Quickshell.Io; Process { command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%+"]; running: true }',
                        parent,
                        "volumeUp"
                    );
                } else if (wheel.angleDelta.y < 0) {
                    // Scroll down - decrease volume
                    Qt.createQmlObject(
                        'import Quickshell.Io; Process { command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%-"]; running: true }',
                        parent,
                        "volumeDown"
                    );
                }
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

    // ── Date + Time with Calendar Popup ─────────────────────────────────
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

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                Qt.createQmlObject(
                    'import Quickshell.Io; Process { command: ["/home/anirudh/.config/hypr/scripts/calendar.sh"]; running: true }',
                    parent,
                    "calendar"
                );
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

    // ── Power Button ────────────────────────────────────────────────────
    Text {
        id: powerButton
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 14
        color: "#f7768e"
        text: "󰐥"

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                Qt.createQmlObject(
                    'import Quickshell.Io; Process { command: ["/home/anirudh/.config/hypr/scripts/power-menu.sh"]; running: true }',
                    parent,
                    "powerMenu"
                );
            }
        }
    }
}
