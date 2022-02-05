import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Rectangle {
    id: back

    property color bgColor: "#fff"
    property color textTitleColor: "#000"
    property color textBlueSpeColor: "#374151"
    property color borderColor: "#E5E7EB"

    property bool selected: false

    property url backgroundPath: ""

    property string mName: ""

    width: 250
    height: 180
    radius: 5
    color: "#E5E7EB"

    Rectangle{
        id: forRadius
        width: 240
        height: 170
        x: 5
        y: 5
        color: borderColor
        radius: 5
        Item{
            id: base
            anchors.fill: forRadius
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: forRadius
            }
            Rectangle{
                id: img
                width: 240
                height: 130
                Image{
                    id: backImage
                    source: backgroundPath
                    fillMode: Image.PreserveAspectFit
                    sourceSize.width: 240
                    sourceSize.height: 110

                }
            }

            Rectangle{
                id: bottom
                width: 240
                y: 130
                height: 40
                
                color: borderColor

                Text{
                    id: nameM
                    y: 10
                    x: 68
                    text: mName
                    font.pixelSize: 15
                }
            }   
        }
    }
} 
