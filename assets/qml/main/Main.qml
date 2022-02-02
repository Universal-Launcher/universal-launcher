import QtQuick 2.15
import QtQuick.Controls 2.15
import "components/navigation"
import UniversalLauncher 1.0

Page {
    id: main

    background: Rectangle {
        color: "white"
        anchors.fill: parent
    }

    Sidebar {
        id: sidebar
    }

    Rectangle {
        id: contentPane
        color: "transparent"
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            left: sidebar.right
            margins: 0
        }
    
        StackView {
            id: stackView
            anchors {
                fill: parent
                margins: 20
            }
            clip: true
            
            replaceEnter: Transition {
                PropertyAnimation {
                    properties: "opacity"
                    from: 0
                    to: 1
                    duration: 200
                }
            }

            replaceExit: Transition {
                PropertyAnimation {
                    properties: "opacity"
                    from: 1
                    to: 0
                    duration: 200
                }
            }
        }
    }

    Connections {
        target: AppGlobal.router

        function onRouteChanged(route) {
            stackView.replace(Qt.resolvedUrl(AppGlobal.router.currentRoute))
        }
    }

    Component.onCompleted: function() {
        AppGlobal.router.registerRoute("home", "/qml/main/pages/HomePage.qml")
        AppGlobal.router.registerRoute("modpacks", "/qml/main/pages/ModpacksPage.qml")
        AppGlobal.router.registerRoute("settings", "/qml/main/pages/SettingsPage.qml")
        AppGlobal.router.registerRoute("accounts", "/qml/main/pages/AccountsPage.qml")

        AppGlobal.router.goTo("home")
    }
}
