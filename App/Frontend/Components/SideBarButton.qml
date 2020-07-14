import QtQuick 2.12
import QtQuick.Controls 2.12

Button {
    property alias color: backgroundRect.color
    flat: true
        
    background: Rectangle {
        id: backgroundRect
        color: root.accentColor
    }

    contentItem: Label { 
        horizontalAlignment: "AlignHCenter"
        verticalAlignment: "AlignVCenter"
        font { pointSize: 15; bold: true }
        fontSizeMode: "Fit"
        color: Qt.darker(root.backgroundColor)
        text: parent.text
    }
}