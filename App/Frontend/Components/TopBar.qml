import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ToolBar {

    signal leftButtonClicked()
    signal rightButtonClicked()

    property alias text: topBarLabel.text
    property bool leftButtonVisible: true
    property bool rightButtonVisible: true

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

                Button {
                    Layout.fillHeight: true
                    Layout.preferredWidth: 98
                    enabled: leftButtonVisible
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