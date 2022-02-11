import QtQuick 2.15
import QtQuick.Controls 2.15
import "../components"
import "qrc:/qml/common/ui"
import UniversalLauncher 1.0
import QtGraphicalEffects 1.15

CustomPage {
    id: accounts
    pageTitle: qsTr("Accounts")

    Text {
        anchors {
            top: accounts.top
            topMargin: 60
            left: accounts.left
        }
        id: textAccount
        text: qsTr("Connected accounts")
        font.pixelSize: 18
        font.capitalization: Font.AllUppercase
        color: AppGlobal.themes.current.textColor
    }

    ListView {
        id: listAccounts
        spacing: 15
        clip: true

        width: parent.width

        anchors {
            top: textAccount.bottom
            topMargin: 20
            bottom: btnContainer.top
        }

        ScrollBar.vertical: UScrollBar {}

        Component {
            id: card
            Button {
                width: listAccounts.width
                background: Rectangle {
                    color: AppGlobal.themes.current.backgroundColor2
                    radius: 10

                    anchors.fill: parent
                }
                onClicked: function () {}

                height: 64

                Image {
                    id: avatar
                    anchors {
                        left: parent.left
                        leftMargin: 20
                        verticalCenter: parent.verticalCenter
                    }
                    width: 48
                    height: 48
                    source: modelData.avatar
                    antialiasing: true
                    smooth: false
                    visible: false
                }

                Rectangle {
                    id: avatarMask
                    anchors.fill: avatar
                    visible: false
                    radius: AppGlobal.themes.current.radius
                }

                OpacityMask {
                    anchors.fill: avatar
                    source: avatar
                    maskSource: avatarMask
                }

                Text {
                    id: nameAccount
                    text: modelData.username
                    color: AppGlobal.themes.current.textColor
                    font.pixelSize: 14
                    font.bold: true
                    anchors {
                        fill: parent
                        top: parent.top
                        topMargin: 10
                        left: avatar.right
                        leftMargin: 80
                    }
                }
            }
        }

        model: AccountsManager.accounts
        delegate: card
    }

    Item {
        id: btnContainer
        height: btnAdd.height
        width: parent.width

        anchors {
            bottom: parent.bottom
            left: parent.left
        }

        UButton {
            id: btnAdd
            btnText: qsTr("Add account")
            iconPath: "/images/icons/user-plus.svg"
            width: 175
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
            }
            onClicked: authPopup.open()
        }
    }

    AuthModal {
        id: authPopup
    }
}
