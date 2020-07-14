import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12

Rectangle {
    id: rootMenuItem
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.maximumWidth: settings.width || -1
    
    property var settings
    property var clickAction
    property var indicatorsValues

    function toPercent() {
        let name = settings.parameterName
        if (name === undefined) return undefined
        let value = system.operation_mode_controller.operation_mode.parameters[name]
        if (value === undefined) return undefined

        let min = settings.min
        let max = settings.max

        return (value - min) / (max - min)
    }

    function valueToText() {
        let name = settings.name
        if (name === undefined) return undefined
        let preffix = settings.preffix || ''

        let value = system.operation_mode_controller.operation_mode.parameters[name]
        value = value || ''
        return `${preffix}${value}`
    }

    function unitParse() {
        if (settings.twoUnits) {
            let value = system.operation_mode_controller.operation_mode.parameters[settings.unitSelector]
            if (value === settings.unitConditional) {
                return settings.unit || ''
            } else {
                return settings.secondaryUnit || ''
            }
        } else {
                return settings.unit || ''
        }
    }
    
    Rectangle {
        property real margin: settings.type === 'status' ? 0 : 8
        anchors.fill: parent
        color: root.primaryColor
        
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
                    color: root.accentColor
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
            
            // Type: toggle
            Item {
                id: toggleTemplate
                anchors.fill: parent
                visible: settings.type === 'toggle'

                Button {
                    id: toggleButton
                    property string operating: "false"
                    property var buttonColor: { "true": Material.color(Material.Green), "false": Material.color(Material.Red) }

                    anchors {
                        fill: parent
                        margins:-7
                    }
                    
                    text: settings.label || ""
        
                    background: Rectangle {
                        color: toggleButton.buttonColor[toggleButton.operating]
                    }

                    contentItem: Label {
                        anchors.fill: parent
                        horizontalAlignment: "AlignHCenter"
                        verticalAlignment: "AlignVCenter"
                        font { pointSize: 20; bold: true }
                        fontSizeMode: "Fit"
                        color: "#FFFFFF"
                        text: parent.text
                    }

                    onClicked: { 
                        operating = operating === "true" ? "false" : "true"
                        clickAction(operating === "true")
                    }
                }
            }
                
            // Type: item
            Item {
                id: itemTemplate
                anchors.fill: parent
                visible: settings.type === 'item'
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 5
                    Item {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 15
                        
                        RowLayout {
                            anchors.fill: parent
                            Label {
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                text: settings.label || ''
                                font { pointSize: 9; bold: true }
                                color: root.foregroundColor
                                textFormat: Text.RichText
                                verticalAlignment: "AlignVCenter"
                            }
                            Label {
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                text: unitParse() || ''
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

                                text: valueToText() || ''
                                font { pointSize: 22; bold: true }
                                fontSizeMode: "Fit"
                                color: root.accentColor
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
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        let value = system.operation_mode_controller.operation_mode.parameters[name];
                        clickAction(value, name)
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
                    spacing: 5

                    Item {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 15
                        
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

                                text: `${rootMenuItem.indicatorsValues[settings.key]}` || '-'
                                font { pointSize: 22; bold: true }
                                fontSizeMode: "Fit"
                                color: root.accentColor
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