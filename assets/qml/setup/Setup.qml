import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "pages"
import UniversalLauncher 1.0

Page {
    id: lang

    background: Rectangle {
        color: AppGlobal.themes.current.backgroundColor
        anchors.fill: parent
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 0

        Item {
            id: header
            height: logo.height
            Layout.fillWidth: true

            Image {
                id: logo
                width: 96
                height: 96
                source: "/images/logo.png"

                antialiasing: true
                smooth: true
                fillMode: Image.PreserveAspectFit

                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }
            }

            Text {
                id: title
                text: qsTr("Universal\nLauncher")
                font.bold: true
                font.pixelSize: 20
                font.capitalization: Font.AllUppercase
                color: AppGlobal.themes.current.textColor

                anchors {
                    left: logo.right
                    verticalCenter: parent.verticalCenter
                }
            }
        }

        Item {
            id: setupTitle
            Layout.fillWidth: true
            height: setup.height
            Text{
                id: setup
                text: qsTr("Setup")
                font.pixelSize: 35
                anchors.horizontalCenter: setupTitle.horizontalCenter
                font.capitalization: Font.AllUppercase
                horizontalAlignment: Text.AlignCenter
                color: AppGlobal.themes.current.textColor
            }
        }


        StackView {
            id: stackView
            Layout.fillHeight: true
            Layout.fillWidth: true
            anchors.margins: 0
            clip: true
            initialItem: setupLanguage

            Component {
                id: setupLanguage
                SetupLanguage {
                    onNext: stackView.push(setupTheme)
                }
            }

            Component {
                id: setupTheme
                SetupTheme {
                    onPrevious: stackView.pop()
                    onNext: stackView.push(setupJava)
                }
            }

            Component {
                id: setupJava
                SetupJava {
                    onPrevious: stackView.pop()
                    onNext: stackView.push(setupFinish)
                }
            }

            Component {
                id: setupFinish
                SetupFinish {
                    onPrevious: stackView.pop()
                    onNext: AppGlobal.finishSetup()
                }
            }
        }
    }
}
