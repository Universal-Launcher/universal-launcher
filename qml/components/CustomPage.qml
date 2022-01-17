import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    id: page
    background: Rectangle {
        color: "transparent"
    }

    required property string pageTitle

    Text {
        id: title
        text: pageTitle
        font.pixelSize: 25
        color: "white"
        font.capitalization: Font.AllUppercase
    }
}
