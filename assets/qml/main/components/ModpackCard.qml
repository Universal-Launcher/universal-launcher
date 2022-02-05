import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15


Rectangle {
    id: background

    property color bgColor: "#fff"
    property color textTitleColor: "#000"
    property color textBlueSpeColor: "#374151"
    property color borderColor: "#E5E7EB"

    property url backgroundPath: ""

    property url mIcon: ""
    property int mIconWidth: 50
    property int mIconHeight: 50

    property string mName: ""
    property string mVersion: ""
    property string mText: ""

    width: 260
    height: 200
    radius: 10
    border.width: 1
    border.color: borderColor

    Item{
        id: base
        anchors.fill: background
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: background
        }
        Rectangle{
            id: img
            width: 258
            height: 89
            y: 1
            x:1 
            Image{
                id: backImage
                source: backgroundPath
                fillMode: Image.PreserveAspectFit
                sourceSize.width: 258
                sourceSize.height: 89

            }
        }

        Rectangle{
            id: bottom
            width: 258
            y: 89
            x: 1
            height: 100
            
            color: "white"

            Text{
                id: nameM
                y: 10
                x: 70
                text: mName
                font.pixelSize: 15
            }

            Text{
                id: versionM
                y: 13
                x: 225
                text: mVersion
                font.pixelSize: 10
                font.italic: true
                color: textBlueSpeColor
            }

            Text{
                id: test
                width: 180
                height: 70
                y: 35
                x: 70
                text: mText
                font.pixelSize: 10
                font.italic: false
                color: textBlueSpeColor
                wrapMode: Text.Wrap
            }

            Image{
                id: logo
                source: mIcon
                fillMode: Image.PreserveAspectFit
                sourceSize.width: mIconWidth
                sourceSize.height: mIconHeight
                x: 8
                y: 30
            }
        }
    }
} 
