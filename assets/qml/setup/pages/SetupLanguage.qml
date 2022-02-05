import QtQuick 2.15
import QtQuick.Controls 2.15
import "qrc:/qml/main/components/"
import "qrc:/qml/main/components/ui/"
import "./components/"
import "."
import UniversalLauncher 1.0

Rectangle{
    property StackView stack
    color: AppGlobal.themes.current.backgroundColor
    id: back

    Text{
        id: setup
        text: "Setup"
        font.pixelSize: 35
        font.capitalization: Font.AllUppercase
        anchors.horizontalCenter: parent.horizontalCenter
        color: AppGlobal.themes.current.textColor
        y: 60
    }

    Text{
        id: text
        text: "Select Langue"
        font.pixelSize: 18
        font.capitalization: Font.AllUppercase
        x: 225
        color: AppGlobal.themes.current.textColor
        y: 145
    }

    Row{
        spacing: 30
        anchors.horizontalCenter: parent.horizontalCenter
        y: 185

        Rectangle{
            id: back_fr_card
            width: 252
            height: 182
            radius: 5
            color: AppGlobal.themes.current.accentColor
            ULanguage{
                id: fr_card
                backgroundPath: "/images/background/fr_flag.jpg"
                mName: "Français"
                x: 1
                y: 1
                selected: true
                MouseArea {
                    id: fr_card_area
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                            back_en_card.color = 'transparent'
                            back_fr_card.color = AppGlobal.themes.current.accentColor
                            en_card.selected = false;
                            fr_card.selected = true;
                    }
                }
            }
        }

        Rectangle{
            id: back_en_card
            width: 252
            height: 182
            radius: 5
            color: "transparent"
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
                            back_en_card.color = AppGlobal.themes.current.accentColor
                            back_fr_card.color = 'transparent'
                            en_card.selected = true;
                            fr_card.selected = false;
                    }
                }
            }
        }
                
    }

    UButton{
        btnText: qsTr("Suivant")
        iconPath: "/images/icons/arrow-alt-circle-right.svg"
        onClicked: {
            if(fr_card.selected == true){
                stackView.push("SetupTheme.qml")
            } else if (en_card.selected == true){
                stackView.push("SetupTheme.qml") 
            }
        }
        x:800
        y:490
    }
}