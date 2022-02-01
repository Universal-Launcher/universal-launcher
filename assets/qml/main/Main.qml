import QtQuick 2.15
import QtQuick.Controls 2.15
import "components/navigation"

Page {
    id: main

    background: Rectangle {
        color: "white"
        anchors.fill: parent
    }


    Sidebar {
        id: sidebar
        currentRoute: "home"
        onRouteChanged: showPage(sidebar.currentRoute)
    }

    function showPage(route) {
        switch(sidebar.currentRoute) {
            case "home": stackView.replace(Qt.resolvedUrl("/qml/main/pages/HomePage.qml")); break;
            case "modpacks": stackView.replace(Qt.resolvedUrl("/qml/main/pages/ModpacksPage.qml")); break;
            case "account": stackView.replace(Qt.resolvedUrl("/qml/main/pages/AccountPage.qml")); break;
            case "settings": stackView.replace(Qt.resolvedUrl("/qml/main/pages/SettingsPage.qml")); break;
        }
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

            Component.onCompleted: showPage("home")
        }
    }
}