import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    title: qsTr("Universal-Launcher - Setup")
    width: 480
    height: 720
    id: window
    visible: isVisible

    property bool isVisible: true
    property bool screenInit: false

    Text {
        id: txt
        text: "salut"
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
