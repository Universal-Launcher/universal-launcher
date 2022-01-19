import QtQuick 2.15
import QtQuick.Controls 2.15
import "components/navigation"

Page {
    id: main

    background: Rectangle {
        color: "#374151"
        anchors.fill: parent
    }

    function showPage(route) {
        switch(sidebar.currentRoute) {
            case "home": stackView.replace(Qt.resolvedUrl("/qml/pages/homePage.qml")); break;
            case "modpacks": stackView.replace(Qt.resolvedUrl("/qml/pages/modpacksPage.qml")); break;
            case "account": stackView.replace(Qt.resolvedUrl("/qml/pages/accountPage.qml")); break;
            case "settings": stackView.replace(Qt.resolvedUrl("/qml/pages/settingsPage.qml")); break;
        }
    }

    Sidebar {
        id: sidebar
        currentRoute: "home"
        onRouteChanged: showPage(sidebar.currentRoute)
    }

    Rectangle {
        id: contentPage
        color: "#0F172A"
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            left: sidebar.right
            margins: 0
        }
        clip: true

        StackView {
            id: stackView
            anchors {
                fill: parent
                margins: 20
            }

            replaceEnter: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 0
                    to:1
                    duration: 200
                }
            }
            replaceExit: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 1
                    to:0
                    duration: 200
                }
            }

            Component.onCompleted: showPage("home")
        }
    }
}
