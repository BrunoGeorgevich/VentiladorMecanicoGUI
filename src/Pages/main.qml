import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "qrc:/components"
import "qrc:/pages"

ApplicationWindow {
    id: root
    visible: true
    width: 800; height: 480

    property string accentColor : "#19212B"

    StackView {
        id:pageStack
        anchors.fill: parent
        initialItem: PersonSettingsPage {}
    }
}