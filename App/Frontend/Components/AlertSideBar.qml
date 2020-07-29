import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
            
Rectangle {
    id:alertSideBarRoot

    function colorParse(color) {
        switch(color) {
            case "good":
                return Material.color(Material.Green)
            case "bad":
                return Material.color(Material.Red)
            default:
                return Material.color(Material.Blue)
        }
    }

    function open(value, key, label, step) {
        alertSideBarRoot.visible = true
    }

    function close() {
        alertSideBarRoot.visible = false
    }

    visible: false
    color: root.primaryColor

    ColumnLayout {
        anchors.fill: parent
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            color: root.backgroundColor
            z: 2

            RowLayout {
                anchors.fill: parent

                Label {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    horizontalAlignment: "AlignHCenter"
                    verticalAlignment: "AlignVCenter"

                    color: root.accentColor
                    font.pointSize: 20
                    text: "Central de alarmes"
                }
            
                SideBarButton {
                    Layout.fillHeight: true
                    Layout.preferredWidth: height

                    color: Material.color(Material.Red)
                    textColor: root.foregroundColor
                    text: "X"

                    onClicked: {
                        alertSideBarRoot.close()
                    }
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView {
                anchors {
                    fill: parent
                    margins: 10
                }
                boundsBehavior: "StopAtBounds"
                headerPositioning: "OverlayHeader"
                spacing: 5
                
                model: system.alarm_controller.items
                delegate: Rectangle {
                    height: alertListItemLabel.implicitHeight + 10
                    width: alertSideBarRoot.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: alertSideBarRoot.colorParse(msgColor)
                    radius: 15

                    Label {
                        id: alertListItemLabel
                        anchors {
                            fill: parent
                            margins: 5
                        }
                        verticalAlignment: "AlignVCenter"
                        text: message
                        color: root.foregroundColor
                        font.pointSize: 18
                        wrapMode: "Wrap"
                    }
                }
            }
        }
    }
}