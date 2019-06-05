import QtQuick 2.0
import QtQuick.Particles 2.0

Item {
    ParticleSystem {
        id: particles
        running: true
    }

    ImageParticle {
        anchors.fill: parent
        system: particles
        source: "qrc:/res/star.png"
        sizeTable: "qrc:/res/sparkleSize.png"
        alpha: 0
        colorVariation: 0.6
    }

    Emitter {
        anchors.fill: parent
        system: particles
        emitRate: 2000
        lifeSpan: 2000
        size: 30
        sizeVariation: 10
    }
}
