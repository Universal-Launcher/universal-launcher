import QtQuick 2.15
import QtQuick.Controls 2.15
import UniversalLauncher 1.0
import "qrc:/qml/common/ui"

Popup {
    id: authPopup

    parent: Overlay.overlay

    width: 400
    height: 300

    modal: true
    focus: true
    closePolicy: Popup.NoAutoClose

    background: Rectangle {
        color: AppGlobal.themes.current.backgroundColor2
        radius: AppGlobal.themes.current.radius
    }

    anchors {
        centerIn: parent
    }

    UButton {
        id: cancelBtn
        btnText: qsTr("Cancel")
        onClicked: function() {
            auth.stop()
            close()
        }
        anchors {
            horizontalCenter: parent.horizontalCenter
        }
    }

    Authentication {
        id: auth

        onAuthFinished: function() {
            close()
        }
        onAuthFailed: function() {
            console.log("Auth failed")
            close()
        }
    }

    onOpened: function() {
        console.log("lol")
        auth.startProcess();
    }
}
