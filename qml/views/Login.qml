import QtQuick 2.15
import QtQuick.Controls 2.15
import QtWebView 1.1

Page {
    id: login

    background: Rectangle {
        color: "#00000000"
    }

    WebView {
        id: webview
        anchors.fill: parent
        url: "https://google.com"
    }
}
