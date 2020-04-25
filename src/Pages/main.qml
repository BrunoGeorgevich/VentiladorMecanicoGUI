import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "qrc:/components/"

ApplicationWindow {
    id: root
    visible: true
    width: 800; height: 600
    
    property real footerBarHeight: 100
   
    ListModel {
        id: closedMenuModel
        ListElement { type: "button"; label: "A"; actionName: "toggleMenu" }
        ListElement { type: "item"; label: "A"; }
    }
   
    ListModel {
        id: openedMenuModel
        ListElement { type: "button"; label: "B"; actionName: "toggleMenu" }
        ListElement { type: "item"; label: "B"; }
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