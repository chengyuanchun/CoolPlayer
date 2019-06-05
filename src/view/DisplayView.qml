import QtQuick 2.0
import QtQuick.Controls 2.2

Item {
    Item {
        id: cdItem
        width: parent.width / 2
        height: parent.height
        anchors.left: parent.left
        anchors.top: parent.top

        CircleImage {
            id: cdImage
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 50
            opacity: 0.9
            width: parent.width - 10 > 300 ? 300 : parent.width - 10
            height: width
            source: musicViewModel.currentCover
        }

        Connections {
            target: musicViewModel
            onPlay: cdImage.state == "pause" ? cdImage.resumeRotation() : cdImage.startRotation()
            onPause: cdImage.pauseRotation()
            onStop: cdImage.stopRotation()
            onFinished: cdImage.stopRotation()
        }
    }

    Item {
        id: lrcItem
        width: parent.width / 2
        height: parent.height
        anchors.right: parent.right
        anchors.top: parent.top

        Item {
            id: headerItem
            width: parent.width
            height: 50

            Text {
                id: songNameText
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.top: parent.top
                anchors.topMargin: 10
                text: musicViewModel.currentSong == "" ? qsTr("Unknow") : musicViewModel.currentSong
                color: "#DCDDE4"
                font.family: "Microsoft Yahei"
                font.pointSize: 14
                font.bold: true
            }

            Text {
                id: singerText
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.top: songNameText.bottom
                anchors.topMargin: 5
                text: qsTr("singer: ") + musicViewModel.currentSinger
                color: "#DCDDE4"
                font.family: "Microsoft Yahei"
                font.pointSize: 12
            }
        }

        ListView {
            id: lrcListView
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: headerItem.bottom
            anchors.bottom: parent.bottom
            anchors.margins: 15
            anchors.topMargin: 25
            clip: true
            model: lrcListModel
            delegate: lrcDelegate
            focus: true
            spacing: 10
            currentIndex: musicViewModel.currentLrcIndex
            onCurrentIndexChanged: {
                positionViewAtIndex(currentIndex, ListView.Center)
            }
        }

        ListModel { id: lrcListModel }

        Connections {
            target: musicViewModel
            onLrcLoadFinished: {
                lrcListModel.clear()
                var lrcLines = musicViewModel.lrcLines()
                for (var i = 0; i < lrcLines.length; i++) {
                    lrcListModel.append( { lrcLine: lrcLines[i] })
                }
            }
        }

        Component {
            id: lrcDelegate
            Label {
                text: lrcLine
                color: ListView.isCurrentItem ? "#80C342" : "#DCDDE4"
                font.family: "Microsoft Yahei"
                font.pixelSize: 16
            }
        }
    }
}
