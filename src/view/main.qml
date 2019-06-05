import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2

Window {
    id: mainWindow
    visible: true
    width: 1024
    height: 700
    minimumWidth: 640
    minimumHeight: 480
    color: "transparent"
    flags: Qt.FramelessWindowHint | Qt.Window

    FramelessWindow {
        id: framelessWindow
        anchors.fill: parent
        titleColor: "#212124"
        logoImageSource: "qrc:/res/music_2.png"
        logoText: qsTr("Cool Music")
    }
}
