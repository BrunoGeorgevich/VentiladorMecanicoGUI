import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Qt.labs.qmlmodels 1.0

import "qrc:/components"
import "qrc:/pages"

Page {
    objectName: "ModePage"
    id:modeSettingsPageRoot

    property var models: [ pcvModel, vcvModel ]
    property var controlsModels: { "sensibilityModel": sensibilityModel }

    Connections {
        target: rootTopBar
        onRightButtonClicked: {
            system.hardware_controller.write_data("SET ALL", undefined)
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
                        elementStep: 0.1;  
                        elementPreffix: '1:' 
                    }
        ListElement {   elementLabel: "rr";
                        elementType: "TouchSpinBox";
                        elementName: "RR";  
                        elementValue: 12;  
                        elementPreffix: ''
                    }
        ListElement {   elementLabel: "pip";
                        elementType: "TouchSpinBox";
                        elementName: "Pressão Pico";  
                        elementValue: 30;  
                        elementPreffix: '' 
                    }
        ListElement {   elementLabel: "peep";
                        elementType: "TouchSpinBox";
                        elementName: "PEEP";  
                        elementValue: 12;  
                        elementPreffix: '' 
                    }
        ListElement {   elementLabel: "sensiT";
                        elementType: "Buttons";
                        elementChecked: "pressure";  
                        elementName: "Tipo de Sensibilidade";
                        elementChildrenModel: "sensibilityModel" 
                    }
        ListElement {   elementLabel: "sensiV";
                        elementType: "TouchSpinBox";
                        elementName: "Sensiblidade";  
                        elementValue: 12;  
                        elementPreffix: '' 
                    }
    }

    ListModel {
        id: vcvModel
        ListElement {   elementLabel: "volume";
                        elementType: "TouchSpinBox";
                        elementName: "Volume"; 
                        elementValue: 15;  
                        elementPreffix: '' 
                    }
        ListElement {   elementLabel: "rr";
                        elementType: "TouchSpinBox";
                        elementName: "RR";  
                        elementValue: 12;  
                        elementPreffix: ''
                    }
        ListElement {   elementLabel: "flow";
                        elementType: "TouchSpinBox";
                        elementName: "Fluxo";  
                        elementValue: 30;  
                        elementPreffix: '' 
                    }
        ListElement {   elementLabel: "peep";
                        elementType: "TouchSpinBox";
                        elementName: "PEEP";  
                        elementValue: 12;  
                        elementPreffix: '' 
                    }
        ListElement {   elementLabel: "sensiT";
                        elementType: "Buttons";
                        elementChecked: "pressure";  
                        elementName: "Tipo de Sensibilidade";
                        elementChildrenModel: "sensibilityModel" 
                    }
        ListElement {   elementLabel: "sensiV";
                        elementType: "TouchSpinBox";
                        elementName: "Sensiblidade";  
                        elementValue: 12;  
                        elementPreffix: '' 
                    }
    }

    ColumnLayout {
        anchors.fill: parent
        
        Item {
            Layout.preferredHeight: 80
            Layout.fillWidth: true

            TabBar {
                id:operationModeTabBar

                function getParsedCurrentIndex() {
                    let len = tabsModel.count
                    let idx = system.operation_mode_controller.get_mode_parsed()
                    if (idx > len + 1 || idx < 0) {
                        return 0
                    }
                    return idx
                }

                anchors.fill: parent
                currentIndex: getParsedCurrentIndex()

                ListModel {
                    id: tabsModel
                    ListElement {
                        elementText: "PCV";
                        elementFullSizeText: "Pressão Controlada";
                        elementEnabled: true;
                    }
                    ListElement {
                        elementText: "VCV";
                        elementFullSizeText: "Volume Controlado";
                        elementEnabled: true;
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
                rows: 3

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
                                        step: elementStep !== undefined ? elementStep : 1
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
                                    fontSize: 10
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