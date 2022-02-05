import QtQuick 2.15
import QtQuick.Controls 2.15
import "qrc:/qml/main/components/"
import "qrc:/qml/main/components/ui/"
import "./components/"
import "."
import UniversalLauncher 1.0

Rectangle{
    id: s_java
    
    property StackView stack

            Text{
                id: setup
                text: "Setup"
                font.pixelSize: 35
                font.capitalization: Font.AllUppercase
                anchors.horizontalCenter: parent.horizontalCenter
                color: textBlueSpeColor
                y: 60
            }

            Text{
                id: jvd
                text: "Java Version Detected"
                font.pixelSize: 18
                font.capitalization: Font.AllUppercase
                x: 310
                color: "black"
                y: 145
            }

            UCard{
                id: cardOne
                anchors.horizontalCenter: parent.horizontalCenter
                y: 175
                pathName: "/usr/bin/java/"
                javaName: "JAVA 17"
                state: "selected"
                MouseArea {
                    id: co_ma
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        if(cardTwo.state == "selected") {
                            cardTwo.state = "default"
                            cardOne.state = "selected"
                        }
                        else if(cardThree.state == "selected") {
                            cardThree.state = "default"
                            cardOne.state = "selected"
                        }    
                    }
                }
            }


            UCard{
                id: cardTwo
                anchors.horizontalCenter: parent.horizontalCenter
                y: 250
                pathName: "/usr/bin/java/"
                javaName: "JAVA 11"
                MouseArea { 
                    id: ctw_ma
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        if(cardOne.state == "selected") {
                            cardOne.state = "default"
                            cardTwo.state = "selected"
                        }
                        else if(cardThree.state == "selected") {
                            cardThree.state = "default"
                            cardTwo.state = "selected"
                        }
                    }
                }
            }

            UCard{
                id: cardThree
                anchors.horizontalCenter: parent.horizontalCenter
                y: 325
                pathName: "/usr/bin/java/"
                javaName: "JAVA 8"
                MouseArea { 
                    id: cth_ma
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        if(cardOne.state == "selected") {
                            cardOne.state = "default"
                            cardThree.state = "selected"
                        }
                        else if(cardTwo.state == "selected") {
                            cardTwo.state = "default"
                            cardThree.state = "selected"
                        }    
                    }
                }
            }

        
            UButton{
                btnText: qsTr("Suivant")
                iconPath: "/images/icons/arrow-alt-circle-right.svg"
                onClicked: {
                                if(cardOne.state == "selected"){ stackView.replace(finish) }
                                else if(cardTwo.state == "selected") { stackView.replace(finish) }
                                else if(cardThree.state == "selected") { stackView.replace(finish) }
                            }
                x:800
                y:490
            }

            UButton{
                btnText: qsTr("Retour")
                iconPath: "/images/icons/arrow-alt-circle-left.svg"
                onClicked: stackView.replace(theme)
                x:20
                y:490
            }            
            
}
