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

    ListModel {
        id: closedMenuModel
        ListElement { type: "button"; label: "Menu"; actionName: "openMenu"; }
        ListElement { type: "item"; label: "Resp. Rate"; value: '12'; min: '4'; max: '60'; unit: 'b/min' }
        ListElement { type: "item"; label: "Insp./Expir."; value: '1 : 2'; min: '1'; max: '4'; unit: 'ratio' }
        ListElement { type: "item"; label: "Insp. Pressure"; value: '15'; min: '2'; max: '40'; unit: '[cmH<sub>2</sub>O]' }
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

    Connections {
        target: chartUpdateTimer
        onTriggered: {
            console.log("CHART UPDATE TIMER TRIGGERED!")
            chart1.addRandomPoint()
            chart2.addRandomPoint()
            chart3.addRandomPoint()
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
                    pageStack.push("qrc:/pages/PersonSettingsPage.qml") 
                },
                "openOperationModePage": () => { 
                    pageStack.push("qrc:/pages/ModeSettingsPage.qml")
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
                    id: chart1
                    title: "PAW<br>[cmH<sub>2</sub>O]"
                }
                LineChart {
                    id: chart2
                    title: "V<sub>tidal</sub><br>[ml]"
                }
                LineChart {
                    id: chart3
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