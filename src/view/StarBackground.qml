import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle {
    id: sky
    gradient: Gradient {
        GradientStop { id: gradientStopA; position: 0.0; color: "#0E1533" }
        GradientStop { id: gradientStopB; position: 1.0; color: "#437284" }
//        GradientStop { id: gradientStopA; position: 0.0; color: "#16181C" }
//        GradientStop { id: gradientStopB; position: 1.0; color: "#212C34" }
    }

    Image {
        id: moonImage
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20
        source: "qrc:/res/moon.png"
    }

    ParticleSystem {
        id: particlesystem
        anchors.fill: sky

        ImageParticle {
            id: stars
            source: "qrc:/res/star.png"
            groups: ["stars"]
            opacity: .5
        }

        Emitter {
            id: starsemitter
            anchors.fill: parent
            emitRate: parent.width / 50
            lifeSpan: 5000
            group: "stars"
        }
    }
}
