import QtQuick 2.15
import QtQuick.Controls 2.15
import "qrc:/qml/main/components/"
import "qrc:/qml/main/components/ui/"
import UniversalLauncher 1.0

CustomPage{
    id: finish

    pageTitle: ""
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
                x: 130
                y: 25
            }

            Text{
                id: setup
                text: "Setup"
                font.pixelSize: 35
                font.capitalization: Font.AllUppercase
                anchors.horizontalCenter: parent.horizontalCenter
                color: textBlueSpeColor
                y: 140
            }

            //Configuration terminée... Bon jeu !
            
            Text{
                id: text
                text: "Configuration terminée... Bon jeu !"
                font.pixelSize: 25
                font.capitalization: Font.AllUppercase
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#B5B7BE"
                y: 220
            }

            UButton{
                btnText: qsTr("Finish")
                iconPath: "/images/icons/arrow-alt-circle-right.svg"
                onClicked: console.log("finito pipo")
                x:800
                y:590
            }

}
