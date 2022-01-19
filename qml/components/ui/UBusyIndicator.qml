import QtQuick 2.15
import QtQuick.Controls 2.15

BusyIndicator {
    id: control

    property color color: "#F97316"

    contentItem: Item {
        implicitWidth: 64
        implicitHeight: 64

        Item {
            id: item
            width: 64
            height: 64
            opacity: control.running ? 1 : 0

            anchors.centerIn: parent

            Behavior on opacity {
                OpacityAnimator {
                    duration: 250
                }
            }

            Repeater {
                id: repeater
                model: 4

                Rectangle {
                    property bool reverse: ((index % 2) + Math.floor(index/2))%2 == 1

                    id: rect
                    x: (item.width / 2 - width / 2) + (index % 2 == 1 ? 11 : -11)
                    y: (item.height / 2 - height /2) + (Math.floor(index / 2) == 1 ? 11 : -11)
                    implicitWidth: 15
                    implicitHeight: 15
                    color: control.color
                    antialiasing: true

                    SequentialAnimation {
                        loops: Animation.Infinite
                        running: true

                        PauseAnimation { duration: 200 }

                        ParallelAnimation {
                            XAnimator {
                                target: repeater.itemAt(index)
                                duration: 300
                                from: x
                                to: x*1.5 - 11
                                easing.type: Easing.OutQuad
                            }

                            YAnimator {
                                target: repeater.itemAt(index)
                                duration: 300
                                from: y
                                to: y*1.5 - 11
                                easing.type: Easing.OutQuad
                            }
                        }

                        RotationAnimator {
                            target: repeater.itemAt(index)
                            from: reverse ? 360 : 0
                            to: reverse ? 0 : 360
                            duration: 1000
                            easing.type: Easing.InOutQuad

                            direction: reverse ? RotationAnimator.Counterclockwise : RotationAnimator.Clockwise
                        }

                        ParallelAnimation {
                            XAnimator {
                                target: repeater.itemAt(index)
                                duration: 300
                                from: x
                                to: x/1.5 + 11
                                easing.type: Easing.OutElastic
                            }

                            YAnimator {
                                target: repeater.itemAt(index)
                                duration: 300
                                from: y
                                to: y/1.5 + 11
                                easing.type: Easing.OutElastic
                            }
                        }

                        PauseAnimation { duration: 20 }
                    }
                }
            }
        }
    }
}
