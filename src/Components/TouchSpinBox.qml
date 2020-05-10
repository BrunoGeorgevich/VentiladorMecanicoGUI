import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

RowLayout {
    id:touchSpinBoxRoot

    property real fontSize: 20
    property string preffix: ''
    property real scale: 1 
    property real value: 160
    property real min: 0
    property real max: 300


    width: 270 * scale; height: 70 * scale

    RoundButton {
        Layout.preferredHeight: parent.height
        Layout.preferredWidth: parent.height
        
        contentItem: Label { 
            horizontalAlignment: "AlignHCenter"
            verticalAlignment: "AlignVCenter"
            font.pointSize: 20
            text: "-"
        }
        onClicked: value = (value - 1 < min ? min : value - 1)
        onPressAndHold: {
            buttonPressedTimer.start()
            buttonPressedTimer.increment = -5
        }
        onReleased: buttonPressedTimer.stop()
    }
    Label {
        Layout.fillHeight: true
        Layout.fillWidth: true

        horizontalAlignment: "AlignHCenter"
        verticalAlignment: "AlignVCenter"
        
        text: `${preffix}${touchSpinBoxRoot.value}`
        font.pointSize: 20
    }
    RoundButton {
        Layout.preferredHeight: parent.height
        Layout.preferredWidth: parent.height

        contentItem: Label { 
            horizontalAlignment: "AlignHCenter"
            verticalAlignment: "AlignVCenter"
            font.pointSize: 20
            text: "+"
        }
        onClicked: value = (value + 1 > max ? max : value + 1)
        onPressAndHold: {
            buttonPressedTimer.start()
            buttonPressedTimer.increment = 5
        }
        onReleased: buttonPressedTimer.stop()
    }   

    Timer {
        id: buttonPressedTimer
        property int increment: 0
        
        repeat: true
        running: false

        interval: 200
        onTriggered: {
            value += increment
            if (value <= min) value = min
            if (value >= max) value = max
        }
    }
}