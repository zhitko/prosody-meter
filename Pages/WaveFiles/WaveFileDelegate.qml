import QtQuick 2.14
import QtQuick.Controls 2.14

ItemDelegate {
    height: 50
    property alias element: element

    WaveFileDelegateForm {
        id: element
    }
}
