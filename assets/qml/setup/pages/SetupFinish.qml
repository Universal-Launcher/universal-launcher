import QtQuick 2.15
import QtQuick.Controls 2.15
import "qrc:/qml/common/ui"
import UniversalLauncher 1.0

Item{
    id: finish
    signal next()
    signal previous()
    
            Text{
                id: text
                text: qsTr("Configuration finished... Enjoy the game !")
                font.pixelSize: 25
                font.capitalization: Font.AllUppercase
                color: AppGlobal.themes.current.textColor
                anchors {
                    top: parent.top
                    topMargin: 80
                    horizontalCenter: parent.horizontalCenter
                }
            }
            

    Item {
        id: btnContainer
        height: btnNext.height
        width: parent.width

        anchors {
            bottom: parent.bottom
        }

        UButton {
            id: btnNext
            btnText: qsTr("Finish")
            iconPath: "/images/icons/arrow-alt-circle-right.svg"
            onClicked: next()

            anchors {
                right: parent.right
                bottom: parent.bottom
            }
        }

        UButton {
            id: btnPrevious
            btnText: qsTr("Previous")
            iconPath: "/images/icons/arrow-alt-circle-left.svg"
            onClicked: previous()

            anchors {
                left: parent.left
                bottom: parent.bottom
            }
        }
    }          
}
