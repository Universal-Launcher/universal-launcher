import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import UniversalLauncher 1.0

Rectangle{
    id: background

    property string pathName: ""
    property string javaName: ""
    width: 340
    height: 70
    color: AppGlobal.themes.current.backgroundColor2
    radius: 10

    states: [
        State {
            name: "selected"
            PropertyChanges { target: background; border.color: AppGlobal.themes.current.textColor}
        },
        State {
            name: "default"
            PropertyChanges { target: background; border.color: "transparent"}
        }

    ]
    
    Text{
        id: java
        text: javaName
        x: 30
        y: 15
        color: AppGlobal.themes.current.backgroundColor        
        font.pixelSize: 15
    }
 
    Text{
        id: path
        text: pathName
        x: 30
        y: 42
        color: AppGlobal.themes.current.backgroundColor        
        font.pixelSize: 11
        font.italic: true
    }
}