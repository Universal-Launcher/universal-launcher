import QtQuick 2.15
import QtQuick.Controls 2.15
import UniversalLauncher 1.0
import QtGraphicalEffects 1.15

MenuItem {
    id: item

    property color hoverColor: AppGlobal.themes.current.backgroundColor2
    property color textHoverColor: AppGlobal.themes.current.accentColor
    property url iconPath: ""

    background: Rectangle {
        id: bg
        color: "transparent"
        implicitHeight: 40
        implicitWidth: 150
        radius: AppGlobal.themes.current.radius
    }

    onHoveredChanged: function() {
        if (item.hovered) {
            state = "HOVER"
        } else {
            state = "NORMAL"
        }
    }

    states: [
        State {
            name: "NORMAL"
            PropertyChanges { target: bg; color: "transparent" }
            PropertyChanges { target: label; color: AppGlobal.themes.current.textColor }
            PropertyChanges { target: iconOverlay; color: AppGlobal.themes.current.textColor }
        },
        State {
            name: "HOVER"
            PropertyChanges { target: bg;  color: hoverColor }
            PropertyChanges { target: label; color: textHoverColor }
            PropertyChanges { target: iconOverlay; color: textHoverColor }
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
            to: "HOVER"
            ColorAnimation { duration: 250; easing.type: Easing.InOutQuad }
        }
    ]

    contentItem: Item {
        anchors.fill: parent
        Image {
            id: icon
            source: iconPath
            anchors {
                leftMargin: 10
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            visible: false
            antialiasing: true
        }

        ColorOverlay {
            visible: item.iconPath != ""
            id: iconOverlay
            anchors.fill: icon
            color: AppGlobal.themes.current.textColor
        }

        Item {
            anchors {
                margins: 10
                left: iconPath == "" ? parent.left : iconOverlay.right
                right: parent.right
                verticalCenter: parent.verticalCenter
            }

            Label {
                id: label
                text: item.text
                font: item.font
                color: AppGlobal.themes.current.textColor

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.centerIn: parent
            }
        }
    }
}
