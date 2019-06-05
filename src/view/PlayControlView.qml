import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Item {

    function formatDuring(ms) {
        var minutes = parseInt((ms % (1000 * 60 * 60)) / (1000 * 60))
        var seconds = parseInt((ms % (1000 * 60)) / 1000)
        return zeroFill(minutes) + ":" + zeroFill(seconds)
    }

    function zeroFill(num) {
        if (num < 10) {
            num = "0" + num
        }
        return num
    }

    Rectangle {
        anchors.fill: parent
        color: "#222225"
    }

    Row {
        id: buttonRow
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 25
        spacing: 15

        ImageButton {
            id: playButton
            hoveredImage: "qrc:/res/playhoverpressed.png"
            normalImage: "qrc:/res/playnormal.png"
            onClicked: musicViewModel.play()
        }

        ImageButton {
            id: pauseButton
            hoveredImage: "qrc:/res/pausehoverpressed.png"
            normalImage: "qrc:/res/pausenormal.png"
            onClicked: musicViewModel.pause()
        }

        ImageButton {
            id: stopButton
            hoveredImage: "qrc:/res/stophoverpressed.png"
            normalImage: "qrc:/res/stopnormal.png"
            onClicked: musicViewModel.stop()
        }
    }

    // 进度条
    Item {
        anchors.left: buttonRow.right
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: soundCtl.left
        anchors.rightMargin: 10

        Text {
            id: currentTimeText
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            text: formatDuring(mediaPlayer.position)
            color: "white"
        }

        ProgressBar {
            id: progress
            anchors.left: currentTimeText.right
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: totalTimeText.left
            anchors.rightMargin: 5
            minimumValue: 0
            maximumValue: mediaPlayer.duration
            value: mediaPlayer.position

            style: ProgressBarStyle {
                background: Rectangle {
                    implicitHeight: 6
                    color: "lightgray"
                }
                progress: Rectangle {
                    color: "#80C342"
                }
            }
        }

        Text {
            id: totalTimeText
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            text: formatDuring(mediaPlayer.duration)
            color: "white"
        }
    }

    // 音量控制
    Item {
        id: soundCtl
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: 150

        Image {
            id: soundCtlImage
            source: "qrc:/res/qcsound.png"
            width: 20
            height: 20
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
        }

        Slider {
            id: soundSlider
            anchors.left: soundCtlImage.right
            anchors.leftMargin: 5
            anchors.right: soundText.left
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            maximumValue: 1.0
            minimumValue: 0.0
            value: 0.5
            onValueChanged: musicViewModel.volume = value
            style: SliderStyle {
                groove: Rectangle {
                    height: 6
                    color: "#DCDDE4"
                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        color: "#80C342"
                        width: styleData.handlePosition
                        height: parent.height
                    }
                }
            }
        }

        Text {
            id: soundText
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 5
            width: 25
            color: "white"
            text: parseInt(soundSlider.value * 100) + "%"
        }
    }
}
