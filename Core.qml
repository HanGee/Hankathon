import QtQuick 2.3
import QtQuick.Particles 2.0
import QtGraphicalEffects 1.0

Item {
	id: core;
	property int circleSize: 0;

	width: circleSize;
	height: circleSize;

	NumberAnimation on opacity {
		running: core.visible;
		duration: 500;
		easing.type: Easing.OutInBounce;
		from: 0;
		to: 1;
	}

	Spinner {
		width: parent.circleSize;
		height: parent.circleSize;
		color: '#ffffff';
		border: parent.circleSize * 0.3;
		opacity: 0.1;
		angleMarginFactor: 30;
		count: 60;
		duration: 10000;
		from: 0;
		to: 360;
		easingType: Easing.OutInBounce;
	}

	Spinner {
		width: parent.circleSize;
		height: parent.circleSize;
		color: '#ffffff';
		border: parent.circleSize;
		opacity: 0.1;
		angleMarginFactor: 1;
		count: 2;
		duration: 10000;
		from: 0;
		to: 360;
		easingType: Easing.InOutBounce;
	}

	Circle {
		width: parent.circleSize * 0.95;
		height: parent.circleSize * 0.95;
		color: '#ffffff';
		border: parent.circleSize * 0.01;
		anchors.centerIn: parent;
		opacity: 0.2;

		layer.enabled: true;
		layer.effect: Glow {
			radius: 4;
			samples: 16;
			spread: 0.1;
			cached: true;
			color: '#33aaff';
		}
	}

	Circle {
		width: parent.circleSize * 0.9;
		height: parent.circleSize * 0.9;
		color: '#ffffff';
		border: parent.circleSize * 0.01;
		anchors.centerIn: parent;
		opacity: 0.5;

		layer.enabled: true;
		layer.effect: Glow {
			radius: 4;
			samples: 16;
			spread: 0.1;
			cached: true;
			color: '#33aaff';
		}
	}

	Item {
		id: triangle1;
		property int objSize: parent.circleSize * 0.75;
		width: objSize;
		height: objSize;
		anchors.centerIn: parent;

		Polygon {
			width: parent.width;
			height: parent.height;
			anchors.centerIn: parent;
			color: '#ffffff';
			edge: 3;
			border: 5;
			opacity: 0.3;

			transform: Rotation {
				origin.x: triangle1.width * 0.5;
				origin.y: triangle1.height * 0.5;
				axis { x: 0; y: 1; z: 1 }
				angle: 45;

				SequentialAnimation on angle {
					loops: Animation.Infinite
					running: core.visible;

					NumberAnimation {
						duration: 2000;
						easing.type: Easing.Linear;
						from: 0;
						to: 360;
					}
				}

			}
		}

		Polygon {
			width: parent.width;
			height: parent.height;
			anchors.centerIn: parent;
			color: '#ffffff';
			edge: 3;
			border: 5;
			opacity: 0.3;

			transform: Rotation {
				origin.x: triangle1.width * 0.5;
				origin.y: triangle1.height * 0.5;
				axis { x: 0; y: 1; z: 1 }
				angle: 45;

				SequentialAnimation on angle {
					loops: Animation.Infinite
					running: core.visible;

					NumberAnimation {
						duration: 2000;
						easing.type: Easing.Linear;
						from: 90;
						to: 450;
					}
				}

			}
		}
	}

	ParticleSystem {
		id: coreSystem
		running: true;
	}

	ImageParticle {
		system: coreSystem
		source: 'qrc:///particleresources/glowdot.png'
		color: 'cyan'
		alpha: 0
		SequentialAnimation on color {
			loops: Animation.Infinite
			ColorAnimation {
				from: 'cyan'
				to: 'magenta'
				duration: 2000
			}
			ColorAnimation {
				from: 'magenta'
				to: 'blue'
				duration: 1000
			}
			ColorAnimation {
				from: 'blue'
				to: 'violet'
				duration: 2000
			}
			ColorAnimation {
				from: 'violet'
				to: 'cyan'
				duration: 2000
			}

		}
		colorVariation: 0.3
	}

	Emitter {
		system: coreSystem;

		emitRate: 500
		lifeSpan: 1500

		y: corePath.cy
		x: corePath.cx

		velocity: PointDirection { xVariation: 4; yVariation: 4; }
		acceleration: PointDirection {xVariation: 10; yVariation: 10;}
		velocityFromMovement: 0.1

		size: 4;
		sizeVariation: 8
		enabled: coreSystem.running;
	}

	Item {
		id: corePath;
		property int circleSize: parent.height * 0.5;
		property real radius: circleSize * 0.3;
		property real dx: parent.width / 2
		property real dy: parent.height / 2
		property real cx: radius * Math.sin(percent * 6.283185307179) + dx
		property real cy: radius * Math.cos(percent * 6.283185307179) + dy
		property real percent: 0

		SequentialAnimation on percent {
			loops: Animation.Infinite
			running: core.visible;

			NumberAnimation {
				duration: 800;
				from: 360;
				to: 0
				loops: 8
			}
		}
	}
}
