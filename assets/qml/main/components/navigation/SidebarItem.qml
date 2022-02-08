import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import UniversalLauncher 1.0

Button {
    id: sidebarItem
    
    // CUSTOM PROPERTIES
    property bool isActive: false
    
    property url iconPath: ""
    property int iconWidth: 18
    property int iconHeight: 18

    property int notifCount: -1

    property var dynamicBgColor: if (isActive) {
        AppGlobal.themes.current.backgroundColor2
    } else if (sidebarItem.hovered) {
        AppGlobal.themes.current.backgroundColor2
    } else {
        AppGlobal.themes.current.backgroundColor
    }
    property var dynamicTextColor: if (isActive) {
        AppGlobal.themes.current.accentColor
    } else if (sidebarItem.hovered) {
        AppGlobal.themes.current.accentColor
    } else {
        AppGlobal.themes.current.textColor
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
        radius: AppGlobal.themes.current.radius

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
