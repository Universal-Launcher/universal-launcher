import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects

Button {
    id: sidebarItem
    text: qsTr("Left Menu Text")

    // CUSTOM PROPERTIES
    property bool isActiveMenu: false

    required property bool authenticated;
    property string accountName
    property url imgUrl
    property int imgWidth: 8
    property int imgHeight: 8

    property int iconWidth: 18
    property int iconHeight: 18

    property color bgColorDefault: "#00000000"
    property color textColorDefault: "#9ca3af"

    property color bgColorHover: "#4b5563"
    property color textColorHover: "#f3f4f6"

    property color bgColorActive: "#4b5563"
    property color textColorActive: "#F97316"

    QtObject {
        id: internal

        property var dynamicBgColor: if (isActiveMenu){
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
        onPressed: function(mouse) { mouse.accepted = false }
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

        Rectangle {
            id: mask
            visible: authenticated
            color: "white"
            anchors {
                leftMargin: 10
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            width: 24
            height: 24
            radius: 15

            Image {
                id: avatarHead
                source: sidebarItem.imgUrl
                sourceSize.width: imgWidth
                sourceSize.height: imgHeight
                anchors.fill: parent
                fillMode: Image.Stretch
                width: 24
                height: 24
                smooth: false
                mipmap: false
            }
        }

        Image {
            id: icon
            visible: false
            source: "/images/icons/user-circle.svg"
            sourceSize.width: iconWidth
            sourceSize.height: iconHeight
            fillMode: Image.PreserveAspectFit
            anchors {
                leftMargin: 10
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
        }

        ColorOverlay {
            visible: !authenticated
            anchors.fill: icon
            source: icon
            color: internal.dynamicTextColor
            antialiasing: true
            width: iconWidth
            height: iconHeight
        }

        Text {
            color: internal.dynamicTextColor
            text: authenticated ? sidebarItem.accountName : qsTr("Accounts")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.right: parent.right
        }
    }


}
