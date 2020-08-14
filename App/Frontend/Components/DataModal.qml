import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.5
import QtQuick.Layouts 1.12

Dialog {
    id:dataModalDialogRoot
    property alias topTitle: topBar.text
    property alias body: bodyLabel.text

    function openModal() {
        dataModalDialogRoot.open()
        dataModalCloseTimer.restart()
    }

    function closeModal() {
        dataModalDialogRoot.close()
        dataModalCloseTimer.stop()
    }

    background: Rectangle { color: root.foregroundColor }

    width: 300; height: 150

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2

    modal: true
    Overlay.modal: Rectangle { color: "#88000000" }

    header: SecondToolbar{
        id: topBar
        color: root.primaryColor
    }

    Label {
        id: bodyLabel

        anchors.fill: parent
        verticalAlignment: "AlignVCenter"
        horizontalAlignment: "AlignHCenter"
        font.pointSize: 28
        wrapMode: Text.Wrap
    }

    Timer {
        id: dataModalCloseTimer
        interval: 1500
        repeat: false
        onTriggered: {
            dataModalDialogRoot.close()
        }
    }    
}