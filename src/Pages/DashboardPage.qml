import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtCharts 2.12

import "qrc:/components"

Page {
    id: dashboardPageRoot
    property var person: {}
    property var operationMode: {}
    property real sideBarWidth: 150
    property var models: {
                "closedMenu": closedMenuModel,
                "openedMenu": openedMenuModel,
            }
   
   header: PersonDetailsTopBar {
       person: dashboardPageRoot.person
   }

    ListModel {
        id: closedMenuModel
        ListElement { type: "button"; label: "Menu"; actionName: "openMenu"; }
        ListElement { type: "item"; label: "Resp. Rate"; value: '12'; min: '4'; max: '60'; unit: 'b/min' }
        ListElement { type: "item"; label: "Insp./Expir."; value: '1 : 2'; min: '1'; max: '4'; unit: 'ratio' }
        ListElement { type: "item"; label: "Insp. Pressure"; value: '15'; min: '2'; max: '40'; unit: '[cmH<sub>2</sub>O]' }
        ListElement { type: "status"; action: "Stopped"; mode: 'PCV' }
    }

    ListModel {
        id: openedMenuModel
        ListElement { type: "button"; label: "Voltar"; actionName: "closeMenu"; }
        ListElement { type: "button"; label: "Mudar\ndo Paciente"; actionName: "openPersonSettingsPage" }
        ListElement { type: "button"; label: "Mudar\nModo de\nOperação"; actionName: "openOperationModePage" }
    }
   
    ListModel {
        id: indicatorsModel
        ListElement { type: "indicator"; 
                      name: "MEAS RR"; 
                      color: "#7FFFD4";
                      unit: "bpm"; 
                      value: 56; 
                      min: 0; 
                      max: 17 
                    }
        ListElement { type: "indicator"; 
                      name: "MAX P<sub>insp</sub>"; 
                      color: "#f08080";
                      unit: "cmH<sub>2</sub>O"; 
                      value: 101; 
                      min: 5; 
                      max: 70 
                    }
        ListElement { type: "indicator"; 
                      name: "PEEP"; 
                      color: "#87cefa";
                      unit: "cmH<sub>2</sub>O"; 
                      value: 19; 
                      min: -30; 
                      max: 30 
                    }
        ListElement { type: "indicator"; 
                      name: "V<sub>e</sub>"; 
                      color: "#FFFFCC";
                      unit: "slpm"; 
                      value: 30.3; 
                      min: 2; 
                      max: 40 
                    }
        ListElement { type: "indicator"; 
                      name: "FIO<sub>2</sub>"; 
                      color: "#FFAAAA";
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
        ToolBar {
            id: rightSideToolBar

            Layout.fillHeight: true
            Layout.preferredWidth: dashboardPageRoot.sideBarWidth
            
            property string currentModel: "closedMenu"
            property var actions: { 
                "openMenu": () => { rightSideToolBar.currentModel = "openedMenu" },
                "closeMenu": () => { rightSideToolBar.currentModel = "closedMenu" },
                "openPersonSettingsPage": () => { 
                    pageStack.push("qrc:/pages/PersonSettingsPage.qml", { person: person }) 
                },
                "openOperationModePage": () => { 
                    pageStack.push("qrc:/pages/ModeSettingsPage.qml", { person: person, operationMode: operationMode })
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
        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true

            ColumnLayout {
                anchors.fill: parent
                LineChart {
                    id: chart1
                    color: "#AAAA00"
                    title: "PAW<br>[cmH<sub>2</sub>O]"
                }
                LineChart {
                    id: chart2
                    color: "#00AA00"
                    title: "V<sub>tidal</sub><br>[ml]"
                }
                LineChart {
                    id: chart3
                    color: "#0000AA"
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

    Timer {
        interval: 166
        repeat: true
        running: true
        onTriggered: {
            chart1.addRandomPoint()
            chart2.addRandomPoint()
            chart3.addRandomPoint()
        }
    }
}