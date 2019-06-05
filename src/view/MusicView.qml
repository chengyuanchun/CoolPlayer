import QtQuick 2.0
import QtQuick.Controls 2.2

Item {
    Rectangle {
        id: topLine
        width: parent.width
        height: 4
        anchors.left: parent.left
        anchors.top: parent.top
        color: "#971818"
    }

    Rectangle {
        id: content
        width: parent.width
        anchors.left: parent.left
        anchors.top: topLine.bottom
        anchors.bottom: parent.bottom
        color: "#19181F"

        PlaylistView {
            id: playList
            anchors { top: parent.top; bottom: parent.bottom; left: parent.left }
            width: 200
        }

        ContentView {
            id: contentView
            anchors { top: parent.top; bottom: parent.bottom; left: playList.right; right: parent.right}
        }

    }
}
