import QtQuick 2.15
import QtQuick.Controls 2.15
import "./pages"
import UniversalLauncher 1.0

Page {
    id: lang
    property color textBlueSpeColor: "#374151"

    Rectangle {
        id: contentPane
        anchors.fill: parent
        color: "white"
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            left: parent.left
            margins: 0
        }
    
        StackView {
            id: stackView
            anchors {
                fill: parent
                margins: 0
            }
            clip: true
            
            initialItem: language

            replaceEnter: Transition {
                PropertyAnimation {
                    properties: "opacity"
                    from: 0
                    to: 1
                    duration: 400
                }
            }

            replaceExit: Transition {
                PropertyAnimation {
                    properties: "opacity"
                    from: 1
                    to: 0
                    duration: 400
                }
            }

            SetupLanguage{
                id: language
                anchors.fill: parent
            }
            
        }
    }
}
