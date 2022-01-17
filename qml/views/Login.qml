import QtQuick 2.15
import QtQuick.Controls 2.15
import QtWebView 1.1

import Authentication 1.0

Page {
    id: login

    signal onViewChange(string action, string viewUrl)

    background: Rectangle {
        color: "#00000000"
    }

    Rectangle {
        id: topbar
        color: "#1f2937"
        anchors {
            left: parent.left
            top: parent.top
            right: parent.right
            topMargin: 0
            leftMargin: 0
            rightMargin: 0
        }

        height: 50

        Text {
            font.pixelSize: 20
            color: "white"
            text: qsTr("Login with Microsoft")

            anchors.left: parent.left
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
        }

        Button {
            id: button
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            width: 70

            background: Rectangle {
                color: "#FFFFFF03"
                radius: 5
            }

            text: qsTr("Cancel")
            onClicked: {
                login.onViewChange("pop", "")
            }
        }
    }

    BusyIndicator {
        id: indicator
        anchors {
            top: topbar.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
    }

    function openUrl(u) {
        webview.url = u
    }

    Connections {
        target: Authentication

        function onAuthChanged (authenticated) {
            login.onViewChange("pop", "")
        }
    }

    Component.onCompleted: {
        Authentication.authorize()
    }
}
