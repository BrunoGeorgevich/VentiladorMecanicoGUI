import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtCharts 2.12

import "qrc:/components"

Page {
    objectName: "DashboardPage"
    id: dashboardPageRoot
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
    
    signal dataArrived(var data)
    onDataArrived: {
        pawChart.addPoint(data['paw'])
        vtidalChart.addPoint(data['vtidal'])
        flowChart.addPoint(data['flow'])
    }
    
    ListModel {
        id: closedMenuModel
        ListElement { type: "button"; label: "Menu"; actionName: "openMenu"; }
        ListElement { 
            type: "item"; 
            label: "Resp. Rate"; 
            parameterName: "rr";
            min: '4'; 
            max: '60'; 
            twoUnits: false;
            unit: 'b/min' 
        }
        ListElement { 
            type: "item"; 
            label: "Insp./Expir."; 
            parameterPrefix: "1 : ";
            parameterName: "ie";
            min: '1'; 
            max: '4'; 
            twoUnits: false;
            unit: 'ratio' 
        }
        ListElement { 
            type: "item"; 
            label: "Insp. Pressure"; 
            parameterName: "pp";
            min: '2'; 
            max: '40'; 
            twoUnits: false;
            unit: '[cmH<sub>2</sub>O]' 
        }
        ListElement { 
            type: "item"; 
            label: "Sensibilidade"; 
            parameterName: "sensibilityValue";
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
        ListElement { type: "button"; label: "Bloquear 🔒"; actionName: "lockScreen" }
    }
   
    ListModel {
        id: indicatorsModel
        ListElement { type: "indicator"; 
                      name: "MEAS RR"; 
                      unit: "bpm"; 
                      value: 56; 
                      min: 0; 
                      max: 17 
                    }
        ListElement { type: "indicator"; 
                      name: "MAX P<sub>insp</sub>"; 
                      unit: "cmH<sub>2</sub>O"; 
                      value: 101; 
                      min: 5; 
                      max: 70 
                    }
        ListElement { type: "indicator"; 
                      name: "PEEP"; 
                      unit: "cmH<sub>2</sub>O"; 
                      value: 19; 
                      min: -30; 
                      max: 30 
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
            Layout.fillHeight: true
            Layout.preferredWidth: dashboardPageRoot.sideBarWidth
            
            ColumnLayout {
                anchors.fill: parent            
                spacing: 1
                Repeater {
                    id: leftSideToolBarRepeater
                    model: indicatorsModel
                    delegate: MenuItem {
                        settings: leftSideToolBarRepeater.model.get(index)
                    }
                }
            }
        }
    }
}