import QtQuick 2.3
import QtQuick.Particles 2.0
import QtGraphicalEffects 1.0

Item {
	id: timerPanel;
	visible: false;

	signal finished();
	signal timeout();

	Item {
		id: display;
		anchors.fill: parent;
/*
		layer.enabled: true;
		layer.effect: HueSaturation {
			source: display
			hue: 0
			saturation: -0.2
			lightness: 0
		}
*/

		layer.enabled: false;
		layer.smooth: true;
		layer.mipmap: true;
		layer.effect: Colorize {
			id: colorizeEffect;
			cached: true;
			hue: display.hue;
			saturation: display.saturation;
			lightness: display.lightness;
		}

		property real saturation: 0;
		property real lightness: 0;
		property real hue: 0;

		Polygon {
			id: core;
			property int circleSize: parent.height * 0.6;
			width: circleSize;
			height: circleSize;
			anchors.centerIn: parent;
			color: '#00eedd';
			edge: 6;
			edgeOffset: 3;
			border: 5;
			opacity: 0.3;

			transform: Rotation {
				origin.x: core.width * 0.5;
				origin.y: core.height * 0.5;
				angle: 0;

				SequentialAnimation on angle {
					loops: Animation.Infinite
					running: timerPanel.visible;

					NumberAnimation {
						duration: 2000;
						easing.type: Easing.Linear;
						from: 0;
						to: 360;
					}
				}
			}
		}

		Spinner {
			property int circleSize: parent.height * 0.6;

			width: circleSize;
			height: circleSize;
			anchors.centerIn: parent;
			angleMarginFactor: 40;
			count: 60;
			border: circleSize * 0.1;
			color: '#00e0d0';
			duration: 3000;
			opacity: 0.5;
		}

		Spinner {
			property int circleSize: parent.height * 0.68;

			width: circleSize;
			height: circleSize;
			anchors.centerIn: parent;
			angleMarginFactor: 1;
			count: 15;
			border: circleSize * 0.05;
			color: '#00e0d0';
			duration: 3000;
			opacity: 0.8;
		}

		Spinner {
			property int circleSize: parent.height * 0.705;
			width: circleSize;
			height: circleSize;
			anchors.centerIn: parent;
			color: '#ffffff';
			angleMarginFactor: 1;
			count: 3;
			border: circleSize * 0.01;
			duration: 2000;
			opacity: 0.5;
			from: 360;
			to: 0;
		}

		Circle {
			property int circleSize: parent.height * 0.6;
			width: circleSize;
			height: circleSize;
			anchors.centerIn: parent;
			color: '#ffffff';
			border: circleSize * 0.01;
			opacity: 0.1;
		}

		Circle {
			property int circleSize: parent.height * 0.87;
			width: circleSize;
			height: circleSize;
			anchors.centerIn: parent;
			color: '#55eeff';
			border: circleSize * 0.1;
			opacity: 0.2;
		}

		Spinner {
			property int circleSize: parent.height * 0.77;

			width: circleSize;
			height: circleSize;
			anchors.centerIn: parent;
			angleMarginFactor: 1;
			count: 2;
			//border: circleSize * 0.04;
			border: circleSize * 0.2;
			color: '#55bbff';
			duration: 4000;
			from: 360;
			to: 0;
			opacity: 0.2;
		}

		Spinner {
			property int circleSize: parent.height * 0.85;

			width: circleSize;
			height: circleSize;
			anchors.centerIn: parent;
			angleMarginFactor: 0.5;
			count: 8;
			border: circleSize * 0.08;
			//color: '#55eeff';
			color: '#00ffff';
			duration: 5000;
			from: 360;
			to: 0;
		}

		Circle {
			property int circleSize: parent.height * 0.95;

			width: circleSize;
			height: circleSize;
			anchors.centerIn: parent;

			color: '#11bbff';
			border: circleSize * 0.05;
			opacity: 0.5;
			useGradient: true;

			Circle {
				anchors.fill: parent;
				color: '#ffffff';
				border: parent.circleSize * 0.004;
				opacity: 0.1;
			}

			SequentialAnimation on scale {
				running: timerPanel.visible;

				NumberAnimation {
					duration: 600;
					easing.type: Easing.OutCubic;
					from: 0;
					to: 1.2;
				}

				NumberAnimation {
					duration: 1000;
					easing.type: Easing.OutBack;
					to: 1;
				}
			}
		}

		Spinner {
			id: shield;
			property int circleSize: parent.height;

			width: circleSize;
			height: circleSize;
			anchors.centerIn: parent;
			angleMarginFactor: 1;
			count: 2;
			border: circleSize * 0.07;
			color: '#33aaff';
			duration: 2000;
			from: 0;
			to: 360;
			easingType: Easing.OutQuad;
			opacity: 0.5;
/*
			layer.enabled: true;
			layer.smooth: true;
			layer.effect: NeonEffect {
				color: '#33aaff';
				source: shield;
			}
*/
		}

		ParticleSystem {
			id: sys1
			running: timerPanel.visible;
		}

		ImageParticle {
			system: sys1
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
			id: trailsNormal
			system: sys1

			emitRate: 500
			lifeSpan: 1500

			y: circlePath.cy
			x: circlePath.cx

			velocity: PointDirection { xVariation: 4; yVariation: 4; }
			acceleration: PointDirection {xVariation: 10; yVariation: 10;}
			velocityFromMovement: 0.1

			size: 4;
			sizeVariation: 8

			enabled: timerPanel.visible;
		}

		Item {
			id: circlePath
			property int circleSize: parent.height * 0.1;
			property int interval: 800;
			property real radius: circleSize * 0.5;
			property real dx: parent.width / 2
			property real dy: parent.height / 2
			property real cx: radius * Math.sin(percent * 6.283185307179) + dx
			property real cy: radius * Math.cos(percent * 6.283185307179) + dy
			property real percent: 0

			SequentialAnimation on percent {
				loops: Animation.Infinite
				running: timerPanel.visible;

				NumberAnimation {
					duration: circlePath.interval;
					from: 360;
					to: 0
					loops: 8
				}
			}
		}
	}

	Item {
		id: textStyle;
		anchors.fill: parent;
//		visible: false;

		property real baseSize: Math.floor(parent.height * 0.2) || 200;
/*
		layer.enabled: true;
		layer.effect: Glow {
			radius: 8;
			samples: 16;
			transparentBorder: true;
			spread: 0.2;
			cached: true;
			color: '#33aaff';
			source: textStyle;
		}
*/

		Item {
			id: textDisplay
			anchors.centerIn: parent;

			Text {
				anchors.margins: textStyle.baseSize * 0.1;
				anchors.bottom: hour.top;
				anchors.horizontalCenter: hour.horizontalCenter;
				font.pointSize: textStyle.baseSize * 0.15;
				font.family: numberFont.name;
	//			font.bold: true;
				color: '#ffffff';
				horizontalAlignment: Text.AlignHCenter;
				verticalAlignment: Text.AlignVCenter;
				text: '剩餘時間';
			}

			Text {
				id: hour;
				anchors.centerIn: parent;
				font.pointSize: textStyle.baseSize;
				font.family: numberFont.name;
				font.bold: true;
				color: '#55eeff';
				horizontalAlignment: Text.AlignHCenter;
				verticalAlignment: Text.AlignVCenter;
				text: timer.hour;
			}

			Text {
				id: minute;
				anchors.top: hour.bottom;
				anchors.right: hour.horizontalCenter;
				anchors.margins: textStyle.baseSize * 0.05;
				font.pointSize: textStyle.baseSize * 0.25;
				font.family: numberFont.name;
	//			font.bold: true;
				color: '#ffffff';
				horizontalAlignment: Text.AlignHCenter;
				verticalAlignment: Text.AlignVCenter;
				text: timer.minute;
			}

			Text {
				anchors.top: hour.bottom;
				anchors.left: hour.horizontalCenter;
				anchors.margins: textStyle.baseSize * 0.05;
				font.pointSize: textStyle.baseSize * 0.25;
				font.family: numberFont.name;
	//			font.bold: true;
				color: '#ffffff';
				horizontalAlignment: Text.AlignHCenter;
				verticalAlignment: Text.AlignVCenter;
				text: timer.second;
			}

			Text {
				anchors.top: minute.bottom;
				anchors.horizontalCenter: hour.horizontalCenter;
				font.pointSize: textStyle.baseSize * 0.15;
				font.family: numberFont.name;
	//			font.bold: true;
				color: '#ffffff';
				horizontalAlignment: Text.AlignHCenter;
				verticalAlignment: Text.AlignVCenter;
				text: timer.millisecond;
			}
		}

		SequentialAnimation on scale {
			running: timerPanel.visible;

			NumberAnimation {
				duration: 1000;
				easing.type: Easing.OutBack;
				from: 0;
				to: 1;
			}
		}

		SequentialAnimation on opacity {
			running: timerPanel.visible;

			NumberAnimation {
				duration: 1000;
				easing.type: Easing.OutCubic;
				from: 0;
				to: 1;
			}
		}

		// Display Time's up
		Item {
			anchors.fill: parent;
			visible: (timerPanel.state == 'timesup')

			Text {
				id: timerPanelTitle;
				anchors.centerIn: parent;
				font.pointSize: textStyle.baseSize * 0.8;
				font.family: numberFont.name;
				font.bold: true;
				color: '#ffffff';
				horizontalAlignment: Text.AlignHCenter;
				verticalAlignment: Text.AlignVCenter;
				text: '時間到';
			}

			Text {
				anchors.top: timerPanelTitle.bottom;
				anchors.horizontalCenter: timerPanelTitle.horizontalCenter;
				font.pointSize: textStyle.baseSize * 0.3;
				font.family: numberFont.name;
				font.bold: true;
				color: '#ffffff';
				horizontalAlignment: Text.AlignHCenter;
				verticalAlignment: Text.AlignVCenter;
				text: 'Time\'s Up';
			}
		}
	}

	Timer {
		interval: 1000;
		running: timerPanel.visible;
		repeat: false;
		onTriggered: {
			finished();
			trailsNormal.enabled = false;
		}
	}

	Behavior on width {

		NumberAnimation {
			duration: 800;
			easing.type: Easing.OutCubic;
		}
	}

	Behavior on height {

		NumberAnimation {
			duration: 800;
			easing.type: Easing.OutCubic;
		}
	}

	Behavior on opacity {

		NumberAnimation {
			duration: 400;
			easing.type: Easing.OutCubic;
		}
	}

	CountdownTimer {
		id: timer;
		running: timerPanel.visible;
		onLastHour: {
			hour.color = '#ff5555';
			display.hue = 0.0;
			display.saturation = 1;
			display.lightness = 0.1;
			display.layer.enabled = true;
		}

		onTimeout: {
			hour.color = '#ff5555';
			display.hue = 0.0;
			display.saturation = 1;
			display.lightness = 0.1;
			display.layer.enabled = true;
			trailsNormal.enabled = false;
			timerPanel.timeout();
		}
	}

	states: [
		State {
			name: 'normal';

			ParentChange {
				target: timerPanel;
				parent: timerPanel.parent;
			}

			AnchorChanges {
				target: timerPanel;
				anchors.top: clock.bottom
				anchors.left: clock.left
				anchors.horizontalCenter: undefined;
				anchors.verticalCenter: undefined;
			}
		},
		State {
			name: 'hide';

			PropertyChanges {
				target: timerPanel;
				opacity: 0;
			}
		},
		State {
			name: 'timesup';

			PropertyChanges {
				target: display;
				opacity: 0;
			}

			PropertyChanges {
				target: textDisplay;
				opacity: 0;
			}

			AnchorChanges {
				target: timerPanel;
				anchors.top: undefined;
				anchors.left: undefined;
			}
		}
	]

	transitions: Transition {

		AnchorAnimation {
			duration: 600;
			easing.type: Easing.OutCubic;
		}
	}
}
