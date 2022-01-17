import QtQuick 2.0
import "../components"
import "../components/modpack"

CustomPage {
    id: modpacksPage
    pageTitle: qsTr("Modpacks")

    ListModel {
        id: mod
        ListElement { name: "1" }
        ListElement { name: "2" }
        ListElement { name: "salut" }
        ListElement { name: "coucou" }
    }

    GridView {
        id: grid
        anchors.fill:  parent

        model: mod
        cellWidth: 80; cellHeight: 80

        delegate: Column {
            ModpackVignette {
                name: name;
                width: grid.cellWidth
                height: grid.cellHeight
            }
        }
    }
}
