import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ToolBar {

    property var person: {}

    height: 45
    background: Rectangle {
        color: root.accentColor
    }
    RowLayout {
        anchors { fill: parent; margins: 10 }
        Label {
            id: personDetailsLabel

            function parseGender(gender) {
                switch (gender) {
                    case 'male':
                        return "♂"
                    case "female":
                        return "♀"
                    default:
                        return "?"
                }
            }

            Layout.fillHeight: true
            Layout.fillWidth: true

            font { pointSize: 16; bold: true }
            color: root.foregroundColor
            verticalAlignment: "AlignVCenter"
            text: `${person.name || "Paciente"} (${parseGender(person.gender)}) [${person.height} cm]`
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