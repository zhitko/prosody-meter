import QtQuick 2.14
import QtQuick.Controls 2.14

Page {
    id: filesForm
    property alias items: items
    property alias listModel: listModel

    title: qsTr("Files")

    ListView {
        id: items
        anchors.fill: parent
        delegate: Item {
            id: element1
            x: 0
            height: 50
            Row {
                id: row
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                Text {
                    id: element
                    text: "#title#"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    font.bold: true
                }
                spacing: 10
            }
        }
        model: ListModel {
            id: listModel
            ListElement {
                title: "Title"
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

