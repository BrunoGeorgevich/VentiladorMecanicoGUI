import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Rectangle {
    id: rootMenuItem
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.maximumWidth: settings.width || -1
    
    property var settings
    property var clickAction
    
    Item {
        property real margin: settings.type === 'status' ? 0 : 5
        height: parent.height - 2 * margin
        width: parent.width - 2 * margin
        anchors.centerIn: parent
        
        // Type: status
        Item {
            id: statusTemplate
            anchors.fill: parent
            visible: settings.type === 'status'
            
            Rectangle {
                anchors.fill: parent
                color: settings.action === 'Stopped' ? '#F00' : '#0F0'
            
                Label {
                    anchors.fill: parent
                    horizontalAlignment: 'AlignHCenter'
                    verticalAlignment: 'AlignVCenter'
                    wrapMode: Text.Wrap
                    color: "#FF0"
                    font { bold: true; pointSize: 14 }
                    text: `Status: ${settings.action} ${settings.mode}` 
                }
            }
        }
        
        // Type: button
        Item {
            id: buttonTemplate
            anchors.fill: parent
            visible: settings.type === 'button'
            
            Label {
                id: buttonLabel
                anchors.fill: parent
                horizontalAlignment: 'AlignHCenter'
                verticalAlignment: 'AlignVCenter'
                wrapMode: Text.Wrap
                font { bold: true; pointSize: 14 }
                text: settings.label || ''
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor        
                onClicked: clickAction()
            }
        }
            
        // Type: item
        Item {
            id: itemTemplate
            anchors.fill: parent
            visible: settings.type === 'item'
            
            Column {
                anchors.fill: parent
                Label {
                    id: itemLabel
                    width: parent.width
                    height: parent.height*0.1
                    horizontalAlignment: 'AlignHCenter'
                    verticalAlignment: 'AlignVCenter'
                    font.bold: true
                    text: settings.label || ''
                }
                Label {
                    width: parent.width
                    height: parent.height*0.60
                    horizontalAlignment: 'AlignHCenter'
                    verticalAlignment: 'AlignVCenter'
                    font { bold: true; pointSize:22 }
                    text: settings.value || ''
                }
                
                Item {
                    width: parent.width
                    height: parent.height*0.25
                    Row {
                        anchors.fill: parent
                        Label {
                            height: parent.height
                            width: parent.width/3  
                            verticalAlignment: 'AlignTop'
                            text: settings.min || ''
                        }
                        Label {
                            height: parent.height
                            width: parent.width/3    
                            textFormat: Text.RichText
                            verticalAlignment: 'AlignTop'
                            horizontalAlignment: 'AlignHCenter'
                            font.bold: true
                            text: settings.unit || ''
                        }
                        Label {
                            height: parent.height
                            width: parent.width/3  
                            verticalAlignment: 'AlignTop'
                            horizontalAlignment: 'AlignRight'
                            text: settings.max || ''
                        }
                    }
                }
                
                ProgressBar {
                    value: 0.5
                    width: parent.width
                }
            }
        }
    }
}