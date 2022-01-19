import QtQuick 2.15
import QtQuick.Controls 2.15
import "../components/ui"

Popup {
    id: login

    parent: Overlay.overlay
    x: Math.round((parent.width - width) / 2)
    y: Math.round((parent.height - height) / 2)
    width: 400
    height: 250

    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

    background: Rectangle {
        color: "#1F2937"
        anchors.fill: parent
    }

    Rectangle {
        color: "#00000000"
        anchors.fill: parent
        anchors.margins: 20


        Text {
            id: title
            font.pixelSize: 20
            color: "white"
            text: qsTr("Authenticating with Microsoft")
        }

        UBusyIndicator {
            id: indicator
            width: 40
            height: 40

            anchors {
                top: title.bottom
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                margins: 20
                bottomMargin: 0
            }
        }
    }

    Connections {
        target: Authentication

        function onAuthChanged (authenticated) {

        }
    }

    Component.onCompleted: {
        //Authentication.authorize()
    }
}
