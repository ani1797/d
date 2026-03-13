import QtQuick
import QtQuick.Layouts

// Main bar container — Tokyo Night theme
// Palette:
//   night   = #1a1b26    storm     = #24283b
//   fg      = #c0caf5    comment   = #565f89
//   blue    = #7aa2f7    magenta   = #bb9af7
//   red     = #f7768e    green     = #9ece6a

Rectangle {
    id: bar
    color: "#1a1b26"
    radius: 8

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        spacing: 0

        // ── Left: Workspaces ────────────────────────────────────────────
        Workspaces {
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        }

        // ── Center: Clock ───────────────────────────────────────────────
        Item {
            Layout.fillWidth: true
        }

        Clock {
            Layout.alignment: Qt.AlignCenter | Qt.AlignVCenter
        }

        Item {
            Layout.fillWidth: true
        }

        // ── Right: System tray ──────────────────────────────────────────
        SystemTray {
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        }
    }
}
