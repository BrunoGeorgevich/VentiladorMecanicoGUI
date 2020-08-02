import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Qt.labs.qmlmodels 1.0

import "qrc:/components"

Page {
    objectName: "AlarmPage"
    id: alarmSettingsPageRoot

    ListView {
        anchors.fill: parent
        model: system.alarm_controller.items
        boundsBehavior: "StopAtBounds"
        headerPositioning: "OverlayHeader"
        header: Rectangle {
            width: alarmSettingsPageRoot.width
            height: 40
            z: 2
            color: root.primaryColor
            RowLayout {
                anchors {
                    fill: parent
                    margins: 10
                }
                Item {
                    Layout.preferredWidth: alarmSettingsPageRoot.width*0.5
                    Layout.fillHeight: true
                    Label {
                        text: "Alarme"
                        anchors.fill: parent
                        verticalAlignment: "AlignVCenter"
                        horizontalAlignment: "AlignHCenter"
                        font { pointSize: 20; bold: true }
                        fontSizeMode: "Fit"
                        color: root.accentColor
                    }
                }
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Label {
                        text: "Mínimo"
                        anchors.fill: parent
                        verticalAlignment: "AlignVCenter"
                        horizontalAlignment: "AlignHCenter"
                        font { pointSize: 20; bold: true }
                        fontSizeMode: "Fit"
                        color: root.accentColor
                    }
                }
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Label {
                        text: "Máximo"
                        anchors.fill: parent
                        verticalAlignment: "AlignVCenter"
                        horizontalAlignment: "AlignHCenter"
                        font { pointSize: 20; bold: true }
                        fontSizeMode: "Fit"
                        color: root.accentColor
                    }
                }
            }
        }
        delegate: DelegateChooser {
            role: "alarmType"
            DelegateChoice { roleValue: "numerical";
                Item {
                    width: alarmSettingsPageRoot.width
                    height: Math.max(80, alarmCheckbox.implicitHeight)

                    RowLayout {
                        id: alarmRowLayout
                        anchors {
                            fill: parent
                            margins: 5
                        }
                        CheckBox {
                            id: alarmCheckbox
                            Layout.preferredWidth: alarmSettingsPageRoot.width*0.5
                            Layout.alignment: "AlignVCenter"
                            text: name
                            checked: isEnabled
                            contentItem: Label {
                                id: alarmCheckboxLabel
                                anchors {
                                    left: parent.left
                                    leftMargin: 40
                                    right: parent.right
                                    verticalCenter: parent.verticalCenter
                                }
                                text: parent.text
                                font.pointSize: 18
                                fontSizeMode: "Fit"
                                wrapMode: "Wrap"
                            }

                            onToggled: {
                                system.alarm_controller.set_is_enabled(index, alarmCheckbox.checked)
                            }
                        }
                        Item {    
                            Layout.fillWidth: true
                            Layout.fillHeight: true                            
                            TouchSpinBox { 
                                id: minControl
                                anchors.centerIn: parent
                                scale: 0.65
                                value: min
                                onValueChanged: system.alarm_controller.set_min(index, minControl.value)
                            }
                        }
                        Item {    
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            TouchSpinBox { 
                                id: maxControl
                                anchors.centerIn: parent
                                scale: 0.65
                                value: max
                                onValueChanged: system.alarm_controller.set_max(index, maxControl.value)
                            }
                        }
                    }

                    Rectangle {
                        anchors.bottom: parent.bottom
                        height: 1; width: parent.width
                        color: root.backgroundColor
                    }
                }
            }
        }
    }
}