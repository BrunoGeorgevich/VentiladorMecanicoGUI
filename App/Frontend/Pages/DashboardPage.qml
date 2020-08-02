import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtCharts 2.12

import "qrc:/components"

Page {
    objectName: "DashboardPage"
    id: dashboardPageRoot
    property string currentMode: system.operation_mode_controller.operation_mode.mode
    property bool lockScreenStatus: false
    property real sideBarWidth: 150
    property var models: {
                "closedMenuPCV": closedMenuPCVModel,
                "closedMenuVCV": closedMenuVCVModel,
                "openedMenu": openedMenuModel,
    }
    property var indicatorsModels: {
                "PCV": indicatorsPCVModel,
                "VCV": indicatorsVCVModel,
    }
    property var indicatorsValues: { 'fio2': '-', 've': '-', 'tInsp': '-' }

    Component.onCompleted: {
        // console.log(Object.keys(system.operation_mode_controller.operation_mode.parameters))
        // console.log(Object.values(system.operation_mode_controller.operation_mode.parameters))
        system.dashboard_controller.data_complete.connect(dashboardPageRoot.dataArrived)
    }
    
    Connections {
        target: rootTopBar
        onLockButtonClicked: {
            if(!dashboardPageRoot.lockScreenStatus) {
                dashboardPageRoot.lockScreenStatus = true
                leftSideToolBar.currentModel = "closedMenu" + dashboardPageRoot.currentMode
                rootTopBar.good("Tela bloqueada!")
            } else {
                rootTopBar.bad("Tela está bloqueada!")
            }
        }
        onAlertButtonClicked: {
            alertSideBar.open()
        }
    }
    
    signal dataArrived(var data)
    onDataArrived: {
        console.log(Object.keys(data))
        console.log(Object.values(data))
        if (Object.keys(data).indexOf('paw') !== -1){
            pawChart.addPoint(data['paw'])
        }
        if (Object.keys(data).indexOf('vtidal') !== -1){
            vtidalChart.addPoint(data['vtidal'])
        }
        if (Object.keys(data).indexOf('flow') !== -1){
            flowChart.addPoint(data['flow'])
        }
        dashboardPageRoot.indicatorsValues = data
    }

    ListModel {
        id: closedMenuPCVModel
        ListElement { type: "button"; label: "Menu"; actionName: "openMenu"; }
        ListElement { 
            type: "item"; 
            label: "RR"; 
            name: "rr";
            min: '4'; 
            max: '60'; 
            step: '1'; 
            interval: 50;
            twoUnits: false;
            unit: 'b/min';
            actionName: "openUpdateSidePanel";
        }
        ListElement { 
            type: "item"; 
            label: "I:E"; 
            preffix: "1 : ";
            name: "ie";
            min: '1'; 
            max: '4'; 
            step: '0.1'; 
            interval: 50;
            twoUnits: false;
            unit: 'ratio';
            actionName: "openUpdateSidePanel";
        }
        ListElement { 
            type: "item"; 
            label: "P. INSP."; 
            name: "pip";
            min: '2'; 
            max: '40'; 
            step: '1'; 
            interval: 50;
            twoUnits: false;
            unit: '[cmH<sub>2</sub>O]';
            actionName: "openUpdateSidePanel";
        }
        ListElement {
            type: "item"; 
            label: "PEEP"; 
            name: "peep";
            min: '-30'; 
            max: '30'; 
            step: '1'; 
            interval: 50;
            twoUnits: false;
            unit: '[cmH<sub>2</sub>O]';
            actionName: "openUpdateSidePanel";
        }
        ListElement { 
            type: "item"; 
            label: "Sensi."; 
            name: "sensiV";
            min: '2'; 
            max: '100'; 
            step: '1'; 
            interval: 50;
            twoUnits: false;
            unit: '[cmH<sub>2</sub>O]' ;
            secondaryUnit: 'L/min';
            actionName: "openUpdateSidePanel";
        }
    }
    ListModel {
        id: closedMenuVCVModel
        ListElement { type: "button"; label: "Menu"; actionName: "openMenu"; }
        ListElement { 
            type: "item"; 
            label: "RR"; 
            name: "rr";
            min: '4'; 
            max: '60';
            step: '1'; 
            interval: 50;
            twoUnits: false;
            unit: 'b/min';
            actionName: "openUpdateSidePanel";
        }
        ListElement { 
            type: "item"; 
            label: "Volume"; 
            name: "volume";
            min: '2'; 
            max: '60'; 
            step: '1'; 
            interval: 10;
            twoUnits: false;
            unit: 'ml';
            actionName: "openUpdateSidePanel";
        }
        ListElement { 
            type: "item"; 
            label: "Fluxo"; 
            name: "flow";
            min: '2'; 
            max: '40'; 
            step: '1';
            interval: 50;
            twoUnits: false;
            unit: 'l/m²';
            actionName: "openUpdateSidePanel";
        }
        ListElement {
            type: "item"; 
            label: "PEEP"; 
            name: "peep";
            min: '-30'; 
            max: '30'; 
            step: '1'; 
            interval: 50;
            twoUnits: false;
            unit: '[cmH<sub>2</sub>O]';
            actionName: "openUpdateSidePanel";
        }
        ListElement { 
            type: "item"; 
            label: "Sensi."; 
            name: "sensiV";
            min: '2'; 
            max: '100'; 
            step: '1'; 
            interval: 50; 
            twoUnits: false;
            unit: '[cmH<sub>2</sub>O]' ;
            secondaryUnit: 'L/min';
            actionName: "openUpdateSidePanel";
        }
    }

    ListModel {
        id: openedMenuModel
        ListElement { type: "button"; label: "Voltar"; actionName: "closeMenu"; }
        ListElement { type: "button"; label: "Mudar\nPaciente"; actionName: "openPersonSettingsPage" }
        ListElement { type: "button"; label: "Mudar\nModo de\nOperação"; actionName: "openOperationModePage" }
        ListElement { type: "button"; label: "Configuração\nde Alarmes"; actionName: "openAlarmsSettingsPage" }
    }
   
    ListModel {
        id: indicatorsPCVModel
        ListElement { type: "indicator"; 
                      name: "P<sub>PICO</sub>"; 
                      unit: 'cmH<sub>2</sub>O' ;
                      key: "pe";
                      min: 2; 
                      max: 40 
                    }
        ListElement { type: "indicator"; 
                      name: "Vt"; 
                      unit: "ml"; 
                      key: "ve";
                      min: 2; 
                      max: 40 
                    }
        ListElement { type: "indicator"; 
                      name: "Vol<sub>MIN</sub>"; 
                      unit: "l/min"; 
                      key: "vol_min";
                      min: 2; 
                      max: 40 
                    }
        ListElement { type: "indicator"; 
                      name: "FIO<sub>2</sub>"; 
                      unit: "%"; 
                      key: "fio2";
                      min: 21; 
                      max: 100 
                    }
        ListElement { type: "toggle"; label: "Pausa \n Expiratória"; actionName: "toggleExpirationPause"; }
        ListElement { type: "toggle"; label: "Pausa \n Inspiratória"; actionName: "toggleInspirationPause"; }
        ListElement { type: "toggle"; label: "Ventilação\nPCV"; actionName: "toggleAssistedVentilation"; }
    }
   
    ListModel {
        id: indicatorsVCVModel
        ListElement { type: "indicator"; 
                      name: "T. INSP"; 
                      unit: "s"; 
                      key: "tInsp";
                      min: 5; 
                      max: 70 
                    }
        ListElement { type: "indicator"; 
                      name: "P<sub>PICO</sub>"; 
                      unit: 'cmH<sub>2</sub>O' ;
                      key: "pe";
                      min: 2; 
                      max: 40 
                    }
        ListElement { type: "indicator"; 
                      name: "Vt"; 
                      unit: "ml"; 
                      key: "ve";
                      min: 2; 
                      max: 40 
                    }
        ListElement { type: "indicator"; 
                      name: "Vol<sub>MIN</sub>"; 
                      unit: "l/min"; 
                      key: "vol_min";
                      min: 2; 
                      max: 40 
                    }
        ListElement { type: "indicator"; 
                      name: "FIO<sub>2</sub>"; 
                      unit: "%"; 
                      key: "fio2";
                      min: 21; 
                      max: 100 
                    }
        ListElement { type: "toggle"; label: "Pausa \n Expiratória"; actionName: "toggleExpirationPause"; }
        ListElement { type: "toggle"; label: "Pausa \n Inspiratória"; actionName: "toggleInspirationPause"; }
        ListElement { type: "toggle"; label: "Ventilação\nVCV"; actionName: "toggleAssistedVentilation"; }
    }
    
    Rectangle {
        z: 1
        anchors.fill: parent
        visible: dashboardPageRoot.lockScreenStatus
        color: "#00000000"
        MouseArea {
            anchors.fill: parent
            onClicked: {
                rootTopBar.bad("Tela está bloqueada!")
            }
            onPressAndHold: {
                dashboardPageRoot.lockScreenStatus = false
                rootTopBar.good("Tela desbloqueada!")
                rootTopBar.unlock()
            }
        }
    }
    
    Rectangle {
        anchors.fill: parent
        color: root.foregroundColor
    }
    
    RowLayout {
        anchors.fill: parent
        spacing: 1
        ToolBar {
            id: leftSideToolBar

            Layout.fillHeight: true
            Layout.preferredWidth: dashboardPageRoot.sideBarWidth
            
            property string currentModel: "closedMenu" + dashboardPageRoot.currentMode
            property var actions: { 
                "openMenu": () => { leftSideToolBar.currentModel = "openedMenu" },
                "closeMenu": () => { leftSideToolBar.currentModel = "closedMenu" + dashboardPageRoot.currentMode },
                "openPersonSettingsPage": () => { 
                    system.hardware_controller.write_data("STOP", "")
                    system.hardware_controller.write_data("STOP_SENDING", "")
                    pageStack.replace("qrc:/pages/PersonSettingsPage.qml")
                },
                "openOperationModePage": () => { 
                    system.hardware_controller.write_data("STOP", "")
                    system.hardware_controller.write_data("STOP_SENDING", "")
                    pageStack.replace("qrc:/pages/ModeSettingsPage.qml")
                },
                "openAlarmsSettingsPage": () => { 
                    system.hardware_controller.write_data("STOP", "")
                    system.hardware_controller.write_data("STOP_SENDING", "")
                    pageStack.replace("qrc:/pages/AlarmSettingsPage.qml")
                },
                "openUpdateSidePanel": (value, key, label, step, interval) => { 
                    updatePropSideBar.open(value, key, label, step, interval)
                },
            }
            
            ColumnLayout {
                anchors.fill: parent            
                spacing: 1
                Repeater {
                    id: leftSideToolBarRepeater
                    model: dashboardPageRoot.models[leftSideToolBar.currentModel]
                    delegate: MenuItem {
                        settings: leftSideToolBarRepeater.model.get(index)
                        clickAction: leftSideToolBar.actions[actionName]
                    }
                }
            }

            SideBar {
                id:updatePropSideBar

                onSave: {
                    system.operation_mode_controller.add_parameter(key, value)
                    system.hardware_controller.write_data("SET", key)
                    rootTopBar.good("Parâmetro salvo com sucesso!")
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
                    leftMargin: 3
                }
                LineChart {
                    id: pawChart
                    min: -0.5
                    max: 60
                    title: "PAW<br>[cmH<sub>2</sub>O]"
                }
                LineChart {
                    id: vtidalChart
                    min: -1
                    max: 1000
                    title: "V<sub>tidal</sub><br>[ml]"
                }
                LineChart {
                    id: flowChart
                    min: -100
                    max: 100
                    title: "Flow<br>[slpm]"
                }
            }
        }
        ToolBar {
            id: rightSideToolBar
            Layout.fillHeight: true
            Layout.preferredWidth: dashboardPageRoot.sideBarWidth

            property var actions: { 
                "toggleExpirationPause": (currentState) => {
                    system.operation_mode_controller.add_parameter("pExp", currentState ? 1 : 0)
                    system.hardware_controller.write_data("SET", "pExp")
                    console.log(currentState)
                },
                "toggleInspirationPause": (currentState) => {
                    system.operation_mode_controller.add_parameter("pInsp", currentState ? 1 : 0)
                    system.hardware_controller.write_data("SET", "pInsp")
                    console.log(currentState)
                },
                "toggleAssistedVentilation": (currentState) => {
                    if (currentState) {
                        system.hardware_controller.write_data("START", "")
                    } else {
                        system.hardware_controller.write_data("STOP", "")
                    }
                    console.log(currentState)
                }
            }
            
            ColumnLayout {
                anchors.fill: parent            
                spacing: 1
                Repeater {
                    id: rightSideToolBarRepeater
                    model: indicatorsModels[currentMode]
                    delegate: MenuItem {
                        settings: rightSideToolBarRepeater.model.get(index)
                        clickAction: rightSideToolBar.actions[actionName]
                        indicatorsValues: dashboardPageRoot.indicatorsValues 
                    }
                }
            }
        }
    }
    
    AlertSideBar {
        id:alertSideBar
        width: parent.width * 0.81
        height: parent.height
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
    }
}