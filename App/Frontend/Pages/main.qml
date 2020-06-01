import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "qrc:/components"
import "qrc:/pages"

ApplicationWindow {
    id: root
    visible: true
    width: 800; height: 480

    property string accentColor : "#ecdeb2"
    property string primaryColor : "#17202a"
    property string secondaryColor: "#a30f0f"
    property string backgroundColor : "#40464c"
    property string foregroundColor : "#FFFFFF"
    
    header: TopBar{
        id:rootTopBar
    }

    footer: BottomBar {}

    StackView {
        id:pageStack

        anchors.fill: parent
        initialItem: PersonSettingsPage {}
        onCurrentItemChanged: {
            if (currentItem.objectName === "DashboardPage") {
                if (!chartUpdateTimer.running) {
                    console.log("CHART UPDATE TIMER RESTARTED!")
                    chartUpdateTimer.restart()
                }
            } else {
                if (chartUpdateTimer.running) {
                    console.log("CHART UPDATE TIMER STOPPED!")
                    chartUpdateTimer.stop()
                }
            }

            switch (currentItem.objectName) {
                case "PersonPage":
                    rootTopBar.visible = true
                    rootTopBar.leftButtonVisible = false
                    rootTopBar.rightButtonVisible = true
                    rootTopBar.text = "Recepção do paciente"        
                    break;
                case "ModePage":
                    rootTopBar.visible = true
                    rootTopBar.leftButtonVisible = true
                    rootTopBar.rightButtonVisible = true
                    rootTopBar.text = "Modo de operação"        
                    break;
                case "DashboardPage":
                    rootTopBar.visible = true
                    rootTopBar.leftButtonVisible = false
                    rootTopBar.rightButtonVisible = false
                    rootTopBar.text = system.person_controller.details()
                    break;
            }
            
        }
    }
    
    Timer {
        id: chartUpdateTimer
        interval: 166
        repeat: true
    }
}