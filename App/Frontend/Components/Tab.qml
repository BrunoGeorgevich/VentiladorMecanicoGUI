import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

TabButton {
    id: tabButton
    property string fullSizeText: ""

    height: implicitHeight

    background: Rectangle {
        anchors.fill: parent
        color: tabButton.checked ? root.foregroudColor : root.backgroundColor

        Rectangle {
            anchors {
                top: parent.top
                right: parent.right
                margins: 5
            }

            width: 20; height: width
            radius: width/2
            
            color: root.backgroundColor
        }
    }

    contentItem: ColumnLayout {
        anchors.fill: parent
        Label {
            Layout.fillWidth: true
            Layout.fillHeight: true
            horizontalAlignment: "AlignHCenter"
            verticalAlignment: "AlignVCenter"
            color: tabButton.checked ? root.backgroundColor : root.accentColor
            font { bold: true; pointSize: 20 }
            text: tabButton.text
        }
        Label {
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            horizontalAlignment: "AlignHCenter"
            color: tabButton.checked ? root.backgroundColor : root.accentColor
            font.pointSize: 12
            text: tabButton.fullSizeText
        }
    }
}