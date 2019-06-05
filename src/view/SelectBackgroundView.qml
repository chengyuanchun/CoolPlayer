import QtQuick 2.0
import QtQuick.Controls 2.2

Drawer {
    y: 8
    width: 117
    height: parent.height - 15
    edge: Qt.RightEdge
    visible: false

    Rectangle {
        anchors.fill: parent
        color: "#19181F"
        border.color: "#971818"
    }

    Text {
        id: title
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 10
        text: qsTr("background")
        color: "#DCDDE4"
        font.family: "Microsoft Yahei"
        font.pointSize: 12
    }

    Column {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: title.bottom
        anchors.bottom: parent.bottom
        anchors.margins: 10
        spacing: 1

        Button {
            id: pureButton
            text: qsTr("pure")
            highlighted: true
            font.family: "Microsoft Yahei"
            font.pointSize: 12
            onClicked: musicViewModel.selectBackground(0)
        }

        Button {
            text: qsTr("star")
            highlighted: true
            font: pureButton.font
            onClicked: musicViewModel.selectBackground(1)
        }

        Button {
            text: qsTr("snow")
            highlighted: true
            font: pureButton.font
            onClicked: musicViewModel.selectBackground(2)
        }

        Button {
            text: qsTr("universe")
            highlighted: true
            font: pureButton.font
            onClicked: musicViewModel.selectBackground(3)
        }

        Button {
            text: qsTr("particle")
            highlighted: true
            font: pureButton.font
            onClicked: musicViewModel.selectBackground(4)
        }

//        Button {
//            text: qsTr("Stone")
//            highlighted: true
//            font: pureButton.font
//            onClicked: musicViewModel.selectBackground(5)
//        }
    }
}
