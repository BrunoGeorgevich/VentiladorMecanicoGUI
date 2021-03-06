import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12

import "qrc:/functions/utils.js" as Utils

ToolBar {
    id: toolBarRoot
    signal leftButtonClicked()
    signal rightButtonClicked()
    signal alertButtonClicked()
    signal lockButtonClicked()

    property alias text: topBarLabel.text
    property alias isLocked: lockButton.isLocked
    property bool leftButtonVisible: true
    property bool rightButtonVisible: true
    property bool batteryIndicatorVisible: false
    property bool lockButtonIsVisible: false
    property bool closeButtonIsVisible: false

    function unlock() {
        lockButton.isLocked = "false"
    }

    height: 75
    
    background: Rectangle {
        color: root.primaryColor
    }

    ColumnLayout {
        anchors.fill: parent
        spacing:0
        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true

            RowLayout {
                anchors.fill: parent

                Item {
                    Layout.fillHeight: true
                    Layout.preferredWidth: lockButtonIsVisible ? 60 : 0

                    Button {
                        id: lockButton
                        property string isLocked: "false"
                        property var buttonIcon: { "true": "qrc:/images/locked", "false": "qrc:/images/unlocked" }

                        visible: lockButtonIsVisible
                        height: parent.height
                        width: 50

                        flat: true
                        icon {
                            source: buttonIcon[isLocked]
                            color: root.foregroundColor
                            height: parent.height*0.8
                        }

                        onClicked: { 
                            isLocked = "true"
                            lockButtonClicked()
                        }
                    }
                }

                Button {
                    Layout.fillHeight: true
                    Layout.preferredWidth: leftButtonVisible ? 98 : 0
                    visible: !lockButtonIsVisible
                    flat: true
                    icon {
                        source: leftButtonVisible ? "qrc:/images/arrow_left" : ""
                        color: root.foregroundColor
                        height: parent.height
                        width: parent.width
                    }
                    onClicked: { 
                        if (leftButtonVisible) {
                            leftButtonClicked() 
                        }
                    }
                }

                Button {
                    Layout.fillHeight: true
                    Layout.preferredWidth: 60
                    visible: closeButtonIsVisible
                    flat: true
                    icon {
                        source: "qrc:/images/close"
                        color: root.foregroundColor
                        height: parent.height
                        width: parent.width
                    }
                    onClicked: { 
                        if (closeButtonIsVisible) {
                            system.hardware_controller.quit()
                            Qt.quit()
                        }
                    }
                }

                Label {
                    id: topBarLabel
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    horizontalAlignment: "AlignHCenter"
                    verticalAlignment: "AlignVCenter"
                    color: root.accentColor
                    font { pointSize: 24; bold: true }
                    fontSizeMode: "Fit"
                }

                Label {
                    id: topBarVolumeDetails
                    visible: lockButtonIsVisible

                    function details() {
                        let pw = Utils.predictWeight()
                        let firstHeader = "Volume Corrente Ideal"
                        let secondHeader = "4ml/kg\t6ml/kg\t8ml/kg"
                        let thirdHeader = `${Utils.parseNumber(pw*4)} ml\t${Utils.parseNumber(pw*6)} ml\t${Utils.parseNumber(pw*8)} ml`
                        return `${firstHeader}\n${secondHeader}\n${thirdHeader}`
                    }

                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    horizontalAlignment: "AlignHCenter"
                    verticalAlignment: "AlignVCenter"
                    color: root.accentColor
                    font { pointSize: 12; bold: true }
                    fontSizeMode: "Fit"
                    text: details()
                }

                Button {
                    Layout.fillHeight: true
                    Layout.preferredWidth: 98
                    enabled: rightButtonVisible
                    flat: true
                    icon {
                        source: rightButtonVisible ? "qrc:/images/arrow_right" : ""
                        color: root.foregroundColor
                        height: parent.height
                        width: parent.width
                    }
                    onClicked: { 
                        if (rightButtonVisible) {
                            rightButtonClicked() 
                        }
                    }
                }

                Item {
                    Layout.fillHeight: true
                    Layout.preferredWidth: 100                   

                    visible: batteryIndicatorVisible

                    RowLayout {
                        anchors {
                            fill: parent
                            rightMargin: 10
                        }

                        Label {
                            id: batteryLabel

                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            text: "100%"

                            horizontalAlignment: "AlignRight"
                            verticalAlignment: "AlignVCenter"
                            color: root.accentColor
                            font { pointSize: 12; bold: true }
                        }

                        Image {
                            id: batteryIcon

                            Layout.fillHeight: true
                            Layout.preferredWidth: 40

                            fillMode: Image.PreserveAspectFit

                            source: "qrc:/images/battery"
                        }

                        Button {
                            id: alertButton
                            Layout.fillHeight: true
                            Layout.preferredWidth: 40

                            visible: lockButtonIsVisible
                            height: parent.height

                            flat: true
                            icon {
                                source: "qrc:/images/alert"
                                color: root.foregroundColor
                                height: parent.height
                            }

                            onClicked: { 
                                alertButtonClicked()
                            }
                        }
                    }
                }

            }
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 3
        }
        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 6
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 3
        }
        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 3
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 3
        }
        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
        }
    }
}