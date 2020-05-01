import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "qrc:/components"
import "qrc:/pages"

Page {
    id:modeSettingsPageRoot
    property var person: {}
    property var operationMode: { "mode": "", "settings": {} }
    
    property var models: {
                "pcvModel": pcvModel
            }

    ListModel {
        id: pcvModel
        ListElement { elementName: "I:E"; 
                        elementValue: 2;  
                        elementMin: 2;  
                        elementMax: 8;  
                        elementPreffix: '1:' }
        ListElement { elementName: "RR";  
                        elementValue: 12;  
                        elementMin: 5;  
                        elementMax: 20;  
                        elementPreffix: '' }
        ListElement { elementName: "Pressão Pico";  
                        elementValue: 30;  
                        elementMin: 5;  
                        elementMax: 60;  
                        elementPreffix: '' }
        ListElement { elementName: "PEEP";  
                        elementValue: 12;  
                        elementMin: 5;  
                        elementMax: 25;  
                        elementPreffix: '' }
    }

    header: TopBar{
        text: "Configurações do Modo de Operação" 
    }
    footer: BottomBar { 
        leftButtonAction: () => { 
            pageStack.pop()
        }
        rightButtonAction: () => { 
            pageStack.push("qrc:/pages/DashboardPage.qml", { person: person })
        }
    }

    ColumnLayout {
        anchors.fill: parent

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 140

            Field {
                anchors.centerIn: parent
                name: "Modo de Operação"
                width: 280; height: 140
                control: Chooser{ 
                    options: ListModel {
                        ListElement { elementText: "PCV"; elementValue: "pcv"; elementIsEnable: true}
                        ListElement { elementText: "PSV"; elementValue: "psv"; elementIsEnable: false}
                    }
                    fontSize: 18
                    numOfItens: 2
                    onValueChanged: {
                        operationMode['mode'] = value 
                        operationModeRepeater.model = models[`${operationMode.mode}Model`]
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
                                value: elementValue
                                preffix: elementPreffix
                                onValueChanged: person['height'] = value
                            }
                        }
                    }
                }
            }
        }
    }
}