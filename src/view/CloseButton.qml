import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

Button {
    style : ButtonStyle {
        background: Rectangle {
            implicitWidth: 30
            implicitHeight: 30
            color: control.hovered || control.pressed ? "#FF6666" : "transparent"
            Canvas {
                width: parent.width; height: parent.height
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.save()
                    ctx.lineWidth = 2
                    ctx.strokeStyle = "white"
                    ctx.beginPath()
                    ctx.moveTo(10, 10)
                    ctx.lineTo(width - 10, height - 10)
                    ctx.moveTo(10, height - 10)
                    ctx.lineTo(width - 10, 10)
                    ctx.stroke()
                    ctx.restore()
                }
            }
        }
    }
}
