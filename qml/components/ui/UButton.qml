import QtQuick 2.0
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects

Button {
    id: button

    default property alias btnText: label.text

    property url iconPath: ""
    property int iconWidth: 18
    property int iconHeight: 18

    width: iconPath == "" ? 100 : 120
    height: 35

    background: Rectangle {
        id: bg
        anchors.fill: parent
        radius: 5
        border.color: "white"
        border.width: 1
        color: "transparent"
    }

    states: [
        State {
            name: "NORMAL"
            PropertyChanges { target: bg; color: "transparent" }
            PropertyChanges { target: label; color: "white" }
            PropertyChanges { target: iconOverlay; color: "white" }
        },
        State {
            name: "HOVER"
            PropertyChanges { target: bg; color: "white" }
            PropertyChanges { target: label; color: "black" }
            PropertyChanges { target: iconOverlay; color: "black" }
        }
    ]

    transitions: [
        Transition {
            from: ""
            to: "HOVER"
            ColorAnimation { duration: 250; easing.type: Easing.InOutQuad }
        },
        Transition {
            from: "*"
            to: "NORMAL"
            ColorAnimation { duration: 250; easing.type: Easing.InOutQuad }
        }

    ]

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onPressed: function(mouse) { mouse.accepted = false }
    }

    onHoveredChanged: function() {
        if (button.hovered) {
            state = "HOVER"
        } else {
            state = "NORMAL"
        }
    }

    Image {
        id: icon
        source: iconPath
        anchors {
            leftMargin: 15
            left: parent.left
            verticalCenter: parent.verticalCenter
        }
        sourceSize.width: iconWidth
        sourceSize.height: iconHeight
        width: iconWidth
        height: iconHeight
        fillMode: Image.PreserveAspectFit
        visible: false
        antialiasing: true
    }

    ColorOverlay {
        visible: button.iconPath != ""
        id: iconOverlay
        anchors.fill: icon
        source: icon
        color: "white"
        antialiasing: true
        width: iconWidth
        height: iconHeight
    }

    Text {
        id: label
        color: button.hovered ? "black" : "white"
        anchors.leftMargin: button.iconPath != "" ? 40 : 0
        anchors {
            fill: parent
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
            margins: 10
        }
    }
}
