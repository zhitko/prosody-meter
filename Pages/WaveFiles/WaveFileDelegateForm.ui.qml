import QtQuick 2.14
import QtQuick.Controls 2.14

Item {
    id: element
    property alias mouseArea: mouseArea
    property alias label: label

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }

    Text {
        id: label
        color: "#a0000000"
        text: name
        anchors.topMargin: 17
        anchors.fill: parent
        font.bold: true
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1;anchors_height:100;anchors_width:100;anchors_x:223;anchors_y:195}
D{i:2;anchors_x:10;anchors_y:10}
}
##^##*/

