import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: rootItem

    property string source
    property string state: "stop"

    function startRotation() {
        animation.start()
        rootItem.state = "runing"
    }

    function stopRotation() {
        animation.stop()
        rootItem.rotation = 0
        rootItem.state = "stop"
    }

    function pauseRotation() {
        animation.pause()
        rootItem.state = "pause"
    }

    function resumeRotation() {
        animation.resume()
        rootItem.state = "runing"
    }

    RotationAnimation {
        id: animation
        target: rootItem
        from: 0
        to: 360
        duration: 15000
        loops: Animation.Infinite
        direction: RotationAnimation.Clockwise
    }

    Image {
        id: image
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
        source: rootItem.source
        visible: false
    }

    Rectangle {
        id: mask
        anchors.fill: parent
        radius: parent.width
        visible: false
    }

    OpacityMask {
        anchors.fill: parent
        source: image
        maskSource: mask
    }
}
