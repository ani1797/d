import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

// Workspace indicator pills — reads from Hyprland IPC
RowLayout {
    id: workspaces
    spacing: 4

    Repeater {
        model: 9

        Rectangle {
            id: pill
            required property int index

            property int wsId: index + 1
            property bool active: Hyprland.focusedMonitor?.activeWorkspace?.id === wsId
            property bool occupied: {
                for (var i = 0; i < Hyprland.workspaces.values.length; i++) {
                    if (Hyprland.workspaces.values[i].id === wsId) return true;
                }
                return false;
            }

            width: active ? 28 : (occupied ? 20 : 8)
            height: 8
            radius: 4
            color: active ? "#7aa2f7" : (occupied ? "#565f89" : "#24283b")

            Behavior on width {
                NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
            }
            Behavior on color {
                ColorAnimation { duration: 150 }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Hyprland.dispatch("workspace " + wsId)
            }
        }
    }
}
