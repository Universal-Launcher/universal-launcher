import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: page

    property alias content: content.children
    required property string pageTitle

    Text {
        id: title
        text: pageTitle
        font.pixelSize: 25
        color: "#0F172A"
        font.capitalization: Font.AllUppercase
    }

    Item {
        id: content
        anchors{
            top: title.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
    }
}