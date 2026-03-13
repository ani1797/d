import Quickshell
import Quickshell.Hyprland
import QtQuick

ShellRoot {
    // Bar on each monitor
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: barWindow
            property var modelData

            screen: modelData
            anchors {
                top: true
                left: true
                right: true
            }

            height: 36
            color: "transparent"
            exclusionMode: ExclusionMode.Normal
            margins {
                top: 4
                left: 4
                right: 4
            }

            Bar {
                anchors.fill: parent
            }
        }
    }
}
