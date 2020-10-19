import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import "../../Components"

Page {
    id: page
    property alias intensityFrameValue: intensityFrameValue
    property alias intensitySmoothFrameValue: intensitySmoothFrameValue
    property alias intensityShiftValue: intensityShiftValue
    property alias intensityMaxLengthValue: intensityMaxLengthValue
    property alias intensityDoubleSmoothFrameValue: intensityDoubleSmoothFrameValue
    title: qsTr("Settings")

    ScrollView {
        id: scrollView
        contentWidth: parent.width
        clip: true
        anchors.fill: parent
        ScrollBar.vertical.interactive: true

        ColumnLayout {
            id: columnLayout1
            anchors.fill: parent
            spacing: 10

            GroupBox {
                id: intensityGroup
                Layout.margins: 10
                Layout.fillWidth: true
                font.pointSize: 14
                title: qsTr("Intensity")

                ColumnLayout {
                    id: columnLayout
                    anchors.fill: parent

                    Text {
                        id: intensityFrameTitle
                        text: qsTr("Frame")
                        font.pointSize: 12
                    }

                    SpinBox {
                        id: intensityFrameValue
                        to: 1024
                        wheelEnabled: true
                        editable: true
                    }

                    Text {
                        id: intensityShiftTitle
                        text: qsTr("Shift")
                        font.pointSize: 12
                    }

                    SpinBox {
                        id: intensityShiftValue
                        to: 512
                        wheelEnabled: true
                        editable: true
                    }

                    Text {
                        id: intensitySmoothFrameTitle
                        text: qsTr("Smooth Frame")
                        font.pointSize: 12
                    }

                    SpinBox {
                        id: intensitySmoothFrameValue
                        to: 1024
                        wheelEnabled: true
                        editable: true
                    }

                    Text {
                        id: intensityDoubleSmoothFrameTitle
                        text: qsTr("Second Smooth Frame")
                        font.pointSize: 12
                    }

                    SpinBox {
                        id: intensityDoubleSmoothFrameValue
                        to: 1024
                        wheelEnabled: true
                        editable: true
                    }

                    Text {
                        id: intensityMaxLengthTitle
                        text: qsTr("Segment length limit (millisec)")
                        font.pointSize: 12
                    }

                    SpinBox {
                        id: intensityMaxLengthValue
                        to: 2000
                        wheelEnabled: true
                        editable: true
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}
}
##^##*/

