import QtQuick 2.0
import QtQuick.Particles 2.0

Item {
    ParticleSystem { id: particles }

    ImageParticle {
        system: particles
        sprites: Sprite {
            name: "snow"
            source: "qrc:/res/snowflake.png"
            frameCount: 51
            frameDuration: 40
            frameDurationVariation: 8
        }
    }

    Wander {
        id: wanderer
        system: particles
        anchors.fill: parent
        xVariance: 360/(wanderer.affectedParameter+1);
        pace: 100*(wanderer.affectedParameter+1);
    }

    Emitter {
        system: particles
        emitRate: 20
        lifeSpan: 7000
        velocity: PointDirection { y:80; yVariation: 40; }
        acceleration: PointDirection { y: 4 }
        size: 20
        sizeVariation: 10
        width: parent.width
        height: 100
    }
}
