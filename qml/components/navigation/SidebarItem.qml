import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: sidebarItem
    text: qsTr("Left Menu Text")

    // CUSTOM PROPERTIES
    property bool isActiveMenu: false

    property url iconPath: ""
    property int iconWidth: 18
    property int iconHeight: 18

    property color bgColorDefault: "#00000000"
    property color textColorDefault: "#9ca3af"

    property color bgColorHover: "#4b5563"
    property color textColorHover: "#f3f4f6"

    property color bgColorActive: "#4b5563"
    property color textColorActive: "#f3f4f6"

    property int notifCount: -1

    QtObject {
        id: internal

        property var dynamicBgColor: if (isActiveMenu) {
                                       bgColorActive
                                   } else if (sidebarItem.hovered){
                                       bgColorHover
                                   } else {
                                       bgColorDefault
                                   }
        property var dynamicTextColor: if (isActiveMenu) {
                                           textColorActive
                                       } else if(sidebarItem.hovered) {
                                           textColorHover
                                       } else {
                                           textColorDefault
                                       }
    }

    implicitHeight: 37

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
    }

    background: Rectangle {
        id: bgBtn
        color: internal.dynamicBgColor
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
            color: internal.dynamicTextColor
            antialiasing: true
            width: iconWidth
            height: iconHeight
        }

        Text {
            color: internal.dynamicTextColor
            text: sidebarItem.text
            font: sidebarItem.font
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.right: parent.right
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
                verticalCenter: parent.verticalCenter
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
