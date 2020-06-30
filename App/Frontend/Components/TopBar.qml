import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12

ToolBar {
    id: toolBarRoot
    signal leftButtonClicked()
    signal rightButtonClicked()

    property alias text: topBarLabel.text
    property bool leftButtonVisible: true
    property bool rightButtonVisible: true
    property bool batteryIndicatorVisible: false
    property bool startVentilationButtonVisible: false

    height: 82
    
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
                    Layout.preferredWidth: 150

                    Button {
                        id: startVentilationButton
                        property string operating: "false"
                        property var buttonText: { "true": "INICIAR", "false": "PARAR" }
                        property var buttonColor: { "true": Material.color(Material.Green), "false": Material.color(Material.Red) }

                        anchors {
                            fill: parent
                            margins: 5
                        }

                        visible: startVentilationButtonVisible
                        text: buttonText[operating]
            
                        background: Rectangle {
                            color: startVentilationButton.buttonColor[startVentilationButton.operating]
                        }

                        contentItem: Label {
                            anchors.fill: parent
                            horizontalAlignment: "AlignHCenter"
                            verticalAlignment: "AlignVCenter"
                            font { pointSize: 20; bold: true }
                            color: "#FFFFFF"
                            text: parent.text
                        }

                        onClicked: { 
                            operating = operating === "true" ? "false" : "true"
                            // START AND STOP VENTILATION
                        }
                    }
                }

                Button {
                    Layout.fillHeight: true
                    Layout.preferredWidth: 98
                    visible: startVentilationButtonVisible
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

                Label {
                    id: topBarLabel
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    horizontalAlignment: "AlignHCenter"
                    verticalAlignment: "AlignVCenter"
                    color: root.accentColor
                    font { pointSize: 24; bold: true }
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
                    Layout.preferredWidth: 150                   

                    visible: batteryIndicatorVisible

                    RowLayout {
                        anchors.fill: parent

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