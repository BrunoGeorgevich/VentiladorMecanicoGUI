import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtCharts 2.12

import "qrc:/components"

Page {
    objectName: "DashboardPage"
    id: dashboardPageRoot
    property bool lockScreenStatus: false
    property real sideBarWidth: 150
    property var models: {
                "closedMenu": closedMenuModel,
                "openedMenu": openedMenuModel,
            }

    Component.onCompleted: {
        console.log(Object.keys(system.operation_mode_controller.operation_mode.parameters))
        console.log(Object.values(system.operation_mode_controller.operation_mode.parameters))
        system.dashboard_controller.data_complete.connect(dashboardPageRoot.dataArrived)
    }
    
    Connections {
        target: rootTopBar
        onLockButtonClicked:  {
            if(!dashboardPageRoot.lockScreenStatus) {
                dashboardPageRoot.lockScreenStatus = true
                rightSideToolBar.currentModel = "closedMenu"
                rootTopBar.coloredNotify("Tela bloqueada!", "#0D0")
            } else {
                rootTopBar.coloredNotify("Tela está bloqueada!", "#D00")
            }
        }
    }
    
    signal dataArrived(var data)
    onDataArrived: {
        pawChart.addPoint(data['paw'])
        vtidalChart.addPoint(data['vtidal'])
        flowChart.addPoint(data['flow'])
    }
    
    Rectangle {
        z: 1
        anchors.fill: parent
        visible: dashboardPageRoot.lockScreenStatus
        color: "#00000000"
        MouseArea {
            anchors.fill: parent
            onClicked: {
                rootTopBar.coloredNotify("Tela está bloqueada!", "#D00")
            }
            onPressAndHold: {
                dashboardPageRoot.lockScreenStatus = false
                rootTopBar.coloredNotify("Tela desbloqueada!", "#0D0")
                rootTopBar.unlock()
            }
        }
    }

    ListModel {
        id: closedMenuModel
        ListElement { type: "button"; label: "Menu"; actionName: "openMenu"; }
        ListElement { 
            type: "item"; 
            label: "RR"; 
            name: "rr";
            min: '4'; 
            max: '60'; 
            twoUnits: false;
            unit: 'b/min' 
        }
        ListElement { 
            type: "item"; 
            label: "I:E"; 
            preffix: "1 : ";
            name: "ie";
            min: '1'; 
            max: '4'; 
            twoUnits: false;
            unit: 'ratio' 
        }
        ListElement { 
            type: "item"; 
            label: "P<sub>insp</sub>"; 
            name: "pp";
            min: '2'; 
            max: '40'; 
            twoUnits: false;
            unit: '[cmH<sub>2</sub>O]' 
        }
        ListElement {
            type: "item"; 
            label: "PEEP"; 
            name: "peep";
            min: '-30'; 
            max: '30'; 
            twoUnits: false;
            unit: '[cmH<sub>2</sub>O]'
        }
        ListElement { 
            type: "item"; 
            label: "Sensi."; 
            name: "sensibilityValue";
            min: '2'; 
            max: '100'; 
            twoUnits: true;
            unitSelector: 'sensibilityType'; 
            unitConditional: 'pressure'; 
            unit: '[cmH<sub>2</sub>O]' ;
            secondaryUnit: 'L/min' 
        }
        // ListElement { type: "status"; action: "Stopped"; mode: 'PCV' }
    }

    ListModel {
        id: openedMenuModel
        ListElement { type: "button"; label: "Voltar"; actionName: "closeMenu"; }
        ListElement { type: "button"; label: "Mudar\nPaciente"; actionName: "openPersonSettingsPage" }
        ListElement { type: "button"; label: "Mudar\nModo de\nOperação"; actionName: "openOperationModePage" }
    }
   
    ListModel {
        id: indicatorsModel
        ListElement { type: "indicator"; 
                      name: "MAX P<sub>insp</sub>"; 
                      unit: "cmH<sub>2</sub>O"; 
                      value: 101; 
                      min: 5; 
                      max: 70 
                    }
        ListElement { type: "indicator"; 
                      name: "V<sub>e</sub>"; 
                      unit: "slpm"; 
                      value: 30.3; 
                      min: 2; 
                      max: 40 
                    }
        ListElement { type: "indicator"; 
                      name: "FIO<sub>2</sub>"; 
                      unit: "%"; 
                      value: 91; 
                      min: 21; 
                      max: 100 
                    }
        ListElement { type: "toggle"; label: "Pausa \n Expiratória"; actionName: "toggleExpirationPause"; }
        ListElement { type: "toggle"; label: "Pausa \n Inspiratória"; actionName: "toggleInspirationPause"; }
        ListElement { type: "toggle"; label: "Ventilação"; actionName: "toggleAssistedVentilation"; }
    }
    
    Rectangle {
        anchors.fill: parent
        color: root.foregroundColor
    }
    
    RowLayout {
        anchors.fill: parent
        spacing: 1
        ToolBar {
            id: rightSideToolBar

            Layout.fillHeight: true
            Layout.preferredWidth: dashboardPageRoot.sideBarWidth
            
            property string currentModel: "closedMenu"
            property var actions: { 
                "openMenu": () => { rightSideToolBar.currentModel = "openedMenu" },
                "closeMenu": () => { rightSideToolBar.currentModel = "closedMenu" },
                "openPersonSettingsPage": () => { 
                    pageStack.replace("qrc:/pages/PersonSettingsPage.qml") 
                },
                "openOperationModePage": () => { 
                    pageStack.replace("qrc:/pages/ModeSettingsPage.qml")
                },
            }
            
            ColumnLayout {
                anchors.fill: parent            
                spacing: 1
                Repeater {
                    id: rightSideToolBarRepeater
                    model: dashboardPageRoot.models[rightSideToolBar.currentModel]
                    delegate: MenuItem {
                        settings: rightSideToolBarRepeater.model.get(index)
                        clickAction: rightSideToolBar.actions[actionName]
                    }
                }
            }
        }
        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true

            color: root.backgroundColor

            ColumnLayout {
                anchors {
                    fill: parent
                    rightMargin: 3
                }
                LineChart {
                    id: pawChart
                    title: "PAW<br>[cmH<sub>2</sub>O]"
                }
                LineChart {
                    id: vtidalChart
                    title: "V<sub>tidal</sub><br>[ml]"
                }
                LineChart {
                    id: flowChart
                    title: "Flow<br>[slpm]"
                }
            }
        }
        ToolBar {
            id: leftSideToolBar
            Layout.fillHeight: true
            Layout.preferredWidth: dashboardPageRoot.sideBarWidth

            property var actions: { 
                "toggleExpirationPause": (currentState) => {
                    console.log(currentState)
                    // SEND SERIAL COMMAND TO PAUSE
                },
                "toggleInspirationPause": (currentState) => {
                    console.log(currentState)
                    // SEND SERIAL COMMAND TO PAUSE
                },
                "toggleAssistedVentilation": (currentState) => {
                    console.log(currentState)
                    // SEND SERIAL COMMAND TO PAUSE
                }
            }
            
            ColumnLayout {
                anchors.fill: parent            
                spacing: 1
                Repeater {
                    id: leftSideToolBarRepeater
                    model: indicatorsModel
                    delegate: MenuItem {
                        settings: leftSideToolBarRepeater.model.get(index)
                        clickAction: leftSideToolBar.actions[actionName]
                    }
                }
            }
        }
    }
}