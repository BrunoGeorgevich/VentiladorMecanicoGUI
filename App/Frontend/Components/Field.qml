import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    id: fieldRoot
    property real fontSize: 20
    property string name: "NO NAME"
    property Component control: idDefaultComponent

    implicitWidth: Math.max(controlLoader.implicitWidth, fieldLabel.implicitWidth)
    implicitHeight: controlLoader.implicitHeight + controlLoader.anchors.topMargin + fieldLabel.implicitHeight

    Label {
        id: fieldLabel
        verticalAlignment: "AlignVCenter"
        horizontalAlignment: "AlignHCenter"
        anchors.horizontalCenter: parent.horizontalCenter

        text: fieldRoot.name
        color: root.secondaryColor
        font { pointSize: fontSize; bold: true }
    }
    Loader {
        id: controlLoader
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: fieldLabel.bottom
            topMargin: 10
        }
        sourceComponent: control
    }

    Component {
        id: idDefaultComponent
        Rectangle { color: "red" }
    }
}