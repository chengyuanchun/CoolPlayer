import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Button {
    property string hoveredImage
    property string normalImage
    property int impWidth: 35
    property int impHeight: 35

    style: ButtonStyle {
        background: Rectangle {
            implicitWidth: impWidth
            implicitHeight: impHeight
            color: "transparent"
            Image {
                anchors.fill: parent
                source: control.hovered ? hoveredImage : normalImage
            }
        }
    }
}
