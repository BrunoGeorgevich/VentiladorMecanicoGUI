import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ToolBar {

    property alias text: topBarLabel.text

    height: 45
    background: Rectangle {
        color: root.accentColor
    }
    Label {
        id: topBarLabel
        anchors.fill: parent
        horizontalAlignment: "AlignHCenter"
        verticalAlignment: "AlignVCenter"
        color: "white"
        font { pointSize: 20 }
    }
}