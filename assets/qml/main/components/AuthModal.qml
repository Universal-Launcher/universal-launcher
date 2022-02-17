import QtQuick 2.15
import QtQuick.Controls 2.15
import UniversalLauncher 1.0
import "qrc:/qml/common/ui"

Popup {
    id: authPopup

    parent: Overlay.overlay

    width: 400
    height: 150

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

    Text {
        id: title
        text: qsTr("Authenticating")
        font.pixelSize: 20
        color: AppGlobal.themes.current.textColor
    }

    Text {
        id: messageTxt
        color: AppGlobal.themes.current.textColor
        anchors {
            horizontalCenter: parent.horizontalCenter
            margins: 20
            top: title.bottom
        }
    }

    UButton {
        id: cancelBtn
        btnText: qsTr("Cancel")
        onClicked: function() {
            AccountsManager.cancelLogin()
            close()
        }
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 10
        }
    }

    onOpened: function() {
        AccountsManager.addAccount()
    }

    Connections {
        target: AccountsManager
        function onAuthMessage(text) {
            messageTxt.text = text
        }

        function onAccountsListUpdated() {
            close()
        }
    }
}
