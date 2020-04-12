import QtQuick 2.14
import QtQuick.Controls 2.14

Dialog {
    id: dialog
    modal: true
    standardButtons: Dialog.Ok | Dialog.Cancel

    onAccepted: {
        dialog.visible = false
    }

    onRejected: {
        dialog.visible = false
    }
}
