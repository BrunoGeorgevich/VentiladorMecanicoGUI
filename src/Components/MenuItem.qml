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
    
    Rectangle {
        property real margin: settings.type === 'status' ? 0 : 8
        anchors.fill: parent
        color: root.accentColor
        
        Item {
            height: parent.height - 2 * parent.margin
            width: parent.width - 2 * parent.margin
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
                    color: root.foregroundColor
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
                        color: root.foregroundColor
                        horizontalAlignment: 'AlignHCenter'
                        verticalAlignment: 'AlignVCenter'
                        font.bold: true
                        text: settings.label || ''
                    }
                    Label {
                        width: parent.width
                        height: parent.height*0.60
                        color: root.foregroundColor
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
                                color: root.foregroundColor
                                verticalAlignment: 'AlignTop'
                                text: settings.min || ''
                            }
                            Label {
                                height: parent.height
                                width: parent.width/3    
                                textFormat: Text.RichText
                                color: root.foregroundColor
                                verticalAlignment: 'AlignTop'
                                horizontalAlignment: 'AlignHCenter'
                                font.bold: true
                                text: settings.unit || ''
                            }
                            Label {
                                height: parent.height
                                width: parent.width/3  
                                color: root.foregroundColor
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

            // Type: indicator
            Item {
                id: indicatorTemplate
                anchors.fill: parent
                visible: settings.type === 'indicator'
                ColumnLayout {
                    anchors.fill: parent

                    Item {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 20
                        
                        RowLayout {
                            anchors.fill: parent
                            Label {
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                text: settings.name || ''
                                font { pointSize: 9; bold: true }
                                color: root.foregroundColor
                                textFormat: Text.RichText
                                verticalAlignment: "AlignVCenter"
                            }
                            Label {
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                text: settings.unit || ''
                                font { pointSize: 9 }
                                textFormat: Text.RichText
                                color: root.foregroundColor
                                horizontalAlignment: "AlignRight"
                                verticalAlignment: "AlignVCenter"
                            }
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        
                        RowLayout {
                            anchors.fill: parent
                            Label {
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                text: `${settings.value}` || ''
                                font { pointSize: 22; bold: true }
                                color: settings.color || root.foregroundColor
                                verticalAlignment: "AlignVCenter"
                                horizontalAlignment: "AlignHCenter"
                            }
                            Label {
                                Layout.fillHeight: true
                                Layout.preferredWidth: 35

                                text: `${settings.max}\n${settings.min}` || '-\n-'
                                font { pointSize: 8 }
                                color: root.foregroundColor
                                horizontalAlignment: "AlignHCenter"
                                verticalAlignment: "AlignVCenter"
                            }
                        }
                    }
                }
            }
        }
    }
}