import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12

import "qrc:/components"
import "qrc:/pages"

ApplicationWindow {
    id: root
    visible: true
    //visibility: "FullScreen"
    width: 800; height: 480
    
    property string accentColor : "#ecdeb2"
    property string primaryColor : "#17202a"
    property string secondaryColor: "#a30f0f"
    property string backgroundColor : "#40464c"
    property string foregroundColor : "#FFFFFF"

    Component.onCompleted: {
        if (system.hardware_controller.hardware_is_connected) {
            rootTopBar.good("Arduino conectado com sucesso!")
        } else {
            rootTopBar.bad("Não foi possível conectar-se com o Arduino!")
        }
    }
    
    header: TopBar{
        id:rootTopBar

        function coloredNotify(msg, color) {
            notificationSystem.coloredNotify(msg, color);
        }

        function good(msg) {
            rootTopBar.coloredNotify(msg, Material.color(Material.Green));
        }

        function bad(msg) {
            rootTopBar.coloredNotify(msg, Material.color(Material.Red));
        }

        function info(msg) {
            rootTopBar.coloredNotify(msg, Material.color(Material.Blue));
        }

        function warning(msg) {
            rootTopBar.coloredNotify(msg, Material.color(Material.Yellow));
        }

        NotificationSystem {
            id:notificationSystem
            isOnTheTop: true
            centralized: true
            defaultH: 60
            defaultW: 500
        }
        
        onRightButtonClicked: {
            switch (pageStack.currentItem.objectName) {
                case "PersonPage":
                    pageStack.replace("qrc:/pages/ModeSettingsPage.qml")
                    break
                case "ModePage":
                    pageStack.replace("qrc:/pages/DashboardPage.qml")
                    system.hardware_controller.write_data("SEND_DATA", "")
                    break
            }
        }
        
        onLeftButtonClicked: {
            switch (pageStack.currentItem.objectName) {
                case "ModePage":
                    pageStack.replace("qrc:/pages/PersonSettingsPage.qml")
                    break
                case "AlarmPage":
                    pageStack.replace("qrc:/pages/DashboardPage.qml")
                    system.hardware_controller.write_data("SEND_DATA", "")
                    break
            }
        }
    }

    footer: BottomBar {}

    StackView {
        id:pageStack

        anchors.fill: parent
        smooth: false
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
                    rootTopBar.batteryIndicatorVisible = false
                    rootTopBar.lockButtonIsVisible = false
                    rootTopBar.text = "Recepção do paciente"        
                    break;
                case "ModePage":
                    rootTopBar.visible = true
                    rootTopBar.leftButtonVisible = true
                    rootTopBar.rightButtonVisible = true
                    rootTopBar.batteryIndicatorVisible = false
                    rootTopBar.lockButtonIsVisible = false
                    rootTopBar.text = "Modo de operação"        
                    break;
                case "AlarmPage":
                    rootTopBar.visible = true
                    rootTopBar.leftButtonVisible = true
                    rootTopBar.rightButtonVisible = false
                    rootTopBar.batteryIndicatorVisible = false
                    rootTopBar.lockButtonIsVisible = false
                    rootTopBar.text = "Configuração de Alarmes"        
                    break;
                case "DashboardPage":
                    rootTopBar.visible = true
                    rootTopBar.leftButtonVisible = false
                    rootTopBar.rightButtonVisible = false
                    rootTopBar.batteryIndicatorVisible = true
                    rootTopBar.lockButtonIsVisible = true
                    rootTopBar.text = system.person_controller.details()
                    break;
            }   
        }	

        replaceEnter : Transition {	
            id: replaceEnterAnimation 	
            PropertyAction { property: "x"; value: replaceEnterAnimation.ViewTransition.item.pos }	
            PropertyAction { property: "y"; value: replaceEnterAnimation.ViewTransition.item.pos }	
        }
    }
    
    Timer {
        id: chartUpdateTimer
        interval: 166
        repeat: true
    }
}
