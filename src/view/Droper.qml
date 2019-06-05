import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

Item {
    id: rootItem
    width: 7
    height: 7

    Item {
        anchors.fill: parent
        Canvas {
            width: parent.width; height: parent.height
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d")
                ctx.save()
                ctx.lineWidth = 1
                ctx.fillStyle = "lightgray"
                ctx.beginPath()
                ctx.moveTo(0, rootItem.height)
                ctx.lineTo(rootItem.width, rootItem.height)
                ctx.lineTo(rootItem.width, 0)
                ctx.lineTo(0, rootItem.height)
                ctx.fill()
                ctx.restore()
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.SizeFDiagCursor
        property point clickPos: "0,0"
        onPressed: {
            clickPos = Qt.point(mouse.x, mouse.y)
        }
        onMouseXChanged: {
            var deltaX = mouse.x - clickPos.x
            var newWidth = mainWindow.width + deltaX
            if (newWidth >= mainWindow.minimumWidth)
                mainWindow.setWidth(newWidth)
        }
        onMouseYChanged: {
            var deltaY = mouse.y - clickPos.y
            var newHeight = mainWindow.height + deltaY
            if (newHeight >= mainWindow.minimumHeight)
                mainWindow.setHeight(newHeight)
        }
    }
}
