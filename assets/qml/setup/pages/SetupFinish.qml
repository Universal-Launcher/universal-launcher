import QtQuick 2.15
import QtQuick.Controls 2.15
import "qrc:/qml/main/components/"
import "qrc:/qml/main/components/ui/"
import UniversalLauncher 1.0

Rectangle{
    id: finish

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
                id: btn
                btnText: qsTr("Finish")
                iconPath: "/images/icons/arrow-alt-circle-right.svg"
                onClicked: {
                    console.log("fin")
                }
                x:800
                y:490
            }


            UButton{
                btnText: qsTr("Retour")
                iconPath: "/images/icons/arrow-alt-circle-left.svg"
                onClicked: stackView.pop("SetupJava.qml")
                x:20
                y:490
            }
}
