import QtQuick 2.12
import QtQuick.Controls 2.12

Button {
    property alias textColor: buttonContentLabel.color
    property alias color: backgroundRect.color
    property alias radius: backgroundRect.radius
    property alias fontSize: buttonContentLabel.font.pointSize
    flat: true
        
    background: Rectangle {
        id: backgroundRect
        color: root.accentColor
    }

    contentItem: Label { 
        id: buttonContentLabel
        horizontalAlignment: "AlignHCenter"
        verticalAlignment: "AlignVCenter"
        font { pointSize: 15; bold: true }
        fontSizeMode: "Fit"
        color: Qt.darker(root.backgroundColor)
        text: parent.text
    }
}