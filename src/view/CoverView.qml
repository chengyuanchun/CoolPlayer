import QtQuick 2.0

Item {
    width: parent.width
    height: parent.height

    CoverFlow {
        anchors.fill: parent
        coverFlowModel: coverViewModel.coverFlowModel
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        text: musicViewModel.currentSinger
        color: "white"
        font.family: "Microsoft Yahei"
        font.pointSize: 14
    }
}
