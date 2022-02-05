import QtQuick 2.15
import QtQuick.Controls 2.15
import "qrc:/qml/main/components/"
import "qrc:/qml/main/components/ui/"
import "./components/"
import "."
import UniversalLauncher 1.0

CustomPage{
    id: home

    property StackView stack

    pageTitle: ""
            Image{
                id: logo
                x: 17
                y: 10
                width: 96
                height: 96
                source: "/images/icons/logo.png"
            }
            Text{
                id: title
                text: "Universal Launcher"
                width: 120
                height: 100
                font.bold: true
                font.pixelSize: 20
                font.capitalization: Font.AllUppercase
                wrapMode: Text.Wrap
                x: 130
                y: 25
            }

            Text{
                id: setup
                text: "Theme"
                font.pixelSize: 35
                font.capitalization: Font.AllUppercase
                anchors.horizontalCenter: parent.horizontalCenter
                color: textBlueSpeColor
                y: 170
            }

            Row{
                id: rowTheme
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10
                y: 240

                Rectangle{
                    id: border_wt;
                    width: 308
                    height: 254
                    radius: 5
                    color: "transparent"
                    UTheme{
                        id: wt   
                        anchors.horizontalCenter: border_wt.horizontalCenter
                        anchors.verticalCenter: border_wt.verticalCenter              
                        MouseArea {
                            id: wt_ma
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                if(wt.selected == true){}
                                else if(dt.selected == true) {
                                    dt.selected = false;
                                    wt.selected = true;
                                    border_dt.color = "transparent";
                                    border_wt.color = "red";
                                }
                                else if(st.selected == true) {
                                    st.selected = false;
                                    wt.selected = true;
                                    border_st.color = "transparent";
                                    border_wt.color = "red";
                                }
                                else{
                                    wt.selected = true;
                                    border_wt.color = "red";
                                }
                            }
                        }
                        whiteTheme: true
                        themeText: "White Theme"
                    }
                }

                Rectangle{
                    id: border_dt;
                    width: 308
                    height: 254
                    radius: 5
                    color: "transparent"
                    UTheme{
                        id: dt
                        anchors.horizontalCenter: border_dt.horizontalCenter
                        anchors.verticalCenter: border_dt.verticalCenter
                        MouseArea {
                            id: dt_ma
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                if(dt.selected == true){}
                                else if(wt.selected == true) {
                                    wt.selected = false;
                                    dt.selected = true;
                                    border_wt.color = "transparent";                                    
                                    border_dt.color = "red";
                                }
                                else if(st.selected == true) {
                                    st.selected = false;
                                    dt.selected = true;
                                    border_st.color = "transparent";
                                    border_dt.color = "red";
                                }
                                else{
                                    dt.selected = true;
                                    border_dt.color = "red";
                                }
                            }
                        }
                        darkTheme: true
                        themeText: "Dark Theme"
                    }
                }
                Rectangle{
                    id: border_st;
                    width: 308
                    height: 254
                    radius: 5
                    color: "transparent"
                    UTheme{
                        id: st
                        sepiaTheme: true
                        themeText: "Sepia Theme"
                        anchors.horizontalCenter: border_st.horizontalCenter
                        anchors.verticalCenter: border_st.verticalCenter
                        MouseArea {
                            id: st_ma
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                if(st.selected == true){}
                                else if(wt.selected == true) {
                                    wt.selected = false;
                                    st.selected = true;
                                    border_wt.color = "transparent";
                                    border_st.color = "red";
                                } else if(dt.selected == true) {
                                    dt.selected = false;
                                    st.selected = true;
                                    border_dt.color = "transparent";
                                    border_st.color = "red";
                                } else {
                                    st.selected = true;
                                    border_st.color = "red";
                                }
                            }
                        }
                    }
                }
            }

            UButton{
                btnText: qsTr("Suivant")
                iconPath: "/images/icons/arrow-alt-circle-right.svg"
                onClicked: stackView.replace(java)
                x:800
                y:590
            }

            SetupJava{
                visible:false
                id: java
                anchors.fill: parent
            }

}

