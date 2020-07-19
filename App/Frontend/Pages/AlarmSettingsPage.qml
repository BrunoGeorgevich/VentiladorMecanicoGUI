import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Qt.labs.qmlmodels 1.0

import "qrc:/components"

Page {
    objectName: "AlarmPage"
    id: alarmSettingsPageRoot

    ListModel {
        id: alarmsListModel
        ListElement {
            type: "numerical"
            min: 0
            max: 100
            name: "Pressão"
            message: "Pressão máxima excedida!"
            key: "maxPressureExceed"
        }
        ListElement {
            type: "numerical"
            min: 0
            max: 100
            name: "Pressão máxima excedida asd asd asd asd asd asd asdasd asdas dasd"
            message: "Pressão máxima excedida!"
            key: "maxPressureExceed"
        }
        ListElement {
            type: "numerical"
            min: 0
            max: 100
            name: "Lorem ipsum bla bla bla uhsaiudh hasuidhiuahds"
            message: "Pressão máxima excedida!"
            key: "maxPressureExceed"
        }
        ListElement {
            type: "numerical"
            min: 0
            max: 100
            name: "asdas a isdjas jdioj asdjasoi djoijasodj oiasdoajsoid"
            message: "Pressão máxima excedida!"
            key: "maxPressureExceed"
        }
    }

    ListView {
        anchors.fill: parent
        model: alarmsListModel
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
            role: "type"
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
                        }
                        Item {    
                            Layout.fillWidth: true
                            Layout.fillHeight: true                            
                            TouchSpinBox { 
                                anchors.centerIn: parent
                                scale: 0.65
                                value: min
                            }
                        }
                        Item {    
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            TouchSpinBox { 
                                anchors.centerIn: parent
                                scale: 0.65
                                value: max
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