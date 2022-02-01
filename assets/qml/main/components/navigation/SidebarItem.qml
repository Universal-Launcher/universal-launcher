import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: sidebarItem
    
    // CUSTOM PROPERTIES
    property bool isActive: false
    
    property url iconPath: ""
    property int iconWidth: 18
    property int iconHeight: 18

    property color bgColorDefault: "#00000000"
    property color textColorDefault: "#374151"

    property color bgColorHover: "#E5E7EB"
    property color textColorHover: "#111827"

    property color bgColorActive: "#E5E7EB"
    property color textColorActive: "#F97316"

    property int notifCount: -1

    property var dynamicBgColor: if (isActive) {
        bgColorActive
    } else if (sidebarItem.hovered) {
        bgColorHover
    } else {
        bgColorDefault
    }
    property var dynamicTextColor: if (isActive) {
        textColorActive
    } else if (sidebarItem.hovered) {
        textColorHover
    } else {
        textColorDefault
    }

    implicitHeight: 37

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onPressed: function(mouse) { mouse.accepted = false }
    }

    background: Rectangle {
        id: bgBtn
        color: dynamicBgColor
        radius: 10

        anchors {
            left: parent.left
            right: parent.right
        }
    }

    contentItem: Item {
        anchors.fill: parent
        id: content

        Image {
            id: icon
            source: iconPath
            anchors {
                leftMargin: 10
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
            anchors.fill: icon
            source: icon
            color: dynamicTextColor
            antialiasing: MultiPointTouchArea
            width: iconWidth
            height: iconHeight
        }

        Text {
            color: dynamicTextColor
            text: sidebarItem.text
            font: sidebarItem.font
            anchors{
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 40
                right: parent.right
            }
        }

        Rectangle {
            id: notifBubble
            visible: notifCount >= 0
            radius: 20
            color: "red"

            width: 20
            height: 20

            anchors {
                rightMargin: 10
                right: parent.right
                verticalCenter: icon.verticalCenter
            }

            Text {
                id: notifNumber
                color: "white"
                text: notifCount
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
            }
        }
    }
}
