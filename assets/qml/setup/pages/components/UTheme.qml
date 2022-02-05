import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import UniversalLauncher 1.0

Rectangle {
    id: background

    width: 254
    height: 220
    radius: 10
    color: AppGlobal.themes.current.backgroundColor2
    border.color: AppGlobal.themes.current.backgroundColor2

    //white theme
    property bool whiteTheme: false
    property color specialBlue: "#374151"
    property color gray: "#E5E7EB"
    property color white: "#fff"
    property color orange: "#F97316"

    property color black: "#252525"
    property color dark: "#444444"

    property color sepia_background: "#EAD09E"
    property color sepia_background2: "#D7A575"
    property color sepia_accent: "#B59860"
    property color sepia_text: "#FFEBC9"

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
            PropertyChanges { target: background; color: AppGlobal.themes.current.backgroundColor2 }
            PropertyChanges { target: background; border.color: AppGlobal.themes.current.backgroundColor2 }

            PropertyChanges { target: bottom; color: AppGlobal.themes.current.backgroundColor2 }

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

            PropertyChanges { target: bottomText; color: AppGlobal.themes.current.textColor }            
        },
        State {
            name: "t_dark"
            PropertyChanges { target: background; color: AppGlobal.themes.current.backgroundColor2 }
            PropertyChanges { target: background; border.color: AppGlobal.themes.current.backgroundColor2 }

            PropertyChanges { target: bottom; color: AppGlobal.themes.current.backgroundColor2 }

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

            PropertyChanges { target: bottomText; color: AppGlobal.themes.current.textColor }
        },
        State {
            name: "t_sepia"
            PropertyChanges { target: background; color: AppGlobal.themes.current.backgroundColor2 }
            PropertyChanges { target: background; border.color: AppGlobal.themes.current.backgroundColor2 }

            PropertyChanges { target: bottom; color: AppGlobal.themes.current.backgroundColor2 }

            PropertyChanges { target: header; color: sepia_background }
            PropertyChanges { target: titleFirst; color: sepia_text }
            PropertyChanges { target: titleSecond; color: sepia_text }
            PropertyChanges { target: separator; color: sepia_background }
            PropertyChanges { target: homeSelect; color: sepia_background }
            PropertyChanges { target: iconHome; color: sepia_text }
            PropertyChanges { target: textHome; color: sepia_text }
            PropertyChanges { target: modpack; color: sepia_background2 }
            PropertyChanges { target: iconModpack; color: sepia_accent }
            PropertyChanges { target: textModpack; color: sepia_accent }
            PropertyChanges { target: account; color: sepia_background }
            PropertyChanges { target: iconAccount; color: sepia_text }
            PropertyChanges { target: textAccount; color: sepia_text }
            PropertyChanges { target: settings; color: sepia_background }
            PropertyChanges { target: iconSettings; color: sepia_text }
            PropertyChanges { target: textSettings; color: sepia_text }

            PropertyChanges { target: titlePage; color: sepia_text }
            PropertyChanges { target: card1; color: sepia_background2 }
            PropertyChanges { target: card2; color: sepia_background2 }
            PropertyChanges { target: card3; color: sepia_background2 }
            PropertyChanges { target: card4; color: sepia_background2 }
            PropertyChanges { target: card5; color: sepia_background2 }
            PropertyChanges { target: card6; color: sepia_background2 }

            PropertyChanges { target: bottomText; color: AppGlobal.themes.current.textColor }   
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
            width: 250
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
                width: 45
                height: 30
                radius: 10
                x: 92
                y: 45
            }

            Rectangle{
                id: card2
                width: 45
                height: 30
                radius: 10
                x: 145
                y: 45
            }
            Rectangle{
                id: card3
                width: 45
                height: 30
                radius: 10
                x: 198
                y: 45
            }

            Rectangle{
                id: card4
                width: 45
                height: 30
                radius: 10
                x: 92
                y: 95
            }

            Rectangle{
                id: card5
                width: 45
                height: 30
                radius: 10
                x: 145
                y: 95
            }

            Rectangle{
                id: card6
                width: 45
                height: 30
                radius: 10
                x: 198
                y: 95
            }
        }
    }

        Rectangle {
            id: bottom
            width: 250
            height: 33
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
