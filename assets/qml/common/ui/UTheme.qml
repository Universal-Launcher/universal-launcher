import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.14
import QtGraphicalEffects 1.15
import UniversalLauncher 1.0

Rectangle {
    id: background

    width: 200
    height: 134
    radius: AppGlobal.themes.current.radius
    color: AppGlobal.themes.current.backgroundColor2
    border.color: AppGlobal.themes.current.backgroundColor2

    required property string name

    Item {
        id: group
        anchors{
            fill: background
        }
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: background
        }

        Rectangle {
            anchors{
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 2
            }
            id: header
            width: 196
            height: 110
            radius: AppGlobal.themes.current.radius
            color: AppGlobal.themes.getTheme(name).backgroundColor
        }

        Rectangle{
            id: titleFirst
            anchors {
                top: header.top
                topMargin: 7
                left: header.left
                leftMargin: 8
            }
            width: 25
            height: 6
            radius: AppGlobal.themes.getTheme(name).radius
            color: AppGlobal.themes.getTheme(name).textColor
        }

        Rectangle{
            anchors {
                top: header.top
                topMargin: 15
                left: header.left
                leftMargin: 8
            }
            id: titleSecond
            width: 25
            height: 6
            radius: AppGlobal.themes.getTheme(name).radius
            color: AppGlobal.themes.getTheme(name).textColor
        }

        Column{
            id: buttonHM
            width: 55
            anchors {
                top: titleSecond.bottom
                topMargin: 10
                left: header.left
                leftMargin: 8
            }
            spacing: 2
            Rectangle{
                id: homeSelect
                width: 35
                height: 10
                radius: AppGlobal.themes.getTheme(name).minRadius
                color: AppGlobal.themes.getTheme(name).backgroundColor2
                Rectangle {
                    id: iconHome
                    width: 5
                    height: 5
                    radius: 5
                    color: AppGlobal.themes.getTheme(name).accentColor
                    anchors {
                        left: homeSelect.left
                        leftMargin: 5
                        verticalCenter: homeSelect.verticalCenter
                    }
                }

                Rectangle {
                    id: textHome
                    width: 14
                    height: 5
                    radius: 5
                    color: AppGlobal.themes.getTheme(name).accentColor
                    anchors {
                        left: homeSelect.left
                        leftMargin: 13
                        verticalCenter: homeSelect.verticalCenter
                    }
                }
            }

            Rectangle{
                id: modpack
                width: 35
                height: 10
                radius: AppGlobal.themes.getTheme(name).minRadius
                color: AppGlobal.themes.getTheme(name).backgroundColor
                Rectangle {
                    id: iconModpack
                    width: 5
                    height: 5
                    radius: 5
                    color: AppGlobal.themes.getTheme(name).textColor
                    anchors {
                        left: modpack.left
                        leftMargin: 5
                        verticalCenter: modpack.verticalCenter
                    }
                }

                Rectangle {
                    id: textModpack
                    width: 14
                    height: 5
                    radius: 5
                    color: AppGlobal.themes.getTheme(name).textColor
                    anchors {
                        left: modpack.left
                        leftMargin: 13
                        verticalCenter: modpack.verticalCenter
                    }
                }
            }
        }


        Column{
            id: buttonAS
            width: 55            
            anchors {
                top: buttonHM.bottom
                topMargin: 20
                left: header.left
                leftMargin: 8
            }

            Rectangle{
                id: accounts
                width: 35
                height: 10
                radius: AppGlobal.themes.getTheme(name).minRadius
                color: AppGlobal.themes.getTheme(name).backgroundColor
                Rectangle {
                    id: iconAccounts
                    width: 5
                    height: 5
                    radius: 5
                    color: AppGlobal.themes.getTheme(name).textColor
                    anchors {
                        left: accounts.left
                        leftMargin: 5
                        verticalCenter: accounts.verticalCenter
                    }
                }

                Rectangle {
                    id: textAccounts
                    width: 14
                    height: 5
                    radius: 5
                    color: AppGlobal.themes.getTheme(name).textColor
                    anchors {
                        left: accounts.left
                        leftMargin: 13
                        verticalCenter: accounts.verticalCenter
                    }
                }
            }

            Rectangle{
                id: settings
                width: 35
                height: 10
                radius: AppGlobal.themes.getTheme(name).minRadius
                color: AppGlobal.themes.getTheme(name).backgroundColor
                Rectangle {
                    id: iconSettings
                    width: 5
                    height: 5
                    radius: 5
                    color: AppGlobal.themes.getTheme(name).textColor
                    anchors {
                        left: settings.left
                        leftMargin: 5
                        verticalCenter: settings.verticalCenter
                    }
                }

                Rectangle {
                    id: textSettings
                    width: 14
                    height: 5
                    radius: 5
                    color: AppGlobal.themes.getTheme(name).textColor
                    anchors {
                        left: settings.left
                        leftMargin: 13
                        verticalCenter: settings.verticalCenter
                    }
                }
            }
        }

        Rectangle{
            id: separator
            width: 1
            color: AppGlobal.themes.getTheme(name).backgroundColor2
            anchors {
                left: parent.left
                leftMargin: 55
                top: parent.top
                topMargin: 9
                bottom: parent.bottom
                bottomMargin: 42
            }
        }

        Rectangle{
                id: titlePage
                anchors {
                    top: parent.top
                    topMargin: 12
                    left: separator.left
                    leftMargin: 10
                }
                width: 20
                height: 7
                color: AppGlobal.themes.getTheme(name).textColor
                radius: AppGlobal.themes.getTheme(name).radius
        }

        Rectangle{
            id: c1
            anchors {
                top: parent.top
                topMargin: 30
                left: separator.right
                leftMargin: 15
            }
            color: AppGlobal.themes.getTheme(name).backgroundColor2
            width: 30
            height: 20
            radius: AppGlobal.themes.getTheme(name).minRadius
        }

        Rectangle{
            id: c2
            anchors {
                top: parent.top
                topMargin: 30
                left: c1.right
                leftMargin: 10
            }
            color: AppGlobal.themes.getTheme(name).backgroundColor2
            width: 30
            height: 20
            radius: AppGlobal.themes.getTheme(name).minRadius
        }

        Rectangle{
            id: c3
            anchors {
                top: parent.top
                topMargin: 30
                left: c2.right
                leftMargin: 10
            }
            color: AppGlobal.themes.getTheme(name).backgroundColor2
            width: 30
            height: 20
            radius: AppGlobal.themes.getTheme(name).minRadius
        }

        Rectangle{
            id: c4
            anchors {
                top: c1.top
                topMargin: 30
                left: separator.right
                leftMargin: 15
            }
            color: AppGlobal.themes.getTheme(name).backgroundColor2
            width: 30
            height: 20
            radius: AppGlobal.themes.getTheme(name).minRadius
        }

        Rectangle{
            id: c5
            anchors {
                top: c2.top
                topMargin: 30
                left: c4.right
                leftMargin: 10
            }
            color: AppGlobal.themes.getTheme(name).backgroundColor2
            width: 30
            height: 20
            radius: AppGlobal.themes.getTheme(name).minRadius
        }

        Rectangle{
            id: c6
            anchors {
                top: c3.top
                topMargin: 30
                left: c5.right
                leftMargin: 10
            }
            color: AppGlobal.themes.getTheme(name).backgroundColor2
            width: 30
            height: 20
            radius: AppGlobal.themes.getTheme(name).minRadius
        }


        Rectangle {
            id: bottom
            width: 200
            height: 35
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            Text{
                id: bottomText
                anchors.horizontalCenter: bottom.horizontalCenter
                anchors.verticalCenter: bottom.verticalCenter
                text: name
                font.capitalization: Font.Capitalize
                font.pixelSize: 15
            }
            color: AppGlobal.themes.current.backgroundColor2
        }
    }    
} 
