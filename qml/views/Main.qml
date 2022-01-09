import QtQuick 2.15
import QtQuick.Controls 2.15
import "../components/navigation"

Page {
    id: main

    property SidebarItem currentMenu: btnHome

    QtObject {
        id: internal

        function setPage(page, url) {
            if (currentMenu !== page) {
                page.isActiveMenu = true
                currentMenu.isActiveMenu = false
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
                iconPath: "../../images/icons/home.svg"
                isActiveMenu: true
                onClicked: { internal.setPage(btnHome, "../pages/homePage.qml") }

                width: column.width
            }

            SidebarItem {
                id: btnModpacks
                text: qsTr("Modpacks")
                iconPath: "../../images/icons/box.svg"
                isActiveMenu: false
                onClicked: { internal.setPage(btnModpacks, "../pages/homePage.qml") }

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

            SidebarItem {
                id: btnSettings
                text: qsTr("Settings")
                iconPath: "../../images/icons/cog.svg"
                isActiveMenu: false
                onClicked: { internal.setPage(btnSettings, "../pages/homePage.qml") }

                width: bottomColumn.width

                notifCount: 2
            }
        }
    }

    Rectangle {
        id: contentPage
        color: "#00000000"
        anchors {
            left: leftMenu.right
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            rightMargin: 0
            leftMargin: 0
            bottomMargin: 25
            topMargin: 0
        }
        clip: true

        StackView {
            id: stackView
            anchors.fill: parent
            initialItem: Qt.resolvedUrl("../pages/homePage.qml")
        }
    }
}
