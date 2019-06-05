import QtQuick 2.0

Rectangle {
    color: "#19181F"
    border.color: "#383C40"
    border.width: 1

    ListView {
        id: musicListView
        width: 200
        anchors { left: parent.left; right: parent.right; top: parent.top; bottom: currentSongRect.top }
        anchors.margins: 1
        focus: true
        clip: true
        model: musicListModel
        delegate: listDelegate
//        highlight: hightlightBar
    }

    Connections {
        target: musicViewModel
        onCurrentSingerChanged: {
            musicListModel.clear()
            var musicNames = musicViewModel.musicNames(text)
            for (var i = 0; i < musicNames.length; i++) {
                musicListModel.append({ "name": musicNames[i], "time": musicViewModel.musicTimeByName(musicNames[i]) })
            }
        }
    }

    ListModel { id: musicListModel }

    Component {
        id: listDelegate
        Rectangle {
            id: wrapper
            width: parent.width
            height: 40
            color: index % 2 == 0 ? "#1A1C20" : "#16181C"

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: parent.color = "#232529"
                onExited: parent.color = Qt.binding(function(){ return index % 2 == 0 ? "#1A1C20" : "#16181C" })
                onClicked: {
                    wrapper.ListView.view.currentIndex = index
                    musicViewModel.currentSong = name
                }
            }

            Text {
                id: numberText
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
                text: index
                color: wrapper.ListView.isCurrentItem ? "#80C342" : "#DCDDE4"
                font.family: "Microsoft Yahei"
                font.pointSize: 10
            }

            Text {
                id: nameText
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: numberText.right
                anchors.leftMargin: 10
                text: name
                color: numberText.color
                font.family: "Microsoft Yahei"
                font.pointSize: 10
            }

            Text {
                id: timeText
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                text: time
                color: numberText.color
                font.family: "Microsoft Yahei"
                font.pointSize: 10
            }
        }
    } // ListDelegate

    Component {
        id: hightlightBar
        Rectangle {
            width: parent.width
            height: 40
            color: "#99FF99"

            y: musicListView.currentItem.y
            Behavior on y { SpringAnimation{ spring: 2; damping: 0.2 }}
        }
    }

    Rectangle {
        id: currentSongRect
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 55
        color: "#19181F"
        border.color: "#383C40"
        border.width: 1

        Image {
            id: currentSongImage
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 35
            height: 35
            source: "qrc:/res/music_logo.png"
        }

        Item {
            anchors.left: currentSongImage.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right

            Text {
                anchors.centerIn: parent
                text: musicViewModel.currentSinger + "-" + musicViewModel.currentSong
                color: "white"
                font.family: "Microsoft Yahei"
                font.pointSize: 12
            }
        }
    }
}
