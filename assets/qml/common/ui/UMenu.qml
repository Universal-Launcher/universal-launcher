import QtQuick 2.15
import QtQuick.Controls 2.15
import UniversalLauncher 1.0

Menu {
    id: menu

    background: Rectangle {
        radius: AppGlobal.themes.current.radius
        color: AppGlobal.themes.current.backgroundColor
        border.color: AppGlobal.themes.current.accentColor
        border.width: 0.5
    }
    padding: 10
    contentItem: Column {}
}
