import QtQuick 2.15
import QtQuick.Controls 2.15
import "./pages"
import UniversalLauncher 1.0

Page {
    id: lang
    Rectangle {
        id: contentPane
        anchors.fill: parent
        color: AppGlobal.themes.current.backgroundColor
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            left: parent.left
            margins: 0
        }
        Image{
            id: logo
            x: 17
            y: 10
            width: 96
            height: 96
            source: "/images/icons/logo.png"
        }
        Text{
            id: title
            text: "Universal Launcher"
            width: 120
            height: 100
            font.bold: true
            font.pixelSize: 20
            font.capitalization: Font.AllUppercase
            wrapMode: Text.Wrap
            color: AppGlobal.themes.current.textColor
            x: 130
            y: 25
        }

        Rectangle{
            id: stack
            width: 960
            height: 540
            y: 100
        }
    
        StackView {
            id: stackView
            anchors {
                fill: stack
                margins: 0
            }
            clip: true
            
            initialItem: "pages/SetupLanguage.qml"      
        }
    }
}
