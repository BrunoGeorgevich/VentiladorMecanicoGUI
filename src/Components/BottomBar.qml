import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ToolBar {

    property bool hasLeftButton: true
    property bool hasRightButton: true
    property var leftButtonAction: () => { console.log("LEFT BUTTON PRESSED") }
    property var rightButtonAction: () => { console.log("RIGHT BUTTON PRESSED") }

    height: 70

    background: Item {}

    RowLayout {
        anchors { fill: parent; margins: 7 }
        implicitWidth: root.width
        RoundButton {
            Layout.preferredHeight: parent.height
            Layout.preferredWidth: parent.height
            visible: hasLeftButton

            background: Rectangle { color: root.accentColor; radius: height/2 }

            contentItem: Label {
                anchors.fill: parent
                horizontalAlignment: "AlignHCenter"
                verticalAlignment: "AlignVCenter"
                font.pointSize: 22
                color: "white"
                text: "⮜"
            }

            onClicked: leftButtonAction()
        }
        Item { Layout.fillWidth: true }
        RoundButton {
            Layout.preferredHeight: parent.height
            Layout.preferredWidth: parent.height
            visible: hasRightButton

            background: Rectangle { color: root.accentColor; radius: height/2 }

            contentItem: Label {
                anchors.fill: parent
                horizontalAlignment: "AlignHCenter"
                verticalAlignment: "AlignVCenter"
                font.pointSize: 22
                color: "white"
                text: "⮞"
            }
            onClicked: rightButtonAction()
        }
    }
}