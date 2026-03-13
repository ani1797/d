import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

// Workspace indicator pills — reads from Hyprland IPC
RowLayout {
    id: workspaces
    spacing: 6

    Repeater {
        model: 9

        Rectangle {
            id: pill
            required property int index

            property int wsId: index + 1
            property var hyprland: Hyprland.focusedMonitor
            property bool active: hyprland && hyprland.activeWorkspace && hyprland.activeWorkspace.id === wsId
            property bool occupied: {
                if (!Hyprland.workspaces || !Hyprland.workspaces.values) return false;
                for (var i = 0; i < Hyprland.workspaces.values.length; i++) {
                    if (Hyprland.workspaces.values[i].id === wsId) return true;
                }
                return false;
            }

            Layout.preferredWidth: active ? 32 : (occupied ? 24 : 10)
            Layout.preferredHeight: 10
            radius: 5
            color: active ? "#7aa2f7" : (occupied ? "#565f89" : "#24283b")

            border.color: active ? "#bb9af7" : "transparent"
            border.width: active ? 1 : 0

            Behavior on Layout.preferredWidth {
                NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
            }
            Behavior on color {
                ColorAnimation { duration: 200 }
            }
            Behavior on border.color {
                ColorAnimation { duration: 200 }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true

                onEntered: {
                    if (!active) {
                        pill.scale = 1.1
                    }
                }
                onExited: {
                    pill.scale = 1.0
                }
                onClicked: {
                    Hyprland.dispatch("workspace " + wsId)
                }
            }

            Behavior on scale {
                NumberAnimation { duration: 100 }
            }
        }
    }
}
