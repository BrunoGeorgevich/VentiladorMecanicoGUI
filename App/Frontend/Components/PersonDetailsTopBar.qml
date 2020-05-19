import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ToolBar {
    height: 45
    background: Rectangle {
        color: root.primaryColor
    }
    RowLayout {
        anchors { fill: parent; margins: 10 }
        Label {
            id: personDetailsLabel
            Layout.fillHeight: true
            Layout.fillWidth: true

            font { pointSize: 16; bold: true }
            color: root.foregroundColor
            verticalAlignment: "AlignVCenter"
            text: system.person_controller.details()
        }
        Label {
            id: powerDetailsLabel

            Layout.fillHeight: true
            Layout.fillWidth: true

            font { pointSize: 16; bold: true }
            color: root.foregroundColor
            horizontalAlignment: "AlignRight"
            verticalAlignment: "AlignVCenter"
            text: "100% 🔋"
        }
    }
}