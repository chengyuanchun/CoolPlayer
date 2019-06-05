import QtQuick 2.0
import QtMultimedia 5.8
import QtQuick.Particles 2.0
import QtGraphicalEffects 1.0

Item {
    ImageButton {
        id: settingButton
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        width: 20
        height: 20
        z: 9
        hoveredImage: "qrc:/res/settings-hover.png"
        normalImage: "qrc:/res/settings.png"
        onClicked: selectBackground.open()
    }

    Connections {
        target: musicViewModel
        onSelectBackground: {
            if (type == 0) {
                backgroundLoader.source = "PureBackground.qml"
            } else if (type == 1) {
                backgroundLoader.source = "StarBackground.qml"
            } else if (type == 2) {
                backgroundLoader.source = "SnowBackground.qml"
            } else if (type == 3) {
                backgroundLoader.source = "UniverseBackground.qml"
            } else if (type == 4) {
                backgroundLoader.source = "ParticleBackground.qml"
            } else if (type == 5) {
                backgroundLoader.source = "StoneBackground.qml"
            }

            selectBackground.close()
        }
    }

    Loader {
        id: backgroundLoader
        anchors.fill: parent
        source: "PureBackground.qml"
        clip: true
    }

    PlayControlView {
        id: playControl
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: parent.width
        height: 55
    }

    DisplayView {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: playControl.top
    }

    Connections {
        target: musicViewModel
        onPlay: mediaPlayer.play()
        onPause: mediaPlayer.pause()
        onStop: mediaPlayer.stop()
    }

    MediaPlayer {
        id: mediaPlayer
        volume: musicViewModel.volume
        source: musicViewModel.currentSongUrl

        onPositionChanged: {
            musicViewModel.updateLrcIndexByTime(position)
        }

        onStopped: musicViewModel.finished()
    }
}
