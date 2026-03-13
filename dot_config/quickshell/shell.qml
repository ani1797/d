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

            height: 34
            color: "transparent"
            exclusionMode: ExclusionMode.Normal

            Bar {
                anchors.fill: parent
            }
        }
    }
}
