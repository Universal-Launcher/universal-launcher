import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "."

Window {
    width: 960
    height: 640
    visible: isVisible
    title: qsTr("Universal-Launcher")
    id: window

    property bool isVisible: true
    property bool screenInit: false

    Main {
        id: main
        anchors.fill: parent
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
