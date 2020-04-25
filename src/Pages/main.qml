import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "qrc:/components/"

ApplicationWindow {
    id: root
    visible: true
    width: 800; height: 480
    
    property real footerBarHeight: 90
   
    ListModel {
        id: closedMenuModel
        ListElement { type: "button"; label: "Menu"; actionName: "toggleMenu"; width: 120 }
        ListElement { type: "item"; label: "Resp. Rate"; value: '12'; min: '4'; max: '60'; unit: 'b/min' }
        ListElement { type: "item"; label: "Insp./Expir."; value: '1 : 2'; min: '1'; max: '4'; unit: 'ratio' }
        ListElement { type: "item"; label: "Insp. Pressure"; value: '15'; min: '2'; max: '40'; unit: '[cmH<sub>2</sub>O]' }
        ListElement { type: "status"; action: "Stopped"; mode: 'PCV' }
    }
   
    ListModel {
        id: openedMenuModel
        ListElement { type: "button"; label: "Back"; actionName: "toggleMenu"; width: 120 }
        ListElement { type: "button"; label: "Settings"; actionName: "toggleMenu" }
        ListElement { type: "button"; label: "Special Operations"; actionName: "toggleMenu" }
        ListElement { type: "button"; label: "Set\nPSV"; actionName: "toggleMenu" }
        ListElement { type: "button"; label: "Start\nPCV"; actionName: "toggleMenu" }
    }
    
    Rectangle {
        anchors.fill: parent
        color: 'black'
    }
    
    footer: ToolBar {
        id: footerToolBar
        height: root.footerBarHeight
        width: parent.width
        
        property bool menuIsOpened: false
        property var actions: { 
            "toggleMenu": footerToolBar.toggleMenu,
        }
        
        function toggleMenu() {
            footerToolBar.menuIsOpened = !footerToolBar.menuIsOpened
        }
        
        RowLayout {
            anchors.fill: parent            
            spacing: 2
            Repeater {
                model: closedMenuModel
                delegate: MenuItem {
                    visible: !footerToolBar.menuIsOpened
                    settings: closedMenuModel.get(index)
                    clickAction: footerToolBar.actions[actionName]
                }
            }
            Repeater {
                model: openedMenuModel
                delegate: MenuItem {
                    visible: footerToolBar.menuIsOpened
                    settings: openedMenuModel.get(index)
                    clickAction: footerToolBar.actions[actionName]
                }
            }
        }
    }
}