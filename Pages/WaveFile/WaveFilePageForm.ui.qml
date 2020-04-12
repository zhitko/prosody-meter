import QtQuick 2.14
import QtQuick.Controls 2.14
import QtCharts 2.3
import QtQuick.Layouts 1.14

import "../../Components"
import "../../Components/Buttons"

Page {
    id: root
    property string name: "Name"
    property string path: "Path"
    property alias fullWave: fullWave
    property alias fullWaveSeries: fullWaveSeries
    property alias fullWaveSeriesX: fullWaveSeriesX
    property alias fullWaveSeriesY: fullWaveSeriesY
    property alias segmantWaveSeries: segmantWaveSeries
    property alias segmantWaveSeriesX: segmantWaveSeriesX
    property alias fullWaveSelect: fullWaveSelect
    property alias fullWaveMouseArea: fullWaveMouseArea
    property alias intensitySeries: intensitySeries
    property alias intensitySmoothedSeries: intensitySmoothedSeries
    property alias showManualSegments: showManualSegments
    property alias recordButton: recordButton
    property alias recordLengthValue: recordLengthValue
    property alias vowelsCountValue: vowelsCountValue
    property alias vowelsRateValue: vowelsRateValue
    property alias consonantsAndSilenceLengthValue: consonantsAndSilenceLengthValue
    property alias segmentsMaskSeries: segmentsMaskSeries
    property alias segmentsMaskX: segmentsMaskX
    property alias segmentsMaskY: segmentsMaskY
    property alias testSeries: testSeries
    property alias testSeriesX: testSeriesX
    property alias testSeriesY: testSeriesY
    property alias vowelsMeanValue: vowelsMeanValue
    property alias consonantsAndSilenceCountValue: consonantsAndSilenceCountValue
    property alias vowelsLengthValue: vowelsLengthValue
    property alias consonantsAndSilenceMeanValue: consonantsAndSilenceMeanValue
    property alias consonantsAndSilenceMedianValue: consonantsAndSilenceMedianValue
    property alias vowelsMedianValue: vowelsMedianValue
    title: qsTr("Wave file")

    ValueAxis {
        id: fullWaveSeriesY
        min: -1
        max: 1
        labelsVisible: false
    }

    ValueAxis {
        id: fullWaveSeriesX
        min: 0
        max: 1000
        labelsVisible: false
    }

    ScrollView {
        id: scrollView
        padding: 10
        contentHeight: rowLayout.height + fullWave.height + segmantWave.height + metrixBox.height
        anchors.fill: parent

        RowLayout {
            id: rowLayout
            height: 40
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 0

            Switch {
                id: showIntensitySwitch
                text: qsTr("Intensity")
            }

            Switch {
                id: showIntensitySmoothed
                text: qsTr("Smoothed Intensity")
            }

            Switch {
                id: showManualSegments
                text: qsTr("Manual Segments")
                Layout.fillWidth: true
            }
        }

        ChartView {
            id: fullWave
            height: root.height * 0.4
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: rowLayout.bottom
            anchors.topMargin: 0
            legend.visible: false

            LineSeries {
                id: fullWaveSeries
                name: qsTr("Full wave")
                axisY: fullWaveSeriesY
                axisX: fullWaveSeriesX
                color: Colors.teal_blue
            }

            LineSeries {
                id: intensitySeries
                name: qsTr("Intensity")
                axisY: fullWaveSeriesY
                axisX: fullWaveSeriesX
                width: 2
                color: Colors.purple
                visible: showIntensitySwitch.checked
            }

            LineSeries {
                id: intensitySmoothedSeries
                name: qsTr("Intensity smoothed")
                axisY: fullWaveSeriesY
                axisX: fullWaveSeriesX
                width: 2
                color: Colors.raspberry
                visible: showIntensitySmoothed.checked
            }

            LineSeries {
                id: fullWaveSelect
                name: qsTr("Selected segment")
                pointsVisible: true
                width: 4
                color: Colors.raspberry

                axisY: fullWaveSeriesY
                axisX: ValueAxis {
                    min: 0
                    max: 1
                    labelsVisible: false
                }

                XYPoint {
                    x: 0
                    y: -1
                }

                XYPoint {
                    x: 1000
                    y: -1
                }
            }
        }

        ChartView {
            x: 10
            y: 40
            legend.visible: false
            anchors.fill: fullWave
            opacity: 0.1

            LineSeries {
                id: fullWaveMouseArea
                color: "#00ffffff"
                pointsVisible: false
                width: 999

                axisY: ValueAxis {
                    min: -1
                    max: 1
                    labelsVisible: false
                }

                axisX: ValueAxis {
                    min: 0
                    max: 1
                    labelsVisible: false
                }

                XYPoint {
                    x: 0
                    y: -1
                }

                XYPoint {
                    x: 1000
                    y: -1
                }
            }
        }

        ChartView {
            id: segmantWave
            height: root.height * 0.4
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: fullWave.bottom
            anchors.topMargin: 0
            legend.visible: false

            ValueAxis {
                id: segmantWaveSeriesY
                min: -1
                max: 1
                labelsVisible: false
            }

            ValueAxis {
                id: segmantWaveSeriesX
                min: 0
                max: 1
                labelsVisible: false
            }

            BarSeries {
                id: segmentsMask
                opacity: 0.1
                axisX: BarCategoryAxis {
                    id: segmentsMaskX
                    labelsVisible: false
                }
                axisY: ValueAxis {
                    id: segmentsMaskY
                    labelsVisible: false
                }
                BarSet {
                    id: segmentsMaskSeries
                    color: "#80358f45"
                    values: []
                }
            }

            LineSeries {
                id: segmantWaveSeries
                name: qsTr("Wave segment")
                color: Colors.teal_blue

                axisY: segmantWaveSeriesY
                axisX: segmantWaveSeriesX
            }

            LineSeries {
                id: testSeries
                name: qsTr("TEST")
                pointsVisible: true
                width: 4
                color: Colors.black

                axisY: ValueAxis {
                    id: testSeriesY
                    min: 0
                    max: 2
                    labelsVisible: false
                }
                axisX: ValueAxis {
                    id: testSeriesX
                    min: 0
                    max: 1000
                    labelsVisible: false
                }
            }
        }

        GroupBox {
            id: metrixBox
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: segmantWave.bottom
            anchors.topMargin: 0
            font.bold: true
            Layout.margins: 10
            Layout.fillHeight: true
            Layout.fillWidth: true
            font.pointSize: 14
            title: qsTr("Metrics")

            ColumnLayout {
                id: columnLayout1
                anchors.fill: parent

                Text {
                    id: recordLengthTitle
                    text: qsTr("Record Length")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: recordLengthValue
                    text: "---"
                    font.pointSize: 12
                }

                Text {
                    id: consonantsAndSilenceLengthTitle
                    text: qsTr("Consonants & Silence Length")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: consonantsAndSilenceLengthValue
                    text: "---"
                    font.pointSize: 12
                }

                Text {
                    id: consonantsAndSilenceCountTitle
                    text: qsTr("Consonants & Silence Count")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: consonantsAndSilenceCountValue
                    text: "---"
                    font.pointSize: 12
                }

                Text {
                    id: consonantsAndSilenceMeanTitle
                    text: qsTr("Consonants & Silence Mean Duration")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: consonantsAndSilenceMeanValue
                    text: "---"
                    font.pointSize: 12
                }

                Text {
                    id: consonantsAndSilenceMedianTitle
                    text: qsTr("Consonants & Silence Median Duration")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: consonantsAndSilenceMedianValue
                    text: "---"
                    font.pointSize: 12
                }

                Text {
                    id: vowelsLengthTitle
                    text: qsTr("Vowels Length")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: vowelsLengthValue
                    text: "---"
                    font.pointSize: 12
                }

                Text {
                    id: vowelsCountTitle
                    text: qsTr("Vowels Count")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: vowelsCountValue
                    text: "---"
                    font.pointSize: 12
                }

                Text {
                    id: vowelsMeanTitle
                    text: qsTr("Vowels Mean Duration")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: vowelsMeanValue
                    text: "---"
                    font.pointSize: 12
                }

                Text {
                    id: vowelsMedianTitle
                    text: qsTr("Vowels Median Duration")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: vowelsMedianValue
                    text: "---"
                    font.pointSize: 12
                }

                Text {
                    id: vowelsRateTitle
                    text: qsTr("Vowels Speaking Rate")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: vowelsRateValue
                    text: "---"
                    font.pointSize: 12
                }
            }
        }
    }

    BottomBar {
        id: bottombar
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        content.data: [
            PlayButton {
                path: root.path
            },
            RecordButton {
                id: recordButton
            }
        ]
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

