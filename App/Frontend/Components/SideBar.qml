import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
            
Rectangle {
    id:sideBarRoot
    property real value: -1
    property string key: "no_key"

    signal save(var value, var key)

    function open(value, key) {
        sideBarRoot.value = value
        sideBarRoot.key = key
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
                verticalAlignment: "AlignVCenter"
                horizontalAlignment: "AlignHCenter"
                anchors.fill: parent
                text: `${sideBarRoot.value}`
                color: root.accentColor
                font.pixelSize: 40
            }
        }
        SideBarButton {
            Layout.fillHeight: true
            Layout.fillWidth: true
            text: "CANCELAR"

            onClicked: {
                sideBarRoot.close()
            }
        }
        SideBarButton {
            Layout.fillHeight: true
            Layout.fillWidth: true
            text: "SALVAR"

            onClicked: {
                sideBarRoot.save(sideBarRoot.value, sideBarRoot.key)
                sideBarRoot.close()
            }
        }
    }
}