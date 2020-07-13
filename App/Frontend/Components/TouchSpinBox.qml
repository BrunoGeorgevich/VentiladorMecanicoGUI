import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

RowLayout {
    id:touchSpinBoxRoot

    property real fontSize: 30
    property string preffix: ''
    property real scale: 1 
    property real value: 160
    property real min: 0
    property real max: 300


    width: 270 * scale; height: 70 * scale

    RoundButton {
        Layout.preferredHeight: parent.height
        Layout.preferredWidth: parent.height
        autoRepeat: true
        
        background: Rectangle {
            radius: parent.height/2
            color: parent.pressed ? Qt.lighter(root.backgroundColor, 2) : root.backgroundColor
        }

        contentItem: Label { 
            horizontalAlignment: "AlignHCenter"
            verticalAlignment: "AlignVCenter"
            font { pointSize: fontSize; bold: true }
            fontSizeMode: "Fit"
            color: parent.pressed ? Qt.lighter(root.accentColor, 2) : root.accentColor
            text: "-"
        }
        onPressed: {
            value = (value - 1 < min ? min : value - 1)
        }
    }
    Label {
        Layout.fillHeight: true
        Layout.fillWidth: true

        horizontalAlignment: "AlignHCenter"
        verticalAlignment: "AlignVCenter"
        
        text: `${preffix}${touchSpinBoxRoot.value}`
        color: Qt.darker(root.secondaryColor)
        font.pointSize: fontSize * 0.75
        fontSizeMode: "Fit"
    }
    RoundButton {
        Layout.preferredHeight: parent.height
        Layout.preferredWidth: parent.height
        autoRepeat: true
        
        background: Rectangle {
            radius: parent.height/2
            color: parent.pressed ? Qt.lighter(root.backgroundColor, 2) : root.backgroundColor
        }

        contentItem: Label { 
            horizontalAlignment: "AlignHCenter"
            verticalAlignment: "AlignVCenter"
            font { pointSize: fontSize; bold: true }
            fontSizeMode: "Fit"
            color: parent.pressed ? Qt.lighter(root.accentColor, 2) : root.accentColor
            text: "+"
        }
        onPressed: {
            value = (value + 1 > max ? max : value + 1)
        }
    }  
}