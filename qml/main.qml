import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    width: 640
    height: 480
    visible: isVisible
    title: qsTr("Hello World")

    property bool isVisible: false

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
            id: stack
            initialItem: Qt.resolvedUrl("views/Login.qml")
            anchors.fill: parent
        }
    }



    Connections {
        id: backend

    }
}
