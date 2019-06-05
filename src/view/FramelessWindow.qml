import QtQuick 2.0
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

Rectangle {
    id: rootWindow
    color: "transparent"

    property Component workArea
    property string state: "normal"
    property color titleColor: "green"
    property string logoImageSource
    property string logoText
    property int titleHeight: 50

    signal itemDoubleClicked()

    Item {
        id: container
        anchors.fill: parent

        Rectangle {
            id: mainRect
            width: container.width - 2 * rectShadow.radius
            height: container.height - 2 * rectShadow.radius
            anchors.centerIn: parent
            states: [
                State {
                    name: "mini"
                    StateChangeScript { script: mainWindow.showMinimized() }
                },
                State {
                    name: "normal"
                    PropertyChanges { target: mainRect; width: container.width - 2 * rectShadow.radius; height: container.height - 2 * rectShadow.radius }
                    PropertyChanges { target: miniButton; visible: true }
                    PropertyChanges { target: maxButton; visible: true }
                    PropertyChanges { target: droper; visible: true }
                    StateChangeScript { script: mainWindow.showNormal() }
                },
                State {
                    name: "max"
                    PropertyChanges { target: mainRect; width: container.width - 2 * rectShadow.radius; height: container.height - 2 * rectShadow.radius }
                    PropertyChanges { target: miniButton; visible: true }
                    PropertyChanges { target: maxButton; visible: true }
                    PropertyChanges { target: droper; visible: false }
                    StateChangeScript { script: mainWindow.showMaximized() }
                },
                State {
                    name: "fullScreen"
                    PropertyChanges {target: mainRect; width: container.width; height: container.height }
                    PropertyChanges { target: miniButton; visible: false }
                    PropertyChanges { target: maxButton; visible: false }
                    PropertyChanges { target: droper; visible: false }
                    StateChangeScript { script: mainWindow.showFullScreen() }
                }
            ]

            // 标题栏
            Rectangle {
                id: titleBar
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                height: rootWindow.titleHeight
                color: rootWindow.titleColor
                z: 10

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    property point clickPos: "0,0"
                    onPressed: {
                        clickPos = Qt.point(mouse.x, mouse.y)
                    }
                    onPositionChanged: {
                        if (mainRect.state != "fullScreen") {
                            mainWindow.setX(mainWindow.x + mouse.x - clickPos.x)
                            mainWindow.setY(mainWindow.y + mouse.y - clickPos.y)
                        }
                    }
                    onDoubleClicked: {
                        if (mainRect.state == "fullScreen")
                            mainRect.state = "normal"
                        else
                            mainRect.state = "fullScreen"
                    }
                }

                Image {
                    id: logoImage
                    width: 32
                    height: 32
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    source: rootWindow.logoImageSource
                }

                Text {
                    id: logoText
                    anchors.left: logoImage.right
                    anchors.leftMargin: 1
                    anchors.verticalCenter: parent.verticalCenter
                    text: rootWindow.logoText
                    color: "white"
                    font.family: "Microsoft Yahei"
                    font.bold: true
                    font.pointSize: 12
                }

                ImageButton {
                    id: prevButton
                    anchors.left: logoText.right
                    anchors.leftMargin: 50
                    anchors.verticalCenter: parent.verticalCenter
                    impWidth: 10
                    impHeight: 15
                    normalImage: "qrc:/res/prev.png"
                    hoveredImage: "qrc:/res/prev-hover.png"
                    onClicked: {
                        musicViewModel.clearInfo()
                        framelessViewModel.switchCoverFlowPage()
                    }
                }

                // system buttons
                Row {
                    id: systemButtons
                    anchors.top: parent.top
                    anchors.right: parent.right
                    spacing: 1

                    // mini button
                    MiniButton {
                        id: miniButton
                        onClicked: {
                            if (mainRect.state == "mini")
                                mainWindow.showMinimized()
                            else
                                mainRect.state = "mini"
                        }
                    }

                    // max button
                    MaxButton {
                        id: maxButton
                        onClicked: {
                            if (mainRect.state == "max")
                                mainRect.state = "normal"
                            else
                                mainRect.state = "max"
                        }
                    }

                    // close button
                    CloseButton {
                        id: closeButton
                        onClicked: mainWindow.close()
                    }
                }
            }

            // 工作区域
            Component {
                id: coverFlowComponent
                Item {
                    CoverView {
                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.RightButton
                            onClicked: {
                                if (mouse.button === Qt.RightButton)
                                    welcomeView.state = "show"
                            }
                        }
                    }
                    WelcomeView2 {
                        id: welcomeView
                        MouseArea {
                            anchors.fill: parent
                            onClicked: parent.state = "hide"
                        }
                    }
                }
            }

            Component {
                id: musicViewComponent
                MusicView { }
            }

            Component {
                id: stackComponent
                StackView {
                    initialItem: coverFlowComponent
                }
            }

            Loader {
                id: viewLoader
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: titleBar.bottom
                anchors.bottom: parent.bottom
                sourceComponent: stackComponent
                //                Component.onCompleted: timer.start()
            }

            //            Timer {
            //                id: timer
            //                interval: 1000
            //                onTriggered: {
            //                    viewLoader.sourceComponent = stackComponent
            //                }
            //            }

            Connections {
                target: framelessViewModel
                onSwitchMusicPage: {
                    viewLoader.item.push(musicViewComponent)
                }
                onSwitchCoverFlowPage: {
                    viewLoader.item.pop()
                }
            }

            // 弹出选择背景窗口
            SelectBackgroundView {
                id: selectBackground
            }

            // 拖动控件
            Droper {
                id: droper
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 2
            }
        } // mainRect
    } // container

    //绘制阴影
    DropShadow {
        id: rectShadow
        anchors.fill: source
        cached: true
        horizontalOffset: 0
        verticalOffset: 0
        radius: 8.0
        samples: 16
        color: "#80000000"
        smooth: true
        source: container
    }
}
