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
                
                model: system.alarm_message_controller.items
                delegate: Rectangle {
                    height: alertListItemLabel.implicitHeight + 10
                    width: alertSideBarRoot.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: alertSideBarRoot.colorParse(msgColor)
                    radius: 15

                    Label {
                        id: alertListItemLabel
                        anchors {
                            left: parent.left
                            right: alertListItemRoundButton.left
                            top: parent.top
                            bottom: parent.bottom
                            margins: 5
                        }
                        verticalAlignment: "AlignVCenter"
                        text: message
                        color: root.foregroundColor
                        font.pointSize: 18
                        wrapMode: "Wrap"
                    }

                    RoundButton {
                        id: alertListItemRoundButton
                        height: 30
                        width: height

                        anchors {
                            right: parent.right
                            rightMargin: 5
                            verticalCenter: parent.verticalCenter
                        }
        
                        background: Rectangle {
                            radius: parent.height/2
                            color: parent.pressed ? Qt.lighter(root.backgroundColor, 2) : root.backgroundColor
                        }

                        contentItem: Label { 
                            horizontalAlignment: "AlignHCenter"
                            verticalAlignment: "AlignVCenter"
                            font { pointSize: 20; bold: true }
                            fontSizeMode: "Fit"
                            color: parent.pressed ? Qt.lighter(root.accentColor, 2) : root.accentColor
                            text: "X"
                        }

                        onClicked: {
                            system.alarm_message_controller.remove_alarm_message(index)
                        }
                    }
                }
            }

            Label {
                anchors.fill: parent
                visible: system.alarm_message_controller.isEmpty
                horizontalAlignment: "AlignHCenter"
                font {
                    pointSize: 20
                    bold: true
                }
                color: root.accentColor
                text: "Lista de alarmes está vazia!"
            }
        }
    }
}