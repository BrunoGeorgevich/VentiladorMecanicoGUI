import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12

import "qrc:/functions/utils.js" as Utils

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
        if (name === undefined) return ''
        let preffix = settings.preffix !== undefined ? settings.preffix : ''

        let value = system.operation_mode_controller.operation_mode.parameters[name]
        value = value !== undefined ? value : ''
        return `${preffix}${Utils.parseNumber(value)}`
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

                    anchors {
                        fill: parent
                        margins:-7
                    }
                    
                    text: settings.label || ""
        
                    background: Rectangle {
                        color: system.dashboard_controller.dashboard_command[settings.key] ? Material.color(Material.Green) : 
                                                                                             Material.color(Material.Red) 
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
                        system.dashboard_controller.toggle_dashboard_command_status(settings.key)
                        clickAction(system.dashboard_controller.dashboard_command[settings.key])
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

                                text: valueToText()
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
                        let label = settings.label;
                        let name = settings.name;
                        let step = settings.step;
                        let interval = settings.interval;
                        let value = system.operation_mode_controller.operation_mode.parameters[name];
                        clickAction(value, name, label, step, interval)
                    }
                }
            }

            // Type: indicator
            Rectangle {
                id: indicatorTemplate
                property int fakeAlarmCounter: 0
                property int fakeAlarmThreshold: 5
                anchors {
                    fill: parent
                    margins: -7
                }
                visible: settings.type === 'indicator'
                color: system.alarm_controller.check_value(settings.key, indicatorValueLabel.indicatorParseValue()) ? 
                            "transparent" : Material.color(Material.Red)

                onColorChanged: {
                    if (settings.type === 'indicator') {
                        print(`FAKE ALARM COUNTER :: ${fakeAlarmCounter}`)
                        print(indicatorTemplate.color, system.alarm_controller.check_value(settings.key, indicatorValueLabel.indicatorParseValue()))
                        if (!system.alarm_controller.check_value(settings.key, indicatorValueLabel.indicatorParseValue())) {
                            if (!alarmSound.isPlaying) {
                                print("PLAYING ALARM SOUND!")
                                alarmSound.playAlarm()
                            }
                        } else {
                            if (alarmSound.isPlaying) {
                                print("STOPPING ALARM SOUND!")
                                alarmSound.stopAlarm()
                            }
                        }
                    }
                }

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
                                id: indicatorValueLabel

                                function indicatorParseValue() {
                                    if (rootMenuItem.indicatorsValues !== undefined) {
                                        if (settings.key !== undefined) {
                                            if (settings.key === "vol_min") {
                                                let ve = rootMenuItem.indicatorsValues["ve"]
                                                let rr = system.operation_mode_controller.operation_mode.parameters["rr"]
                                                return Utils.parseNumber(rr*ve/1000)
                                            }
                                            else if (rootMenuItem.indicatorsValues[settings.key] !== undefined) {
                                                if (parseFloat(rootMenuItem.indicatorsValues[settings.key])) {
                                                    let divideBy = 1
                                                    if(settings.divideBy) {
                                                        divideBy = settings.divideBy
                                                    }
                                                    return Utils.parseNumber(rootMenuItem.indicatorsValues[settings.key]/divideBy)
                                                }
                                            }
                                        }
                                    }
                                    return "-"
                                }

                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                text: indicatorValueLabel.indicatorParseValue()
                                font { pointSize: 22; bold: true }
                                fontSizeMode: "Fit"
                                color: root.accentColor
                                verticalAlignment: "AlignVCenter"
                                horizontalAlignment: "AlignHCenter"
                            }
                            Label {
                                Layout.fillHeight: true
                                Layout.preferredWidth: 35

                                function getLimits(key) {
                                    let min = system.alarm_controller.get_min(key)
                                    let max = system.alarm_controller.get_max(key)

                                    return `${max}\n${min}`
                                }

                                text: getLimits(settings.key)
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