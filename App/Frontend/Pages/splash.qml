import QtQuick 2.7
import QtQuick.Controls 2.5

ApplicationWindow {
    width: 400
    height: 400
    visible: splash_controller.splash_is_opened
    flags: Qt.FramelessWindowHint

    Image {
        anchors.fill: parent
        source: "qrc:/images/splash_image"
    }

    BusyIndicator {
        anchors {
            bottom: parent.bottom
            right: parent.right
            margins: 20
        }
        running: splash_controller.splash_is_opened
    }
}