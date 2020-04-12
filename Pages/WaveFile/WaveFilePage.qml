import QtQuick 2.14
import QtCharts 2.14

import intondemo.backend 1.0

import "../../Components"

WaveFilePageForm {
    id: root

    property var bus: ""

    title: root.name
    anchors.fill: parent

    signal record(string path)

    property var fullWaveData;
    property var intensityData;
    property var segmantWaveData;
    property var currentPoint: 0;
    property var startPoint: 0.0;
    property var endPoint: 1.0;
    property var manualSegments: [];
    property var autoSegments: [];

    Backend {
        id: backend
    }

    function randomScalingFactor() {
        return Math.random().toFixed(1);
    }

    function addDataToSeries(serias, data)
    {
        serias.clear()
        for (let value in data){
            serias.append(data[value].x, data[value].y)
        }
    }

    function loadWave() {
        console.log("Load WAVE data")
        root.fullWaveData = backend.getWaveData(root.path)
        let waveLen = root.fullWaveData.length - 1
        fullWaveSeriesX.max = root.fullWaveData[waveLen].x
        addDataToSeries(fullWaveSeries, root.fullWaveData)
    }

    function loadIntensity() {
        console.log("Load Intensity data")
        var data = backend.getIntensity(root.path)
        intensityData = data

        addDataToSeries(intensitySeries, data)
    }

    function loadIntensitySmoothed() {
        console.log("Load Smoothed Intensity data")
        var data = backend.getIntensitySmoothed(root.path)

        addDataToSeries(intensitySmoothedSeries, data)
    }

    function loadSegmentedWave() {
        console.log("Load segmented Wave data")
        var data = backend.getWaveSegmantData(root.path, startPoint, endPoint)
        segmantWaveData = data
        segmantWaveSeriesX.max = data[data.length-1].x

        addDataToSeries(segmantWaveSeries, data)
    }


    function loadSegmentsMask() {
        segmentsMaskSeries.values = []
        segmentsMaskX.categories = []

        let data = backend.getSegmentsByIntensityMask(root.path, startPoint, endPoint)

        var max = 0;
        for(let i in data) {
            if (data[i] > max) max = data[i]
            segmentsMaskSeries.append(data[i])
            segmentsMaskX.categories.push(i)
        }
        console.log("loadSegmentsMask max: " + max);
        segmentsMaskY.max = max + 1
    }

    function addSeries(chart, seriesX, seriesY, color, isVisible, width, series_name, data) {
        var line = chart.createSeries(ChartView.SeriesTypeLine, series_name, seriesX, seriesY)
        line.width = width
        line.color = color
        line.pointsVisible = false
        line.capStyle = "FlatCap"
        line.visible = isVisible
        for(let i in data) {
            line.append(data[i].x, data[i].y)
        }
        return line;
    }

    function loadSegments(color, series_name, data, collection, isVisible) {
        console.log(series_name + " segmants count: " + data.length)

        for(let i in data) {
            collection.push(addSeries(
                fullWave,
                fullWaveSeriesX,
                fullWaveSeriesY,
                color,
                isVisible,
                999,
                series_name,
                [{x:data[i].x, y:0}, {x:data[i].y, y:0}]
            ))
        }
    }

    showManualSegments.onCheckedChanged: {
        console.log("showManualSegments: " + showManualSegments.checked)
        for (let autoSegment in root.autoSegments)
            root.autoSegments[autoSegment].visible = !showManualSegments.checked;
        for (let manualSegment in root.manualSegments)
            root.manualSegments[manualSegment].visible = showManualSegments.checked;
    }

    function loadMetrics() {
        let waveLength = backend.getWaveLength(root.path, startPoint, endPoint);
        recordLengthValue.text = String(waveLength.toFixed(2))

        let vowelsCount = backend.getVowelsCount(root.path, startPoint, endPoint)
        vowelsCountValue.text = String(vowelsCount)

        let vowelsRate = backend.getVowelsRate(root.path, startPoint, endPoint)
        vowelsRateValue.text = String(vowelsRate.toFixed(2))

        let vowelsLength = backend.getVowelsLength(root.path, startPoint, endPoint)
        vowelsLengthValue.text = String(vowelsLength.toFixed(2))

        let consonantsAndSilenceLength = backend.getConsonantsAndSilenceLength(root.path, startPoint, endPoint)
        consonantsAndSilenceLengthValue.text = String(consonantsAndSilenceLength.toFixed(2))

        let consonantsAndSilenceCount = backend.getConsonantsAndSilenceCount(root.path, startPoint, endPoint)
        consonantsAndSilenceCountValue.text = String(consonantsAndSilenceCount)

        let vowelsMean = backend.getVowelsMeanValue(root.path, startPoint, endPoint)
        vowelsMeanValue.text = String(vowelsMean.toFixed(2))

        let consonantsAndSilenceMean = backend.getConsonantsAndSilenceMeanValue(root.path, startPoint, endPoint)
        consonantsAndSilenceMeanValue.text = String(consonantsAndSilenceMean.toFixed(2))

        let consonantsAndSilenceMedian = backend.getConsonantsAndSilenceMedianValue(root.path, startPoint, endPoint)
        consonantsAndSilenceMedianValue.text = String(consonantsAndSilenceMedian)

        let vowelsMedianMedian = backend.getVowelsMedianValue(root.path, startPoint, endPoint)
        vowelsMedianValue.text = String(vowelsMedianMedian)
    }

    function setStartStopPosition(segmentsByIntensity)
    {
        root.startPoint = segmentsByIntensity[0].x

        let segmentsLen = segmentsByIntensity.length - 1
        root.endPoint = segmentsByIntensity[segmentsLen].y

        let waveLen = root.fullWaveData.length
        root.startPoint = root.startPoint / waveLen
        root.endPoint = root.endPoint/ waveLen

        console.log("root.startPoint: " + root.startPoint)
        console.log("root.endPoint: " + root.endPoint)

        fullWaveSelect.clear()
        fullWaveSelect.append(root.startPoint, -1)
        fullWaveSelect.append(root.endPoint, -1)
    }

    Component.onCompleted: {
        let segmantsAlpha = "40"
        let segmentsByIntensity = backend.getSegmentsByIntensity(root.path)

        loadSegments(Colors.setAlpha(Colors.green, segmantsAlpha),
                     qsTr("Nuclea"),
                     segmentsByIntensity,
                     root.autoSegments,
                     !showManualSegments.checked)

        console.log("autoSegments: " + root.autoSegments)

        loadSegments(Colors.setAlpha(Colors.green, segmantsAlpha),
                     qsTr("Pre-nuclea"),
                     backend.getSegmentsP(root.path),
                     root.manualSegments,
                     showManualSegments.checked)
        loadSegments(Colors.setAlpha(Colors.blue, segmantsAlpha),
                     qsTr("Nuclea"),
                     backend.getSegmentsN(root.path),
                     root.manualSegments,
                     showManualSegments.checked)
        loadSegments(Colors.setAlpha(Colors.pink, segmantsAlpha),
                     qsTr("Post-nuclea"),
                     backend.getSegmentsT(root.path),
                     root.manualSegments,
                     showManualSegments.checked)
        console.log("manualSegments: " + root.manualSegments)

        loadWave()
        setStartStopPosition(segmentsByIntensity);
        loadIntensity()
        loadIntensitySmoothed()
        loadSegmentedWave()
        loadSegmentsMask()
        loadMetrics()

        recordButton.bus = bus
    }

    fullWaveMouseArea.onClicked: {
        console.log("onClicked: " + point.x + ", " + point.y);
        if (currentPoint == 0)
        {
            fullWaveSelect.clear()
            fullWaveSelect.append(point.x, -1)

            startPoint = point.x
            console.log("startPoint: " + startPoint)
            currentPoint = 1;
        } else {
            fullWaveSelect.append(point.x, -1)

            endPoint = point.x
            console.log("endPoint: " + endPoint)
            currentPoint = 0;

            if (endPoint < startPoint)
            {
                [endPoint, startPoint] = [startPoint, endPoint];
            }

            loadSegmentedWave()
            loadSegmentsMask()
            loadMetrics()
        }
    }
}
