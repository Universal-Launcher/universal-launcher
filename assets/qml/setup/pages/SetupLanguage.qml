import QtQuick 2.15
import QtQuick.Controls 2.15
import "qrc:/qml/main/components/"
import "qrc:/qml/main/components/ui/"
import "./components/"
import "."
import UniversalLauncher 1.0

Rectangle{
    property StackView stack

    id: back
    width: parent.width
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
        text: "Langue"
        font.pixelSize: 35
        font.capitalization: Font.AllUppercase
        anchors.horizontalCenter: parent.horizontalCenter
        color: textBlueSpeColor
        y: 170
    }

    Row{
        spacing: 30
        anchors.horizontalCenter: parent.horizontalCenter

        y: 250

        Rectangle{
            id: back_fr_card
            width: 252
            height: 182
            radius: 5
            color: "#E5E7EB"
            ULanguage{
                id: fr_card
                backgroundPath: "/images/background/fr_flag.jpg"
                mName: "Français"
                x: 1
                y: 1
                MouseArea {
                    id: fr_card_area
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        if(en_card.selected == true){
                            back_en_card.color = '#E5E7EB'
                            back_fr_card.color = '#F97316'
                            en_card.selected = false;
                            fr_card.selected = true;
                        } else {
                            back_fr_card.color = '#F97316'
                            fr_card.selected = true;
                        }
                    }
                }
            }
        }

        Rectangle{
            id: back_en_card
            width: 252
            height: 182
            radius: 5
            color: "#E5E7EB"
            ULanguage{
                id: en_card
                backgroundPath: "/images/background/en_flag.png"
                mName: "Anglais"
                x: 1
                y: 1
                MouseArea {
                    id: en_card_area
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        if(fr_card.selected == true){
                            back_en_card.color = '#F97316'
                            back_fr_card.color = '#E5E7EB'
                            en_card.selected = true;
                            fr_card.selected = false;
                        } else {
                            back_en_card.color = '#F97316'
                            en_card.selected = true;
                        }
                    }
                }
            }
        }
                
    }
    
    UButton{
        btnText: qsTr("Suivant")
        iconPath: "/images/icons/arrow-alt-circle-right.svg"
        onClicked: stackView.replace(theme)
        x:800
        y:590
    }

    SetupTheme{
        visible:false
        id: theme
        anchors.fill: parent
    }

}