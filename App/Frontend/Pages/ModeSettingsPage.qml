import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Qt.labs.qmlmodels 1.0

import "qrc:/components"
import "qrc:/pages"

Page {
    objectName: "ModePage"
    id:modeSettingsPageRoot

    property var models: [ pcvModel ]
    property var controlsModels: { "sensibilityModel": sensibilityModel }
    
    Connections {
        target: rootTopBar
        onRightButtonClicked:  {
            pageStack.replace("qrc:/pages/DashboardPage.qml")
        }
        onLeftButtonClicked:  {
            pageStack.replace("qrc:/pages/PersonSettingsPage.qml")
        }
    }

    ListModel {
        id: sensibilityModel
        ListElement { elementText: "Pressão"; elementValue: "pressure"; elementIsEnable: true }
        ListElement { elementText: "Fluxo"; elementValue: "flow"; elementIsEnable: true  }
    }

    ListModel {
        id: pcvModel
        ListElement {   elementLabel: "ie";
                        elementType: "TouchSpinBox";
                        elementName: "I:E"; 
                        elementValue: 2;  
                        elementMin: 2;  
                        elementMax: 8;  
                        elementPreffix: '1:' 
                    }
        ListElement {   elementLabel: "rr";
                        elementType: "TouchSpinBox";
                        elementName: "RR";  
                        elementValue: 12;  
                        elementMin: 5;  
                        elementMax: 20;  
                        elementPreffix: ''
                    }
        ListElement {   elementLabel: "pp";
                        elementType: "TouchSpinBox";
                        elementName: "Pressão Pico";  
                        elementValue: 30;  
                        elementMin: 5;  
                        elementMax: 60;  
                        elementPreffix: '' 
                    }
        ListElement {   elementLabel: "peep";
                        elementType: "TouchSpinBox";
                        elementName: "PEEP";  
                        elementValue: 12;  
                        elementMin: 5;  
                        elementMax: 25;  
                        elementPreffix: '' 
                    }
        ListElement {   elementLabel: "sensibilityType";
                        elementType: "Buttons";
                        elementChecked: "pressure";  
                        elementName: "Tipo de Sensibilidade";
                        elementChildrenModel: "sensibilityModel" 
                    }
        ListElement {   elementLabel: "sensibilityValue";
                        elementType: "TouchSpinBox";
                        elementName: "Sensiblidade";  
                        elementValue: 12;  
                        elementMin: 5;  
                        elementMax: 25;  
                        elementPreffix: '' 
                    }
    }

    ColumnLayout {
        anchors.fill: parent
        
        Item {
            Layout.preferredHeight: 80
            Layout.fillWidth: true

            TabBar {
                anchors.fill: parent

                ListModel {
                    id: tabsModel
                    ListElement {
                        elementText: "PCV";
                        elementFullSizeText: "Pressure-Controller Ventilation";
                        elementEnabled: true;
                    }
                    ListElement {
                        elementText: "PSV";
                        elementFullSizeText: "Pressure Supported Ventilation";
                        elementEnabled: false;
                    }
                }

                onCurrentIndexChanged: {
                    let currentElement = tabsModel.get(currentIndex)
                    system.operation_mode_controller.set_mode(currentElement.elementText)
                    operationModeRepeater.model = models[currentIndex]
                }
                
                Repeater {
                    model: tabsModel
                    delegate: Tab {
                        text: elementText
                        enabled: elementEnabled
                        fullSizeText: elementFullSizeText
                    }
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            GridLayout {
                anchors.fill: parent
                columns: 2
                rows: 2

                Repeater {
                    id: operationModeRepeater
                    delegate: DelegateChooser {
                        role: "elementType"
                        DelegateChoice { roleValue: "TouchSpinBox"; 
                            Item {
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                Field {
                                    anchors.centerIn: parent
                                    name: elementName
                                    fontSize: 12
                                    width: 280; height: 70
                                    control: TouchSpinBox{ 
                                        scale: 0.65
                                        min: elementMin
                                        max: elementMax
                                        preffix: elementPreffix
                                        Component.onCompleted: {
                                            value = system.operation_mode_controller.operation_mode.parameters[elementLabel] || elementValue
                                        }
                                        onValueChanged: {
                                            system.operation_mode_controller.add_parameter(elementLabel, value)
                                        }
                                    }
                                }
                            }
                        }
                        DelegateChoice { roleValue: "Buttons"; 
                            Item {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                

                                Field {
                                    anchors.centerIn: parent
                                    name: elementName
                                    fontSize: 12
                                    width: 280; height: 70
                                    control: Chooser{ 
                                        options: controlsModels[elementChildrenModel]
                                        numOfItens: 2
                                        fontSize: 9
                                        buttonRadius: 50
                                        Component.onCompleted: {
                                            value = system.operation_mode_controller.operation_mode.parameters[elementLabel] || elementChecked
                                        }
                                        onValueChanged: {
                                            system.operation_mode_controller.add_parameter(elementLabel, value)
                                        }
                                    }
                                }
                            } 
                        }
                    }
                }
            }
        }
    }
}