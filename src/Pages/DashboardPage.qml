import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "qrc:/components"

Page {
    id: dashboardPageRoot
    property real footerBarHeight: 90
    property var models: {
                "closedMenu": closedMenuModel,
                "openedMenu": openedMenuModel,
                "settingsMenu": settingsMenuModel,
                "specialOpsMenu": specialOpsMenuModel
            }
   
    ListModel {
        id: closedMenuModel
        ListElement { type: "button"; label: "Menu"; actionName: "openMenu"; width: 120 }
        ListElement { type: "item"; label: "Resp. Rate"; value: '12'; min: '4'; max: '60'; unit: 'b/min' }
        ListElement { type: "item"; label: "Insp./Expir."; value: '1 : 2'; min: '1'; max: '4'; unit: 'ratio' }
        ListElement { type: "item"; label: "Insp. Pressure"; value: '15'; min: '2'; max: '40'; unit: '[cmH<sub>2</sub>O]' }
        ListElement { type: "status"; action: "Stopped"; mode: 'PCV' }
    }
   
    ListModel {
        id: openedMenuModel
        ListElement { type: "button"; label: "Back"; actionName: "closeMenu"; width: 120 }
        ListElement { type: "button"; label: "Settings"; actionName: "openSettingsMenu" }
        ListElement { type: "button"; label: "Special Operations"; actionName: "openSpecialOpsMenu" }
        ListElement { type: "button"; label: "Set\nPSV"; actionName: "foo" }
        ListElement { type: "button"; label: "Start\nPCV"; actionName: "foo" }
    }
   
    ListModel {
        id: settingsMenuModel
        ListElement { type: "button"; label: "Back"; actionName: "closeSettingsMenu"; width: 120 }
        ListElement { type: "button"; label: "Mode\nSettings"; actionName: "foo" }
        ListElement { type: "button"; label: "Alarm\nSettings"; actionName: "foo" }
        ListElement { type: "button"; label: "Lock\nScreen"; actionName: "foo" }
    }
   
    ListModel {
        id: specialOpsMenuModel
        ListElement { type: "button"; label: "Back"; actionName: "closeSpecialOpsMenu"; width: 120 }
        ListElement { type: "button"; label: "Inspiratory\nPause"; actionName: "foo" }
        ListElement { type: "button"; label: "Expiratory\nPause"; actionName: "foo" }
        ListElement { type: "button"; label: "Freeze"; actionName: "foo" }
        ListElement { type: "button"; label: "Country-Specific\nProcedures"; actionName: "foo" }
    }
    
    Rectangle {
        anchors.fill: parent
        color: 'black'
    }
    
    footer: ToolBar {
        id: footerToolBar
        height: dashboardPageRoot.footerBarHeight
        width: parent.width
        
        property string currentModel: "closedMenu"
        property var actions: { 
            "openMenu": () => { footerToolBar.currentModel = "openedMenu" },
            "closeMenu": () => { footerToolBar.currentModel = "closedMenu" },
            "openSettingsMenu": () => { footerToolBar.currentModel = "settingsMenu" },
            "closeSettingsMenu": () => { footerToolBar.currentModel = "openedMenu" },
            "openSpecialOpsMenu": () => { footerToolBar.currentModel = "specialOpsMenu" },
            "closeSpecialOpsMenu": () => { footerToolBar.currentModel = "openedMenu" },
            "foo": () => { console.log("ajsdoaisjdioasjodasjoid") }
        }
        
        RowLayout {
            anchors.fill: parent            
            spacing: 2
            Repeater {
                id: footerToolBarRepeater
                model: dashboardPageRoot.models[footerToolBar.currentModel]
                delegate: MenuItem {
                    settings: footerToolBarRepeater.model.get(index)
                    clickAction: footerToolBar.actions[actionName]
                }
            }
        }
    }
}