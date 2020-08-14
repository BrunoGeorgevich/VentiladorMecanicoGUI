import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.4

ToolBar {
    property alias color: toolbarBackground.color
    property alias text: secondToolbarLabel.text
    width: parent.width; height: 45

    background: Rectangle { id: toolbarBackground; height: parent.height; color: parent.color }

    Label {
        id: secondToolbarLabel
        anchors.centerIn: parent
        color: root.accentColor
        font{ bold: true; pixelSize: 20 }
    }
}