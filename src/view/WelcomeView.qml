import QtQuick 2.0
import QtQuick.Particles 2.0

Item {
    ParticleSystem {
        id: sys
        anchors.fill: parent
        running: true

        Rectangle {
            z: -1
            anchors.fill: parent
            color: "#19181F"

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                text: qsTr("Welcome to cool world")
                font.bold: true
                font.family: "Microsoft Yahei"
                font.pointSize: 16
                color: "white"
            }
        }

        property real petalRotation: 0
        NumberAnimation on petalRotation {
            from: 0;
            to: 360;
            loops: -1;
            running: true
            duration: 24000
        }

        function convert(a) {
            return a*(Math.PI/180)
        }

        Emitter {
            lifeSpan: 4000
            emitRate: 120
            size: 12
            anchors.centerIn: parent
            //! [0]
            onEmitParticles: {
                for (var i=0; i<particles.length; i++) {
                    var particle = particles[i];
                    particle.startSize = Math.max(02,Math.min(492,Math.tan(particle.t/2)*24));
                    var theta = Math.floor(Math.random() * 6.0);
                    particle.red = theta == 0 || theta == 1 || theta == 2 ? 0.2 : 1;
                    particle.green = theta == 2 || theta == 3 || theta == 4 ? 0.2 : 1;
                    particle.blue = theta == 4 || theta == 5 || theta == 0 ? 0.2 : 1;
                    theta /= 6.0;
                    theta *= 2.0*Math.PI;
                    theta += sys.convert(sys.petalRotation);//Convert from degrees to radians
                    particle.initialVX = 180 * Math.cos(theta);
                    particle.initialVY = 180 * Math.sin(theta);
                    particle.initialAX = particle.initialVX * -0.5;
                    particle.initialAY = particle.initialVY * -0.5;
                }
            }
        }

        ImageParticle {
            source: "qrc:/res/fuzzydot.png"
            alpha: 0.0
        }
    }
}
