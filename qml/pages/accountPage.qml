import QtQuick 2.0
import "../components"
import "../components/ui"

import Authentication 1.0

CustomPage {
    id: accountPage
    pageTitle: qsTr("Account")

    UButton {
        anchors.top: parent.top
        anchors.left: parent.left

        anchors.leftMargin: 10
        anchors.topMargin: 50
        btnText: qsTr("Sign out")

        iconPath: "/images/icons/sign-out-alt.svg"

        onClicked: function() {
            Authentication.signout()
        }
    }
}
