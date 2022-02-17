import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import UniversalLauncher 1.0

Button {
    id: button

    default property url iconPath: "/images/icons/ellipsis-v.svg"
    property int iconWidth: 18
    property int iconHeight: 18

    width: 35
    height: 35

    background: Rectangle {
        id: bg
        anchors.fill: button
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        
        
        radius: 5
        color: "transparent"

        border {
            color: AppGlobal.themes.current.textColor
            width: 1
        }
    }

    states: [
        State {
            name: "NORMAL"
            PropertyChanges { target: bg; color: "transparent" }
            PropertyChanges { target: iconOverlay; color: AppGlobal.themes.current.textColor }
        },
        State {
            name: "HOVER"
            PropertyChanges { target: bg; color: AppGlobal.themes.current.textColor }
            PropertyChanges { target: iconOverlay; color: AppGlobal.themes.current.backgroundColor2 }
        }
    ]

    transitions: [
        Transition {
            from: "*"
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

    contentItem: Item {
        Image {
            id: icon
            source: iconPath
            anchors {
                horizontalCenter: parent.horizontalCenter
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
            id: iconOverlay
            anchors.fill: icon
            source: icon
            color: AppGlobal.themes.current.textColor
            antialiasing: true
            width: iconWidth
            height: iconHeight
        }

    }
}
