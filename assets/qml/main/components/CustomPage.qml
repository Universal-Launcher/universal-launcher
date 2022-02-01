import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    id: page

    property alias children: content.children
    required property string pageTitle

    background: Rectangle {
        color: "transparent"
    }

    Text {
        id: title
        text: pageTitle
        font.pixelSize: 25
        color: "#0F172A"
        font.capitalization: Font.AllUppercase
    }

    Item {
        id: content
        anchors.fill: parent
        anchors.top: title.bottom
    }
}