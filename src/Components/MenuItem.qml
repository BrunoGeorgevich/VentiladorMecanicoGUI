import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    Layout.fillWidth: true
    Layout.fillHeight: true
    
    property var settings
    property var clickAction
    
    ToolButton {
        anchors.fill: parent
        visible: settings.type === 'button'
        text: settings['label']
        onClicked: clickAction()
    }
    
    Item {
        anchors.fill: parent
        visible: settings.type === 'item'
        
        Label {
            anchors.fill: parent
            horizontalAlignment: 'AlignHCenter'
            verticalAlignment: 'AlignVCenter'
            text: settings.label 
        }
    }
}