import QtQuick 2.0
import QtQuick.Controls 2.2

Item {
    id: rootItem
    visible: opacity
    width: parent.width
    height: parent.height

    Image {
        id: bkImage
        anchors.fill: parent
        source: "qrc:/res/background.jpg"
    }

    Loader {
        id: loader
        anchors.fill: parent
    }

    ImageButton {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 5
        onClicked: {
            if (loader.source == "")
                loader.source = "StoneBackground.qml"
            else
                loader.source = ""
        }
        z: 10
        hoveredImage: "qrc:/res/main.png"
        normalImage: "qrc:/res/main.png"
    }

    Column {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 60
        anchors.topMargin: 30
        spacing: 2

        Text {
            text: qsTr("Cool Music")
            color: "white"
            font.family: "Microsoft Yahei"
            font.pointSize: 40
            font.bold: true
        }

        Text {
            text:"(Developed by Cheng Yuan Chun)"
            color: "white"
            font.family: "Microsoft Yahei"
            font.pointSize: 16
        }
    }

    state: "show"
    states: [
        State { name: "hide"; PropertyChanges { target: rootItem; y: -rootItem.height; opacity: 0 } },
        State { name: "show"; PropertyChanges { target: rootItem; y: 0; opacity: 1 } }
    ]

    transitions: [
        Transition {
            NumberAnimation { target: rootItem; property: "y"; duration: 1000; easing.type: Easing.InOutBack }
            NumberAnimation { target: rootItem; property: "opacity"; duration: 1000; easing.type: Easing.InOutQuad }
        }
    ]
}
