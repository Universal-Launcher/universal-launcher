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

    property bool isVisible: true

    Rectangle {
        id: bg
        color: "#374151"
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }

        z: 1

        StackView {
            id: windowStack
            anchors.fill: parent

            function onViewChange(action, viewUrl) {
                var item
                if (action === "pop") {
                    item = windowStack.pop()
                    item.onViewChange.disconnect(onViewChange)
                } else {
                    item = windowStack.push(Qt.resolvedUrl(viewUrl))
                    item.onViewChange.connect(onViewChange)

                }
            }

            Component.onCompleted: {
                onViewChange("push", "/qml/views/Main.qml")
            }
        }
    }

    property bool screenInit: false
    Connections {
        target: window
        function onScreenChanged(){
            if (!screenInit) {
                // we have actual screen delivered here for the time when app starts
                screenInit = true
                window.x = screen.width / 2 - 640 / 2
                window.y = screen.height / 2 - 480 / 2
            }
        }
    }
}
