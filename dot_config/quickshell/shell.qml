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

            height: 40
            color: "transparent"
            exclusionMode: ExclusionMode.Exclusive
            margins {
                top: 0
                left: 0
                right: 0
            }

            Bar {
                anchors.fill: parent
                anchors.margins: 4
            }
        }
    }
}
