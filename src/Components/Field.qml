import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    id: fieldRoot
    property real fontSize: 20
    property string name: "NO NAME"
    property Component control: idDefaultComponent

    Column {
        anchors.fill: parent

        Label {
            width: parent.width; height: parent.height/2
            verticalAlignment: "AlignVCenter"
            horizontalAlignment: "AlignHCenter"

            text: fieldRoot.name
            font { pointSize: fontSize; bold: true }
        }
        Item {
            width: parent.width; height: parent.height/2
            Loader {
                id: controlLoader
                anchors.centerIn: parent
                sourceComponent: control
            }
        }
    }

    Component {
        id: idDefaultComponent
        Rectangle { anchors.fill: parent; color: "red" }
    }
}