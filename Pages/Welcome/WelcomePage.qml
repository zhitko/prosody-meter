import QtQuick 2.14

WelcomePageForm {
    id: page

    property var bus: ""

    bStart.onClicked: {
        bus.openWaveFilesPage()
    }

    anchors.fill: parent
}
