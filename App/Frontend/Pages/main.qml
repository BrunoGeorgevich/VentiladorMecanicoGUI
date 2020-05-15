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
    property string foregroundColor : "#FFFFFF"
    
    header: TopBar{
        id:rootTopBar
    }

    StackView {
        id:pageStack
        anchors.fill: parent
        initialItem: PersonSettingsPage {}
        onCurrentItemChanged: {

            if (currentItem.objectName === "DashboardPage") {
                console.log("CHART UPDATE TIMER RESTARTED!")
                chartUpdateTimer.restart()
            } else {
                console.log("CHART UPDATE TIMER STOPPED!")
                chartUpdateTimer.stop()
            }

            switch (currentItem.objectName) {
                case "PersonPage":
                    rootTopBar.visible = true
                    rootTopBar.text = "Configurações do Paciente"        
                    break;
                case "ModePage":
                    rootTopBar.visible = true
                    rootTopBar.text = "Configurações do Modo de Operação"        
                    break;
                default:
                    rootTopBar.visible = false
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