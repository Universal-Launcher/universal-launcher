import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "views"

Window {
    width: 960
    height: 640
    visible: isVisible
    title: qsTr("Hello World")
    id: window

    property bool isVisible: false
    property bool screenInit: false

    Main {
        id: main
        anchors.fill: parent
    }

    Login {
        id: login
        z: 10
    }

    Connections {
        target: window
        function onScreenChanged(){
            if (!screenInit) {
                // we have actual screen delivered here for the time when app starts
                screenInit = true
                window.x = screen.width / 2 - window.width / 2
                window.y = screen.height / 2 - window.height / 2
            }
        }
    }

    Component.onCompleted: {
        Authentication.refresh();
    }

    Connections {
        target: Authentication
        function onRefreshFinished() {
            isVisible = true;
        }
    }
}
