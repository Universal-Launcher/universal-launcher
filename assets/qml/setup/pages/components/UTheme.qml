import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Rectangle {
    id: background

    width: 304
    height: 250
    radius: 10
    color: gray
    border.color: gray

    //white theme
    property bool whiteTheme: false
    property color specialBlue: "#374151"
    property color gray: "#E5E7EB"
    property color white: "#fff"
    property color orange: "#F97316"

    property color black: "#252525"
    property color dark: "#444444"

    property color darkPurple: "#411E6C"
    property color purple: "#5900CA"
    property color purpleTwo: "#270059"
    
    property color lightGray: "#BABABA"
    property string themeText: ""

    //dark theme
    property bool darkTheme: false

    //sephia
    property bool sepiaTheme: false

    property bool selected: false

    states: [
        State {
            name: "t_white"
            PropertyChanges { target: background; color: gray }
            PropertyChanges { target: background; border.color: gray }

            PropertyChanges { target: bottom; color: gray }

            PropertyChanges { target: header; color: white }
            PropertyChanges { target: titleFirst; color: specialBlue }
            PropertyChanges { target: titleSecond; color: specialBlue }
            PropertyChanges { target: separator; color: gray }
            PropertyChanges { target: homeSelect; color: white }
            PropertyChanges { target: iconHome; color: specialBlue }
            PropertyChanges { target: textHome; color: specialBlue }
            PropertyChanges { target: modpack; color: gray }
            PropertyChanges { target: iconModpack; color: orange }
            PropertyChanges { target: textModpack; color: orange }
            PropertyChanges { target: account; color: white }
            PropertyChanges { target: iconAccount; color: specialBlue }
            PropertyChanges { target: textAccount; color: specialBlue }
            PropertyChanges { target: settings; color: white }
            PropertyChanges { target: iconSettings; color: specialBlue }
            PropertyChanges { target: textSettings; color: specialBlue }

            PropertyChanges { target: titlePage; color: specialBlue }
            PropertyChanges { target: card1; color: gray }
            PropertyChanges { target: card2; color: gray }
            PropertyChanges { target: card3; color: gray }
            PropertyChanges { target: card4; color: gray }
            PropertyChanges { target: card5; color: gray }
            PropertyChanges { target: card6; color: gray }

            PropertyChanges { target: bottomText; color: specialBlue }            
        },
        State {
            name: "t_dark"
            PropertyChanges { target: background; color: gray }
            PropertyChanges { target: background; border.color: gray }

            PropertyChanges { target: bottom; color: gray }

            PropertyChanges { target: header; color: black }
            PropertyChanges { target: titleFirst; color: gray }
            PropertyChanges { target: titleSecond; color: gray }
            PropertyChanges { target: separator; color: dark }
            PropertyChanges { target: homeSelect; color: black }
            PropertyChanges { target: iconHome; color: gray }
            PropertyChanges { target: textHome; color: gray }
            PropertyChanges { target: modpack; color: dark }
            PropertyChanges { target: iconModpack; color: orange }
            PropertyChanges { target: textModpack; color: orange }
            PropertyChanges { target: account; color: black }
            PropertyChanges { target: iconAccount; color: gray }
            PropertyChanges { target: textAccount; color: gray }
            PropertyChanges { target: settings; color: black }
            PropertyChanges { target: iconSettings; color: gray }
            PropertyChanges { target: textSettings; color: gray }

            PropertyChanges { target: titlePage; color: gray }
            PropertyChanges { target: card1; color: gray }
            PropertyChanges { target: card2; color: gray }
            PropertyChanges { target: card3; color: gray }
            PropertyChanges { target: card4; color: gray }
            PropertyChanges { target: card5; color: gray }
            PropertyChanges { target: card6; color: gray }

            PropertyChanges { target: bottomText; color: specialBlue }
        },
        State {
            name: "t_sepia"
            PropertyChanges { target: background; color: white }
            PropertyChanges { target: background; border.color: white }

            PropertyChanges { target: bottom; color: white }

            PropertyChanges { target: header; color: darkPurple }
            PropertyChanges { target: titleFirst; color: lightGray }
            PropertyChanges { target: titleSecond; color: lightGray }
            PropertyChanges { target: separator; color: purple }
            PropertyChanges { target: homeSelect; color: darkPurple }
            PropertyChanges { target: iconHome; color: lightGray }
            PropertyChanges { target: textHome; color: lightGray }
            PropertyChanges { target: modpack; color: purple }
            PropertyChanges { target: iconModpack; color: purpleTwo }
            PropertyChanges { target: textModpack; color: purpleTwo }
            PropertyChanges { target: account; color: darkPurple }
            PropertyChanges { target: iconAccount; color: lightGray }
            PropertyChanges { target: textAccount; color: lightGray }
            PropertyChanges { target: settings; color: darkPurple }
            PropertyChanges { target: iconSettings; color: lightGray }
            PropertyChanges { target: textSettings; color: lightGray }

            PropertyChanges { target: titlePage; color: lightGray }
            PropertyChanges { target: card1; color: lightGray }
            PropertyChanges { target: card2; color: lightGray }
            PropertyChanges { target: card3; color: lightGray }
            PropertyChanges { target: card4; color: lightGray }
            PropertyChanges { target: card5; color: lightGray }
            PropertyChanges { target: card6; color: lightGray }

            PropertyChanges { target: bottomText; color: specialBlue }
        }             
    ]

    Component.onCompleted: { 
        if(whiteTheme == true){
            state = "t_white"
        }
        if(darkTheme == true){
            state = "t_dark"
        }
        if(sepiaTheme == true){
            state = "t_sepia"
        }
    }

    Item{
        id: group
        anchors.fill: background
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: background
        }

        Rectangle {
            id: header
            width: 300
            height: 200
            anchors.horizontalCenter: parent.horizontalCenter
            y: 2
            radius: 10

            Rectangle{
                id: titleFirst
                width: 40
                height: 7
                radius: 10
                x: 10
                y: 10
            }

            Rectangle{
                id: titleSecond
                width: 40
                height: 7
                radius: 10
                x: 10
                y: 20
            }

            Rectangle{
                id: homeSelect
                width: 60
                height: 20
                radius: 5
                x: 12
                y: 50
                Rectangle {
                    id: iconHome
                    width: 10
                    height: 10
                    radius: 5
                    x: 5
                    anchors.verticalCenter: homeSelect.verticalCenter
                }

                Rectangle {
                    id: textHome
                    width: 20
                    height: 7
                    radius: 5
                    x: 20
                    anchors.verticalCenter: homeSelect.verticalCenter
                }
            }

            Rectangle{
                id: modpack
                width: 60
                height: 20
                radius: 5
                x: 12
                y: 70
                Rectangle {
                    id: iconModpack
                    width: 10
                    height: 10
                    radius: 5
                    x: 5
                    anchors.verticalCenter: modpack.verticalCenter
                }

                Rectangle {
                    id: textModpack
                    width: 20
                    height: 7
                    radius: 5
                    x: 20
                    anchors.verticalCenter: modpack.verticalCenter
                }
            }

            Rectangle{
                id: account
                width: 60
                height: 20
                radius: 5
                x: 12
                y: 130
                Rectangle {
                    id: iconAccount
                    width: 10
                    height: 10
                    radius: 5
                    x: 5
                    anchors.verticalCenter: account.verticalCenter
                }

                Rectangle {
                    id: textAccount
                    width: 20
                    height: 7
                    radius: 5
                    x: 20
                    anchors.verticalCenter: account.verticalCenter
                }
            }

            Rectangle{
                id: settings
                width: 60
                height: 20
                radius: 5
                x: 12
                y: 145
                Rectangle {
                    id: iconSettings
                    width: 10
                    height: 10
                    radius: 5
                    x: 5
                    anchors.verticalCenter: settings.verticalCenter
                }

                Rectangle {
                    id: textSettings
                    width: 20
                    height: 7
                    radius: 5
                    x: 20
                    anchors.verticalCenter: settings.verticalCenter
                }
            }

            Rectangle{
                id: separator
                width: 2
                height: 160
                x: 80
                y: 10
            }

            Rectangle{
                id: titlePage
                width: 40
                height: 7
                radius: 10
                x: 90
                y: 15
            }

            Rectangle{
                id: card1
                width: 50
                height: 35
                radius: 10
                x: 100
                y: 35
            }

            Rectangle{
                id: card2
                width: 50
                height: 35
                radius: 10
                x: 160
                y: 35
            }
            Rectangle{
                id: card3
                width: 50
                height: 35
                radius: 10
                x: 220
                y: 35
            }

            Rectangle{
                id: card4
                width: 50
                height: 35
                radius: 10
                x: 100
                y: 95
            }

            Rectangle{
                id: card5
                width: 50
                height: 35
                radius: 10
                x: 160
                y: 95
            }

            Rectangle{
                id: card6
                width: 50
                height: 35
                radius: 10
                x: 220
                y: 95
            }
        }
    }

        Rectangle {
            id: bottom
            width: 300
            height: 68
            anchors.horizontalCenter: parent.horizontalCenter
            y: 180
            Text{
                id: bottomText
                anchors.horizontalCenter: bottom.horizontalCenter
                anchors.verticalCenter: bottom.verticalCenter
                text: themeText
                font.pixelSize: 15
            }
        }

} 
