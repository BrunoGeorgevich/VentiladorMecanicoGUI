import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "qrc:/components"
import "qrc:/pages"

Page {
    objectName: "ModePage"
    id:modeSettingsPageRoot

    property var models: [ pcvModel ]
    
    Connections {
        target: rootTopBar
        onRightButtonClicked:  {
            pageStack.push("qrc:/pages/DashboardPage.qml")
        }
        onLeftButtonClicked:  {
            pageStack.pop()
        }
    }

    ListModel {
        id: pcvModel
        ListElement {   elementLabel: "ie";
                        elementName: "I:E"; 
                        elementValue: 2;  
                        elementMin: 2;  
                        elementMax: 8;  
                        elementPreffix: '1:' 
                    }
        ListElement {   elementLabel: "rr";
                        elementName: "RR";  
                        elementValue: 12;  
                        elementMin: 5;  
                        elementMax: 20;  
                        elementPreffix: ''
                    }
        ListElement {   elementLabel: "pp";
                        elementName: "Pressão Pico";  
                        elementValue: 30;  
                        elementMin: 5;  
                        elementMax: 60;  
                        elementPreffix: '' 
                    }
        ListElement {   elementLabel: "peep";
                        elementName: "PEEP";  
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
                    delegate: Item {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        Field {
                            anchors.centerIn: parent
                            name: elementName
                            fontSize: 15
                            width: 280; height: 100
                            control: TouchSpinBox{ 
                                scale: 0.8
                                min: elementMin
                                max: elementMax
                                preffix: elementPreffix
                                value: system.operation_mode_controller.operation_mode.parameters[elementLabel] || elementValue
                                onValueChanged: system.operation_mode_controller.add_parameter(elementLabel, value)
                            }
                        }
                    }
                }
            }
        }
    }
}