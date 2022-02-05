import QtQuick 2.15
import QtQuick.Controls 2.15
import "qrc:/qml/main/components/"
import "qrc:/qml/main/components/ui/"
import "./components/"
import "."
import UniversalLauncher 1.0

Rectangle{
    id: home
    color: AppGlobal.themes.current.backgroundColor
    property StackView stack
    Component.onCompleted: AppGlobal.themes.changeTheme("default")
    
            Text{
                id: setup
                text: "Setup"
                font.pixelSize: 35
                font.capitalization: Font.AllUppercase
                anchors.horizontalCenter: parent.horizontalCenter
                color: AppGlobal.themes.current.textColor
                y: 60
            }

            Text{
                id: text
                text: "Select Theme"
                font.pixelSize: 18
                font.capitalization: Font.AllUppercase
                x: 95
                color: AppGlobal.themes.current.textColor
                y: 145
            }

            Row{
                id: rowTheme
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10
                y: 175

                Rectangle{
                    id: border_wt;
                    width: 256
                    height: 222
                    radius: 10
                    color: AppGlobal.themes.current.accentColor
                    UTheme{
                        id: wt   
                        selected: true
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
                                    AppGlobal.themes.changeTheme("default")
                                    border_wt.color = AppGlobal.themes.current.accentColor;
                                }
                                else if(st.selected == true) {
                                    st.selected = false;
                                    wt.selected = true;
                                    border_st.color = "transparent";
                                    AppGlobal.themes.changeTheme("default")
                                    border_wt.color = AppGlobal.themes.current.accentColor;
                                }
                            }
                        }
                        whiteTheme: true
                        themeText: "White Theme"
                    }
                }

                Rectangle{
                    id: border_dt;
                    width: 256
                    height: 222
                    radius: 10
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
                                    AppGlobal.themes.changeTheme("dark")
                                    border_dt.color = AppGlobal.themes.current.accentColor;
                                }
                                else if(st.selected == true) {
                                    st.selected = false;
                                    dt.selected = true;
                                    border_st.color = "transparent";
                                    AppGlobal.themes.changeTheme("dark")     
                                    border_dt.color = AppGlobal.themes.current.accentColor;                               
                                }
                            }
                        }
                        darkTheme: true
                        themeText: "Dark Theme"
                    }
                }
                Rectangle{
                    id: border_st;
                    width: 256
                    height: 222
                    radius: 10
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
                                    AppGlobal.themes.changeTheme("sepia")           
                                    border_st.color = AppGlobal.themes.current.textColor;                                                             
                                } else if(dt.selected == true) {
                                    dt.selected = false;
                                    st.selected = true;
                                    border_dt.color = "transparent";
                                    AppGlobal.themes.changeTheme("sepia")
                                    border_st.color = AppGlobal.themes.current.textColor;                                    
                                }
                            }
                        }
                    }
                }
            }

            UButton{
                btnText: qsTr("Suivant")
                iconPath: "/images/icons/arrow-alt-circle-right.svg"
                onClicked: {
                            if(wt.selected == true){
                                stackView.push("SetupJava.qml")
                            } else if (dt.selected == true){
                                stackView.push("SetupJava.qml") 
                            } else if (st.selected == true){
                                stackView.push("SetupJava.qml") 
                            }
                        }
                x:800
                y:490
            }


            UButton{
                btnText: qsTr("Retour")
                iconPath: "/images/icons/arrow-alt-circle-left.svg"
                onClicked: {
                    stackView.pop("SetupLanguage.qml");
                }
                x:20
                y:490
            }

}

