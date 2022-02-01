import QtQuick 2.15
import "."

Rectangle {
    id: sidebar
    color: "white"
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
        color: "#D1D5D8"

        radius: 4
    }

    default property string currentRoute

    signal routeChanged(string routeName)

    function changeRoute(route)
    {
        if (currentRoute != route)
        {
            currentRoute = route
            routeChanged(route)
        }
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
            color: "#1F2937"

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
            isActive: currentRoute === "home"
            onClicked: changeRoute("home")
            width: parent.width
        }

        SidebarItem {
            id: btnModpacks
            text: qsTr("Modpacks")
            iconPath: "/images/icons/box.svg"
            isActive: currentRoute === "modpacks"
            onClicked: changeRoute("modpacks")
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
            id: btnSettings
            text: qsTr("Settings")
            iconPath: "/images/icons/cog.svg"
            isActive: currentRoute === "settings"
            onClicked: changeRoute("settings")
            width: parent.width
            notifCount: 2
        }
    }
}