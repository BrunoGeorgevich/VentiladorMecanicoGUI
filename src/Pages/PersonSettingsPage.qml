import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "qrc:/components"
import "qrc:/pages"

Page {  
    objectName: "PersonPage"
    property var person: { 'gender': -1, 'height': 160, 'name': '' }
    
    footer: BottomBar { 
        hasLeftButton: false
        rightButtonAction: () => { 
            pageStack.push("qrc:/pages/ModeSettingsPage.qml", { person: person })
        }
    }

    Rectangle { anchors.fill: parent; color: "white" }
    
    ColumnLayout {
        anchors.fill: parent

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Field {
                anchors.centerIn: parent
                name: "Nome"
                width: 450; height: 120
                control: TextField { 
                    width: 450; height: 50
                    font.pointSize: 18
                    maximumLength: 30
                    placeholderText: qsTr("Ex.: João") 
                    text: person['name']
                    onTextChanged: person['name'] = text
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Field {
                anchors.centerIn: parent
                name: "Altura"
                width: 280; height: 120
                control: TouchSpinBox{ 
                    value: person['height']
                    onValueChanged: person['height'] = value
                }
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
                        ListElement { elementText: "♂"; elementValue: "male"; elementIsEnable: true}
                        ListElement { elementText: "♀"; elementValue: "female"; elementIsEnable: true}
                    }
                    numOfItens: 2
                    value: person['gender']
                    onValueChanged: person['gender'] = value 
                }
            }
        }
    }
}