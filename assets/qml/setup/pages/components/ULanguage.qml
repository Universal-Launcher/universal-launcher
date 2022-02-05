import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import UniversalLauncher 1.0
Rectangle {
    id: back

    property bool selected: false

    property url backgroundPath: ""

    property string mName: ""

    width: 250
    height: 180
    radius: 5
    color: AppGlobal.themes.current.backgroundColor2

    Rectangle{
        id: forRadius
        width: 240
        height: 170
        color: AppGlobal.themes.current.backgroundColor2
        radius: 5
        x:5
        y:5
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
                height: 50
                
                color: AppGlobal.themes.current.backgroundColor2

                Text{
                    id: nameM
                    y: 12
                    x: 68
                    text: mName
                    color: AppGlobal.themes.current.textColor
                    anchors.horizontalCenter: bottom.horizontalCenter
                    font.pixelSize: 15
                }
            }   
        }
    }
} 
