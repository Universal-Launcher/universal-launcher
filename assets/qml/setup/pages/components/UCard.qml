import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Rectangle{
    id: background

    property color gray: "#C4C4C4"
    property color select: "#F97316"
    property string pathName: ""
    property string javaName: ""

    width: 340
    height: 70
    color: gray
    radius: 5

    states: [
        State {
            name: "selected"
            PropertyChanges { target: background; border.color: select}
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
        font.pixelSize: 15
    }
 
    Text{
        id: path
        text: pathName
        x: 30
        y: 42
        font.pixelSize: 11
        font.italic: true
    }
}