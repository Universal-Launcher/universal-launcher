import QtQuick 2.15
import QtQuick.Controls 2.15
import "qrc:/qml/common/ui/"
import "."
import UniversalLauncher 1.0

Item{
    signal next()
    signal previous()

            Text{
                anchors {
                    top: parent.top
                    topMargin: 30
                    horizontalCenter: parent.horizontalCenter
                }
                id: jvd
                text: qsTr("Java Version Detected")
                font.pixelSize: 18
                font.capitalization: Font.AllUppercase
                color: AppGlobal.themes.current.textColor
            }

    ListView {
        id: list
        spacing: 15
        clip: true

        width: 340

        anchors {
            top: jvd.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 20
            bottomMargin: 20
            bottom: btnContainer.top
        }

        ListModel {
            id: java_model
            ListElement { name: "Java 17"; path: "/usr/bin/java/" }
            ListElement { name: "Java 11"; path: "/usr/bin/java/" }
            ListElement { name: "Java 8";  path: "/usr/bin/java/" }
            ListElement { name: "Java 6(mdrrr)";  path: "/usr/bin/java/" }            
            ListElement { name: "Java 4(Shallah sa existe)";  path: "/usr/bin/java/" }            
        }

        ScrollBar.vertical: UScrollBar {}

        Component {
            id: card
            Button {
                width: list.width
                height: 70
                background: Rectangle {
                    color: AppGlobal.themes.current.backgroundColor2
                    radius: 10
                }

                onClicked: list.currentIndex = index

                Text {
                    id: nameJava
                    text: name
                    color: AppGlobal.themes.current.accentColor
                    font.pixelSize: 15
                    anchors {
                        fill: parent
                        top: parent.top
                        topMargin: 10
                        left: parent.left
                        leftMargin: 30
                    }
                }

                Text {
                    id: pathJava
                    text: path
                    color: AppGlobal.themes.current.backgroundColor        
                    font.pixelSize: 11
                    font.italic: true
                    anchors {
                        fill: parent
                        top: nameJava.bottom
                        topMargin: 35
                        left: parent.left
                        leftMargin: 30
                    }
                }
            }
        }
    model: java_model
    delegate: card   
    }

    Item {
        id: btnContainer
        height: btnNext.height
        width: parent.width

        anchors {
            bottom: parent.bottom
        }

        UButton{
            btnText: qsTr("Add")
            iconPath: "/images/icons/plus-square.svg"
            anchors{
                bottom: list.bottom
                horizontalCenter: btnContainer.horizontalCenter
            }
            onClicked: {}
        }

        UButton {
            id: btnNext
            btnText: qsTr("Next")
            iconPath: "/images/icons/arrow-alt-circle-right.svg"
            onClicked: next()

            anchors {
                right: parent.right
                bottom: parent.bottom
            }
        }

        UButton {
            id: btnPrevious
            btnText: qsTr("Previous")
            iconPath: "/images/icons/arrow-alt-circle-left.svg"
            onClicked: previous()

            anchors {
                left: parent.left
                bottom: parent.bottom
            }
        }

     
    }
}

