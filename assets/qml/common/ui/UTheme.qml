import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import UniversalLauncher 1.0

Rectangle {
    id: background

    width: 200
    height: 134
    radius: 10
    color: AppGlobal.themes.current.backgroundColor2
    border.color: AppGlobal.themes.current.backgroundColor2

    required property string name
    signal clicked()


    Item {
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
            text: name
            font.pixelSize: 15
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: clicked()
        cursorShape: Qt.PointingHandCursor
    }
} 
