import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "."

Window {
    title: qsTr("Universal-Launcher - Setup")
    width: 960
    height: 640
    id: window
    visible: true

    property bool screenInit: false

    Setup {
        id: main
        anchors.fill : parent
    }

    Connections {
        target: window
        function onScreenChanged() {
            if (!screenInit) {
                // we have actual screen delivered here for the time when app stats
                screenInit = true
                window.x = screen.width / 2 - window.width / 2
                window.y = screen.height / 2 - window.height / 2
            }
        }
    }
}
