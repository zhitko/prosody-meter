import QtQuick 2.14
import QtQuick.Controls 2.14

import "../../Components"
import "../../Components/Buttons"

import intondemo.backend 1.0

ListPageForm {
    id: root

    property var bus: ""

    Backend {
        id: backend
    }

    property var backend: backend

    anchors.right: parent.right
    anchors.rightMargin: 0
    anchors.left: parent.left
    anchors.leftMargin: 0
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 0
    anchors.top: parent.top
    anchors.topMargin: 0

    Component {
        id: elementDelegate
        ItemDelegate {
            id: itemRoot
            height: waveFile.height
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            PlayButton {
                id: playButton
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 10
                width: 20
                path: modelData.path
            }
            WaveFileDelegate {
                id: waveFile
                element.label.text: modelData.name
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: playButton.right
                anchors.leftMargin: 10
                onClicked: {
                    root.bus.openWaveFilePage(modelData.path)
                }
            }
            DeleteButton {
                path: modelData.path
                anchors.right: parent.right
                anchors.rightMargin: 10
                onDeleted: {
                    items.model = backend.getWaveFilesList()
                }
            }
        }
    }

    items.delegate: elementDelegate

    Component.onCompleted: {
        items.model = backend.getWaveFilesList();
    }

    BottomBar {
        content.data: [
            RecordButton {
                bus: root.bus
            }
        ]
    }
}
