import QtQuick 2.15
import QtQuick.Controls 2.15
import "../components"
import "../components/ui"
import UniversalLauncher 1.0

CustomPage {
    id: settings
    pageTitle: qsTr("Settings")

    content: Column {
        spacing: 10
        clip: true

        anchors.fill: parent
        anchors.margins: 20

        Item {
            Text {
                id: openFolderTxt
                text: qsTr("Launcher folder")
                font.bold: true
                font.pixelSize: 15
            }

            UButton {
                btnText: qsTr("Open folder")
                iconPath: "/images/icons/box.svg"
                anchors {
                    top: openFolderTxt.bottom
                    topMargin: 10
                }
                onClicked: AppGlobal.folderSystem.openLauncherFolder()
            }
        }
    }
}