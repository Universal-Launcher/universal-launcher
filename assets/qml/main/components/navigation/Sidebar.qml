import QtQuick 2.15
import UniversalLauncher 1.0
import "."

Rectangle {
    id: sidebar
    color: AppGlobal.themes.current.backgroundColor
    width: 200

    anchors {
        left: parent.left
        top: parent.top
        bottom: parent.bottom
        topMargin: 0
        leftMargin: 0
        bottomMargin: 0
    }

    z: 1

    Rectangle {
        id: borderRight
        width: 1
        height: parent.height * 0.9
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        color: AppGlobal.themes.current.backgroundColor2

        radius: 4
    }

    Column {
        id: topColumn
        spacing: 10

        anchors {
            margins: 20
            bottomMargin: 0

            left: parent.left
            right: parent.right
            top: parent.top
        }

        Text {
            id: title
            text: qsTr("Universal\nLauncher")
            font.pixelSize: 16
            font.capitalization: Font.AllUppercase
            font.bold: Font.Bold
            color: AppGlobal.themes.current.textColor

            height: 100

            anchors {
                left: parent.left
                right: parent.right
            }
        }

        SidebarItem {
            id: btnHome
            text: qsTr("Home")
            iconPath: "/images/icons/home.svg"
            isActive: AppGlobal.router.currentRouteName == "home"
            onClicked:  AppGlobal.router.goTo("home")
            width: parent.width
        }

        SidebarItem {
            id: btnModpacks
            text: qsTr("Modpacks")
            iconPath: "/images/icons/box.svg"
            isActive: AppGlobal.router.currentRouteName == "modpacks"
            onClicked: AppGlobal.router.goTo("modpacks")
            width: parent.width
        }
    }

    Column {
        id: bottomColumn
        spacing: 10

        anchors {
            margins: 20
            topMargin: 0

            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        SidebarItem {
            id: btnAccounts
            text: qsTr("Accounts")
            iconPath: "/images/icons/user-circle.svg"
            isActive: AppGlobal.router.currentRouteName == "accounts"
            onClicked: AppGlobal.router.goTo("accounts")
            width: parent.width
        }

        SidebarItem {
            id: btnSettings
            text: qsTr("Settings")
            iconPath: "/images/icons/cog.svg"
            isActive: AppGlobal.router.currentRouteName == "settings"
            onClicked: AppGlobal.router.goTo("settings")
            width: parent.width
            notifCount: 2
        }
    }
}
