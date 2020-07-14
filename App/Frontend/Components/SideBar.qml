import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
            
Rectangle {
    id:sideBarRoot
    property real value: -1
    property string key: "no_key"
    property string label: "NO NAME"

    signal save(var value, var key)

    function open(value, key, label) {
        sideBarRoot.value = value
        sideBarRoot.key = key
        sideBarRoot.label = label
        sideBarRoot.visible = true
    }

    function close() {
        sideBarRoot.visible = false
    }

    visible: false
    anchors.fill: parent 
    color: root.primaryColor

    ColumnLayout {
        anchors.fill: parent            
        spacing: 1
        SideBarButton {
            Layout.fillHeight: true
            Layout.fillWidth: true
            autoRepeat: true
            autoRepeatDelay: 300
            autoRepeatInterval: 100
            text: "+"

            onClicked: {
                if (sideBarRoot.value >= 1000) {
                    sideBarRoot.value = 1000
                } else {
                    sideBarRoot.value += 1
                }
            }
        }
        SideBarButton {
            Layout.fillHeight: true
            Layout.fillWidth: true
            autoRepeat: true
            autoRepeatDelay: 300
            autoRepeatInterval: 100
            text: "-"

            onClicked: {
                if (sideBarRoot.value <= 0) {
                    sideBarRoot.value = 0
                } else {
                    sideBarRoot.value -= 1
                }
            }
        }
        Item {
            Layout.fillHeight: true
            Layout.minimumHeight: 96
            Layout.fillWidth: true

            Label {
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    topMargin: 5
                }
                horizontalAlignment: "AlignHCenter"
                text: `${sideBarRoot.label}`
                color: root.accentColor
                font.pixelSize: 25
                fontSizeMode: "Fit"
            }

            Label {
                anchors.centerIn: parent
                text: `${sideBarRoot.value}`
                color: root.accentColor
                font.pixelSize: 40
            }

            MouseArea {
                anchors.fill: parent
            }
        }
        SideBarButton {
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: Material.color(Material.Green)
            textColor: root.foregroundColor
            text: "SALVAR"

            onClicked: {
                sideBarRoot.save(sideBarRoot.value, sideBarRoot.key)
                sideBarRoot.close()
            }
        }
        SideBarButton {
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: Material.color(Material.Red)
            textColor: root.foregroundColor
            text: "CANCELAR"

            onClicked: {
                sideBarRoot.close()
            }
        }
    }
}