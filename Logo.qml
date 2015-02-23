import QtQuick 2.3
import QtGraphicalEffects 1.0

Item {
	id: logo;

	anchors.margins: 20;

	signal finished();

	Image {
		id: imageSource;
		width: parent.width;
		fillMode: Image.PreserveAspectFit;
		asynchronous: true;
		cache: true;
		mipmap: true;
		source: 'logo/HackathonTW.png'

		layer.enabled: true;
		layer.effect: Glow {
			radius: 8;
			samples: 16;
			transparentBorder: true;
			spread: 0.2;
			cached: true;
			color: '#33aaff';
			source: imageSource
		}

		Behavior on scale {

			NumberAnimation {
				duration: 1000;
				easing.type: Easing.OutBack;
			}
		}

		SequentialAnimation {
			running: true

			ParallelAnimation {

				NumberAnimation {
					target: imageSource;
					property: 'scale';
					duration: 1000;
					easing.type: Easing.OutBack;
					from: 0;
					to: 1;
				}

				NumberAnimation {
					target: effect;
					property: 'opacity';
					duration: 1000;
					easing.type: Easing.OutCubic;
					from: 0;
					to: 1;
				}

				NumberAnimation {
					target: imageSource;
					property: 'opacity';
					duration: 1000;
					easing.type: Easing.OutCubic;
					from: 0;
					to: 1;
				}
			}

			
		}
	}

	ShaderEffect {
		id: effect;
		anchors.fill: imageSource;

		property variant source: imageSource;

		fragmentShader: "
		varying highp vec2 qt_TexCoord0;
		uniform lowp sampler2D source;
		void main() {
			gl_FragColor = texture2D(source, qt_TexCoord0);
		}"
	}

	Timer {
		interval: 2000;
		running: true;
		repeat: false;
		onTriggered: {
			effect.visible = false;
			imageSource.scale = 0.7;
			logo.anchors.centerIn = undefined;
			logo.state = 'normal';
			finished();
		}
	}

	states: [
		State {
			name: 'normal';

			AnchorChanges {
				target: logo;
				anchors.top: logo.parent.top
				anchors.right: logo.parent.right
			}
		}
	]

	transitions: Transition {

		SequentialAnimation {

			AnchorAnimation {
				duration: 800;
				easing.type: Easing.OutBack;
			}
		}
	}
}
