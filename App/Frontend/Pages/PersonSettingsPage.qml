import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "qrc:/functions/utils.js" as Utils
import "qrc:/components"
import "qrc:/pages"

Page {  
    objectName: "PersonPage"
    id: personPageRootPage
    
    Rectangle { anchors.fill: parent; color: "white" }
    
    ColumnLayout {
        anchors {
            fill: parent
        }

        // Item {
        //     Layout.fillWidth: true
        //     Layout.fillHeight: true

        //     Field {
        //         anchors.centerIn: parent
        //         name: "Nome"
        //         width: 450; height: 120
        //         control: TextField { 
        //             width: 450; height: 50
        //             font.pointSize: 18
        //             maximumLength: 30
        //             placeholderText: qsTr("Ex.: João") 
        //             text: system.person_controller.person.name
        //             onTextChanged: system.person_controller.person.name = text
        //         }
        //     }
        // }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Field {
                id: heightField
                anchors.centerIn: parent
                name: "Altura (cm)"
                width: 280; height: 120
                control: TouchSpinBox{ 
                    id: heightControl
                    Component.onCompleted: {
                        value = system.person_controller.person.height
                    }
                    onValueChanged: system.person_controller.person.height = heightControl.value
                }
            }

            Label {

                anchors {
                    right: parent.right
                    bottom: heightField.bottom
                    rightMargin: 60
                    bottomMargin: 15
                }

                verticalAlignment: "AlignVCenter"
                horizontalAlignment: "AlignHCenter"
                font.pointSize: 20

                text: `Peso Predito:\n${Utils.predictWeight()} kg`
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Field {
                anchors.centerIn: parent
                name: "Sexo"
                width: 280; height: 140
                control: Chooser{ 
                    options: ListModel {
                        ListElement { elementType: "label"; elementText: "♂"; elementValue: "male"; elementIsEnable: true}
                        ListElement { elementType: "label"; elementText: "♀"; elementValue: "female"; elementIsEnable: true}
                    }
                    numOfItens: 2
                    Component.onCompleted: {
                        value = system.person_controller.person.gender
                    }
                    onValueChanged: system.person_controller.person.gender = value
                }
            }
        }
    }
}