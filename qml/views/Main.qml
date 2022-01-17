import QtQuick 2.15
import QtQuick.Controls 2.15
import "../components/navigation"

import Authentication 1.0

Page {
    id: main

    property var currentMenu: null
    signal onViewChange(string action, string viewUrl)

    QtObject {
        id: internal

        function setPage(page, url) {
            if (currentMenu !== page) {
                page.isActiveMenu = true
                if (currentMenu !== null) {
                    currentMenu.isActiveMenu = false
                }
                currentMenu = page

                stackView.push(Qt.resolvedUrl(url))
            }
        }
    }

    Sidebar {
        id: leftMenu

        Column {
            id: column
            spacing: 10

            anchors {
                topMargin: 20
                rightMargin: 20
                leftMargin: 20

                left: parent.left
                right: parent.right
                top: parent.top
            }

            Text {
                id: title
                text: "Universal\nLauncher"
                font.pixelSize: 16
                font.capitalization: Font.AllUppercase
                font.bold: Font.Bold
                color: "#d1d5db"

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
                isActiveMenu: true
                onClicked: { internal.setPage(btnHome, "../pages/homePage.qml") }

                width: column.width
            }

            SidebarItem {
                id: btnModpacks
                text: qsTr("Modpacks")
                iconPath: "/images/icons/box.svg"
                isActiveMenu: false
                onClicked: { internal.setPage(btnModpacks, "../pages/modpacksPage.qml") }

                width: column.width
            }

        }

        Column {
            id: bottomColumn
            spacing: 10

            anchors {
                bottomMargin: 20
                rightMargin: 20
                leftMargin: 20

                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            SidebarUserAccount {
                id: btnAccount

                onClicked: function () {
                    if (Authentication.isAuthenticated) {
                        internal.setPage(btnAccount, "../pages/accountPage.qml")
                    } else {
                        main.onViewChange("push", "/qml/views/Login.qml")
                    }
                }

                width: bottomColumn.width

                authenticated: Authentication.isAuthenticated
            }

            SidebarItem {
                id: btnSettings
                text: qsTr("Settings")
                iconPath: "/images/icons/cog.svg"
                isActiveMenu: false
                onClicked: { internal.setPage(btnSettings, "../pages/settingsPage.qml") }

                width: bottomColumn.width

                notifCount: 2
            }
        }
    }

    Rectangle {
        id: contentPage
        color: "#0F172A"
        anchors {
            left: leftMenu.right
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            rightMargin: 0
            leftMargin: 0
            bottomMargin: 0
            topMargin: 0
        }
        clip: true

        StackView {
            id: stackView
            anchors {
                fill: parent
                leftMargin: 20
                rightMargin: 20
                topMargin: 20
                bottomMargin: 20
            }

            pushEnter: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 0
                    to:1
                    duration: 200
                }
            }
            pushExit: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 1
                    to:0
                    duration: 200
                }
            }

            Component.onCompleted: {
                internal.setPage(btnHome, "../pages/homePage.qml")
            }
        }
    }

    Connections {
        target: Authentication

        function onAuthChanged (authenticated) {
            if (Authentication.isAuthenticated) {
                var account = Authentication.getMinecraftProfile();
                btnAccount.accountName = account.username;
                btnAccount.imgUrl = account.avatar;
            }
        }
    }
}
