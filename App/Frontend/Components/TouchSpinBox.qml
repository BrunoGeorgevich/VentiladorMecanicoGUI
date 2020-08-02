import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "qrc:/functions/utils.js" as Utils

RowLayout {
    id:touchSpinBoxRoot

    property real fontSize: 30
    property string preffix: ''
    property real scale: 1 
    property real value: 160
    property real step: 1 
    property real interval: 50


    width: 270 * scale; height: 70 * scale

    RoundButton {
        Layout.preferredHeight: parent.height
        Layout.preferredWidth: parent.height
        autoRepeat: true
        autoRepeatInterval: interval
        
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
            value = (value - step)  <= 0 ? 0 : (value - step)
        }
    }
    Label {
        Layout.fillHeight: true
        Layout.fillWidth: true

        horizontalAlignment: "AlignHCenter"
        verticalAlignment: "AlignVCenter"
        
        text: `${preffix}${Utils.parseNumber(touchSpinBoxRoot.value)}`
        color: Qt.darker(root.secondaryColor)
        font.pointSize: fontSize * 0.75
        fontSizeMode: "Fit"
    }
    RoundButton {
        Layout.preferredHeight: parent.height
        Layout.preferredWidth: parent.height
        autoRepeat: true
        autoRepeatInterval: interval
        
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
            value = value + step
        }
    }  
}