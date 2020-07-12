import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    id: choooserRoot
    property alias spacing: rowLayoutChooser.spacing
    property var options: ListModel {}
    property real buttonRadius: 75
    property real numOfItens: -1
    property real fontSize: 30
    property var value: -1
    property bool rounded: true

    width: numOfItens*(buttonRadius + spacing) - spacing; height: buttonRadius

    RowLayout {
        id: rowLayoutChooser
        anchors.fill: parent
        spacing: 15

        Repeater {
            model: options
            delegate: RoundButton {
                Layout.preferredHeight: buttonRadius
                Layout.preferredWidth: buttonRadius

                checked: value == elementValue
                enabled: elementIsEnable
        
                background: Rectangle {
                    radius: rounded ? parent.height/2 : 0
                    color: parent.checked ? root.accentColor : root.backgroundColor
                }

                contentItem: Label {
                    anchors.fill: parent
                    horizontalAlignment: "AlignHCenter"
                    verticalAlignment: "AlignVCenter"
                    font { pointSize: fontSize; bold: true }
                    fontSizeMode: "Fit"
                    color: parent.checked ? root.backgroundColor : root.accentColor
                    text: elementText
                }

                onClicked: value = elementValue
            }
        }
    }
}