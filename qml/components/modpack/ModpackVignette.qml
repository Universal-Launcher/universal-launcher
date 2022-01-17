import QtQuick 2.0

Rectangle {
    color: "blue"

    anchors.fill: parent
    radius: 16

    required property string name

    Text {
        text: name
    }
}
