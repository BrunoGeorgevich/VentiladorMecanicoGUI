import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    id: choooserRoot
    property alias spacing: rowLayoutChooser.spacing
    property var options: ListModel {}
    property real buttonRadius: 70
    property real numOfItens: -1
    property real fontSize: 25
    property var value: -1

    width: numOfItens*(buttonRadius + spacing) - spacing; height: buttonRadius

    RowLayout {
        id: rowLayoutChooser
        anchors.fill: parent
        spacing: 10

        Repeater {
            model: options
            delegate: RoundButton {
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: parent.height

                checked: value == elementValue
                enabled: elementIsEnable

                contentItem: Label {
                    anchors.fill: parent
                    horizontalAlignment: "AlignHCenter"
                    verticalAlignment: "AlignVCenter"
                    font.pointSize: fontSize
                    color: parent.checked ? "white" : root.accentColor
                    text: elementText
                }

                onClicked: value = elementValue
            }
        }
    }
}