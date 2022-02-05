import QtQuick.Controls 2.15
import "../components"
import "qrc:/qml/main/components"
import "qrc:/qml/main/components/navigation"

CustomPage {
    id: home
    pageTitle: qsTr("Home")

    ModpackCard{
        id: modpackCard
        x: 12
        y: 100
        backgroundPath: "/images/background/mCard.jpg"
        mIcon: "/images/icons/logo.png"
        mName: "Mod Pack Name"
        mVersion: "1.8.8"
        mText: "Ut libero dolorem consequatur omnis vero sit. Quisquam rerum est dicta iure dolor accusantium unde. Aut quis ea exercitationem neque et. Voluptatem et eum quis sint..."
    }
}