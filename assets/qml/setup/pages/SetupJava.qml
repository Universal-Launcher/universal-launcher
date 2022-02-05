import QtQuick 2.15
import QtQuick.Controls 2.15
import "qrc:/qml/main/components/"
import "qrc:/qml/main/components/ui/"
import "./components/"
import "."
import UniversalLauncher 1.0

CustomPage{
    id: home
    
    property StackView stack

    pageTitle: ""
            Image{
                id: logo
                x: 17
                y: 10
                width: 96
                height: 96
                source: "/images/icons/logo.png"
            }
            Text{
                id: title
                text: "Universal Launcher"
                width: 120
                height: 100
                font.bold: true
                font.pixelSize: 20
                font.capitalization: Font.AllUppercase
                wrapMode: Text.Wrap
                x: 130
                y: 25
            }

            Text{
                id: setup
                text: "Setup"
                font.pixelSize: 35
                font.capitalization: Font.AllUppercase
                anchors.horizontalCenter: parent.horizontalCenter
                color: textBlueSpeColor
                y: 110
            }

            Text{
                id: jvd
                text: "Java Version Detected"
                font.pixelSize: 18
                font.capitalization: Font.AllUppercase
                x: 310
                color: "black"
                y: 190
            }

            UCard{
                id: cardOne
                anchors.horizontalCenter: parent.horizontalCenter
                y: 235
                pathName: "/usr/bin/java/"
                javaName: "JAVA 17"
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
                        } else {
                            cardOne.state = "selected"
                        }
                    }
                }
            }


            UCard{
                id: cardTwo
                anchors.horizontalCenter: parent.horizontalCenter
                y: 310
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
                        } else {
                            cardTwo.state = "selected"
                        }
                    }
                }
            }

            UCard{
                id: cardThree
                anchors.horizontalCenter: parent.horizontalCenter
                y: 385
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
                        } else {
                            cardThree.state = "selected"
                        }
                    }
                }
            }

            
            UButton{
                btnText: qsTr("Suivant")
                iconPath: "/images/icons/arrow-alt-circle-right.svg"
                onClicked: stackView.replace(finish)
                x:800
                y:590
            }


        SetupFinish{
            visible:false
            id: finish
            anchors.fill: parent
        }
}

