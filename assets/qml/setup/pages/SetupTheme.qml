import QtQuick 2.15
import QtQuick.Controls 2.15
import "qrc:/qml/common/ui/"
import "../components"
import "."
import UniversalLauncher 1.0

Item {
    signal next()
    signal previous()


    Text{
        id: text
        text: qsTr("Select Theme")
        font.pixelSize: 18
        font.capitalization: Font.AllUppercase
        color: AppGlobal.themes.current.textColor

        anchors {
            top: parent.top
            topMargin: 30
            horizontalCenter: parent.horizontalCenter
        }
    }

    GridView {
        id: grid
        clip: true

        cellWidth: 200  + (grid.width % 200)/(grid.width/200)
        cellHeight: 140

        width: parent.width * 0.5
        highlightFollowsCurrentItem: true
        highlightMoveDuration: -1

        anchors {
            top: text.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 20
            bottomMargin: 20
            bottom: btnContainer.top
        }

        ScrollBar.vertical: UScrollBar {}

        Component {
            id: preview_theme

            Item {
                required property string modelData
                width: grid.cellWidth
                height: grid.cellHeight


                UTheme {
                    name: modelData
                    onClicked: AppGlobal.themes.changeTheme(modelData)
                    anchors {
                        centerIn: parent
                        margins: 5
                    }
                }
            }
        }

        model: AppGlobal.themes.themesList

        delegate: preview_theme
    }

    Item {
        id: btnContainer
        height: btnNext.height
        width: parent.width

        anchors {
            bottom: parent.bottom
        }

        UButton {
            id: btnPrevious
            btnText: qsTr("Previous")
            iconPath: "/images/icons/arrow-alt-circle-left.svg"
            onClicked: previous()

            anchors {
                right: parent.left
                bottom: parent.bottom
            }
        }

        UButton {
            id: btnNext
            btnText: qsTr("Next")
            iconPath: "/images/icons/arrow-alt-circle-right.svg"
            onClicked: next()

            anchors {
                right: parent.right
                bottom: parent.bottom
            }
        }
    }
}

