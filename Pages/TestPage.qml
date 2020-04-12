import QtCharts 2.14
import QtQuick 2.14


ChartView {
    id: root
    title: "Line"
    anchors.fill: parent
    antialiasing: true

    function addSeries(data) {
        var line = root.createSeries(ChartView.SeriesTypeLine, "Line series", seriesX, seriesY)
        line.color = "red"
        for(let i in data) {
            line.append(data[i][0], data[i][1])
        }
    }

    Component.onCompleted: {
        addSeries([[0,0],[1.1, 2.1],[1.9, 3.3], [2.1, 2.1]])
        addSeries([[2.9, 4.9],[3.5, 3.0],[4.1, 3.3], [4.9, 0.1]])
    }

    ValueAxis {
        id: seriesY
        min: 0
        max: 5
    }

    ValueAxis {
        id: seriesX
        min: 0
        max: 5
    }
}
