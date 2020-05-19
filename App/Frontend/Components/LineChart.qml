import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtCharts 2.12

Item {
    id: chartRoot
    property real numOfPoints: 60
    property alias title: chartTitle.text
    
    function addRandomPoint() {
        ls.lastVal = Math.random()*100
        if (ls.count < numOfPoints) {
            ls.append(ls.count, ls.lastVal)
        } else {
            if (ls.currentIndex >= numOfPoints - 1) ls.currentIndex = 0
            ls.replace(ls.currentIndex, ls.at(ls.currentIndex).y , ls.currentIndex, ls.lastVal)
        }
        ss.remove(0)
        ss.insert(0, ls.currentIndex, ls.lastVal)
        ls.currentIndex += 1
    }

    Layout.fillHeight: true
    Layout.fillWidth: true

    RowLayout {
        anchors.fill: parent

        Item {
            Layout.fillHeight: true
            Layout.preferredWidth: 60
            Label {
                id:chartTitle
                anchors.fill: parent
                text: `${ls.lastVal.toFixed(0)}` || ''
                font { pointSize: 15; bold: true }
                fontSizeMode: "Fit"
                color: root.accentColor
                verticalAlignment: "AlignVCenter"
                horizontalAlignment: "AlignHCenter"
                transform: Rotation { origin.x: chartTitle.width/2; origin.y: chartTitle.height/2; angle: -90}
            }
        }

        ChartView {            
            Layout.fillHeight: true
            Layout.fillWidth: true
            
            backgroundColor: "transparent"

            antialiasing: true
            legend.visible: false
            margins { 
                top: 0
                left: 0
                right: 0
                bottom: 0
            }
            animationDuration: 166
            animationOptions: ChartView.SeriesAnimations

            ValueAxis {
                id: xAxis
                max: numOfPoints
                gridVisible: false
                labelsVisible: false    
            }
            ValueAxis {
                id: yAxis
                max: ls.yMax
                labelsFont.pointSize: 6
                labelsColor: root.accentColor
            }

            LineSeries {
                id: ls

                property real yMax: 5
                property real currentIndex: 0
                property real lastVal: 0

                function refreshYMax() {
                    let majorY = -99999999;
                    for (let i = 0; i < count; i++) {
                        if(at(i).y > majorY) {
                            majorY = at(i).y
                        }
                    }
                    yMax = majorY * 1.1;
                }

                axisX: xAxis
                axisY: yAxis
                width: 2
                capStyle: "RoundCap"
                color: root.foregroundColor

                onPointAdded: refreshYMax()
                onPointReplaced: refreshYMax()
            }

            ScatterSeries {
                id:ss
                axisX: xAxis
                axisY: yAxis         
                color: root.accentColor
            }
        }
        Label {
            Layout.fillHeight: true
            Layout.preferredWidth: 50

            text: `${ls.lastVal.toFixed(0)}` || ''
            font { pointSize: 35; bold: true }
            fontSizeMode: "Fit"
            color: ls.color || root.primaryColor
            verticalAlignment: "AlignVCenter"
            horizontalAlignment: "AlignHCenter"
        }
    }
}