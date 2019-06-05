import QtQuick 2.0
import QtQuick.Particles 2.0

Item {
    ParticleSystem { id: sys }

    Image {
        width: parent.width * 1.5
        height: parent.height * 1.5
        source: "qrc:/res/finalfrontier.png"
        transformOrigin: Item.Center
        anchors.centerIn: parent
        NumberAnimation on rotation {
            from: 0
            to: 360
            duration: 200000
            loops: Animation.Infinite
        }
    }

    ImageParticle {
        system: sys
        groups: ["starfield"]
        source: "qrc:/res/star.png"
        colorVariation: 0.3
        color: "white"
    }
    Emitter {
        id: starField
        system: sys
        group: "starfield"

        emitRate: 80
        lifeSpan: 2500

        anchors.centerIn: parent

        acceleration: AngleDirection {angleVariation: 360; magnitude: 200}//Is this a better effect, more consistent velocity?
//        acceleration: PointDirection { xVariation: 200; yVariation: 200; }

        size: 0
        endSize: 80
        sizeVariation: 10
    }

}
