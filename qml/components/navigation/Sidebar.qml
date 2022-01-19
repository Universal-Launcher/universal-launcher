import QtQuick 2.15

Rectangle {
    id: sidebar
    color: "#1f2937"
    width: 200

    anchors {
        left: parent.left
        bottom: parent.bottom
        top: parent.top
        topMargin: 0
        bottomMargin: 0
        leftMargin: 0
    }

    z: 1

    default property string currentRoute

    signal routeChanged(string routeName)

    function changeRoute(route) {
        if (currentRoute !== route) {
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
            top: parent.top
            right: parent.right
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
            isActiveMenu: currentRoute === "home"
            onClicked: changeRoute("home")

            width: parent.width
        }

        SidebarItem {
            id: btnModpacks
            text: qsTr("Modpacks")
            iconPath: "/images/icons/box.svg"
            isActiveMenu: currentRoute === "modpacks"
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
            bottom: parent.bottom
            right: parent.right
        }

        SidebarUserAccount {
            id: btnAccount
            width: parent.width
            isActiveMenu: currentRoute === "account"
            authenticated: Authentication.isAuthenticated
            onClicked: changeRoute("account")
        }

        SidebarItem {
            id: btnSettings
            text: qsTr("Settings")
            iconPath: "/images/icons/cog.svg"
            onClicked: changeRoute("settings")
            isActiveMenu: currentRoute === "settings"

            width: parent.width

            notifCount: 2
        }
    }

    Connections {
        target: Authentication

        function onAuthChanged() {
            if (Authentication.isAuthenticated) {
                var account = Authentication.getMinecraftProfile();
               btnAccount.accountName = account.username;
               btnAccount.imgUrl = account.avatar;
            } else {
                changeRoute("home")
            }
        }
    }
}
