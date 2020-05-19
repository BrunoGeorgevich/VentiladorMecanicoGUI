import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ToolBar {
    height: 37
    background: Item {}

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 7
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 13
            color: root.secondaryColor
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 5
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 4
            color: root.secondaryColor
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 8
        }
    }
}