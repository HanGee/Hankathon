import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.1
import QtGraphicalEffects 1.0
import QtQuick.Particles 2.0
//import 'slides/social'
/*
import Qt3D 2.0
import Qt3D.Shapes 2.0
*/
ApplicationWindow {
	id: app;
	visible: true;
	color: '#dd000000';
	width: 1024;
	height: 768;
//	visibility: Window.FullScreen;
	title: 'Hankathon';

	signal readyForIRC();

	Item {
		focus: true;
		Keys.onPressed: {
			switch(event.key) {
			case Qt.Key_Left:
				timerPanel.state = 'focus';
				//timerPanel.setFocus();
				break;

			case Qt.Key_Right:
				timerPanel.state = 'minimize';
				//timerPanel.minimize();
				break;

			case Qt.Key_F:
				app.visibility = Window.FullScreen;
				break;

			case Qt.Key_G:
				logo.visible = true;
				break;
			}
		}
	}

	FontLoader {
		id: numberFont;
		source: 'fonts/aldrich.regular.ttf';
	}

	Rectangle {
		id: messageBox;
		width: parent.width * 0.7;
		height: parent.height * 0.7;
		anchors.centerIn: parent;
		color: '#1111ffff';
		radius: parent.width * 0.01;

		layer.enabled: true;
		layer.smooth: true;
		layer.effect: FastBlur {
			cached: true;
			source: messageBox;
			transparentBorder: true;
			radius: 64
		}
	}
/*
	Text {
		anchors.centerIn: parent;
		font.pointSize: 36;
		font.family: numberFont.name;
		font.bold: true;
		color: '#ffffff';
		text: 'Hackathon Taiwan\n這次將於 3/7、3/8 舉行！\n\n這是現場的倒數計時器程式測試！\nXDDDD';
	}
*/

	Logo {
		id: logo;
		anchors.centerIn: parent;
		width: parent.width * 0.15;
		height: parent.height * 0.15;
		visible: false;

		onFinished: {
		}

		Timer {
			interval: 1000;
			running: (parent.state == 'normal');
			repeat: false;
			onTriggered: {
				clock.visible = true;
				app.readyForIRC();
			}
		}
	}

	Item {
		id: core;
		property int circleSize: parent.height * 0.2;

		width: circleSize;
		height: circleSize;
		anchors.bottom: parent.bottom;
		anchors.right: parent.right;
		anchors.bottomMargin: parent.height * 0.05;
		anchors.rightMargin: parent.width * 0.05;
		visible: (clock.state == 'normal');

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
			id: sys1
			running: core.visible;
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

			enabled: true;
		}

		Item {
			id: circlePath
			property int circleSize: parent.height * 0.5;
			property int interval: 800;
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
					duration: circlePath.interval;
					from: 360;
					to: 0
					loops: 8
				}
			}
		}
	}

	Clock {
		id: clock;
		anchors.centerIn: parent;
		anchors.margins: parent.width * 0.05;
		height: parent.height * 0.5;
		width: height;
		visible: false;
		onFinished: {
			clock.width *= 0.4;
			clock.height *= 0.4;
			clock.anchors.centerIn = undefined;
			clock.state = 'normal';
		}
	}

	TimerPanel {
		property int baseSize: parent.height * 0.5;
		id: timerPanel;
		anchors.centerIn: parent;
		height: baseSize;
		width: height;
		visible: (clock.state == 'normal');
		onFinished: {
			if (timerPanel.state)
				return;
/*
			timerPanel.width *= 0.4;
			timerPanel.height *= 0.4;
*/
			timerPanel.anchors.centerIn = undefined;
			timerPanel.state = 'minimize';
			timerPanel.minimize();
			console.log('11');
		}
		onTimeout: {
//			timerPanel.width = parent.height * 0.5;
//			timerPanel.height = timerPanel.width;
			timerPanel.anchors.centerIn = parent;
			messageBox.color = '#33ff1111';
			timerPanel.state = 'timesup';
//			console.log('TIMESUP');
		}

		states: [
			State {
				name: 'minimize';
				extend: 'normal';

				PropertyChanges {
					target: timerPanel;
					width: timerPanel.baseSize * 0.4;
					height: timerPanel.baseSize * 0.4;
				}
			},
			State {
				name: 'focus';
/*
				PropertyChanges {
					target: timerPanel;
					width: timerPanel.baseSize;
					height: timerPanel.baseSize;
				}
*/
				AnchorChanges {
					target: timerPanel;
					anchors.top: undefined;
					anchors.left: undefined;
					anchors.horizontalCenter: timerPanel.parent.horizontalCenter;
					anchors.verticalCenter: timerPanel.parent.verticalCenter;
				}
			},
			State {
				name: 'timesup';
			}
		]

		function minimize() {
			this.width = this.baseSize * 0.4;
			this.height = this.baseSize * 0.4;
		}

		function setFocus() {
			this.width = this.baseSize;
			this.height = this.baseSize;
		}
	}

	Item {
		anchors.fill: parent;
		visible: core.visible;

		NumberAnimation on opacity {
			running: core.visible;
			duration: 2000;
			easing.type: Easing.OutCubic;
			from: 0;
			to: 1;
		}

		Spinner {
			property int circleSize: parent.height * 0.5;
			width: circleSize;
			height: circleSize;
			anchors.centerIn: parent;
			anchors.horizontalCenterOffset: circleSize * 0.8;
			anchors.verticalCenterOffset: -circleSize * 0.8;
			color: '#ffffff';
			border: circleSize * 0.02;
			opacity: 0.2;

			angleMarginFactor: 1;
			count: 3;
			duration: 4000;
			from: 360;
			to: 0;
			easingType: Easing.OutQuad;
		}

		Circle {
			property int circleSize: parent.height * 0.5;
			width: circleSize;
			height: circleSize;
			anchors.centerIn: parent;
			anchors.horizontalCenterOffset: circleSize * 0.8;
			anchors.verticalCenterOffset: -circleSize * 0.8;
			color: '#ffffff';
			border: circleSize * 0.005;
			opacity: 0.2;
		}

		Circle {
			id: centerCircle;
			property int circleSize: parent.height * 0.75;
			width: circleSize;
			height: circleSize;
			anchors.centerIn: parent;
			color: '#ffffff';
			border: circleSize * 0.005;
			opacity: 0.2;
			scale: 2;

			transform: Rotation {
				origin.x: centerCircle.width * 0.5;
				origin.y: centerCircle.height * 0.5;
				axis { x: 0; y: 1; z: 0 }
				angle: 90;

				SequentialAnimation on angle {
					running: core.visible

					NumberAnimation {
						duration: 2500;
						easing.type: Easing.OutCubic;
						to: 0;
					}
				}
			}

			SequentialAnimation on scale {
				running: core.visible;

				NumberAnimation {
					duration: 2000;
					easing.type: Easing.OutBack;
					to: 1;
				}
			}

			Circle {
				property int circleSize: parent.height * 0.98;
				width: circleSize;
				height: circleSize;
				anchors.centerIn: parent;
				color: '#ffffff';
				border: circleSize * 0.005;

				layer.enabled: true;
				layer.effect: Glow {
					radius: 4;
					samples: 16;
					spread: 0.1;
					cached: true;
					color: '#33aaff';
				}
			}
		}

		Spinner {
			id: spinner1;
			property int circleSize: parent.height * 0.7;
			width: circleSize;
			height: circleSize;
			anchors.centerIn: parent;
			color: '#ffffff';
			border: circleSize * 0.1;
			opacity: 0.1;
			angleMarginFactor: 9.5;
			count: 10;
			duration: 15000;
			from: 0;
			to: 360;
			easingType: Easing.OutInBounce;
			initialAnimation: false;

			transform: Rotation {
				origin.x: spinner1.width * 0.5;
				origin.y: spinner1.height * 0.5;
				axis { x: 0; y: 1; z: 0 }
				angle: 90;

				SequentialAnimation on angle {
					running: core.visible;


					NumberAnimation {
						duration: 2000;
						easing.type: Easing.OutCubic;
						to: 0;
					}
				}
			}
		}

		Spinner {
			id: spinner2;
			property int circleSize: parent.height * 0.65;
			width: circleSize;
			height: circleSize;
			anchors.centerIn: parent;
			color: '#ffffff';
			border: circleSize * 0.07;
			opacity: 0.1;
			angleMarginFactor: 45;
			count: 60;
			duration: 15000;
			from: 9;
			to: 369;
			easingType: Easing.OutInBounce;
			initialAnimation: false;

			transform: Rotation {
				origin.x: spinner2.width * 0.5;
				origin.y: spinner2.height * 0.5;
				axis { x: 0; y: 1; z: 0 }
				angle: 90;

				SequentialAnimation on angle {
					running: core.visible;

					NumberAnimation {
						duration: 2000;
						easing.type: Easing.OutCubic;
						to: 0;
					}
				}
			}
		}

		Spinner {
			id: spinner3;
			property int circleSize: parent.height * 0.60;
			width: circleSize;
			height: circleSize;
			anchors.centerIn: parent;
			color: '#ffffff';
			border: circleSize * 0.03;
			opacity: 0.1;
			angleMarginFactor: 45;
			count: 60;
			duration: 15000;
			from: 6;
			to: 366;
			easingType: Easing.OutInBounce;
			initialAnimation: false;

			transform: Rotation {
				origin.x: spinner3.width * 0.5;
				origin.y: spinner3.height * 0.5;
				axis { x: 0; y: 1; z: 0 }
				angle: 90;

				SequentialAnimation on angle {
					running: core.visible;

					NumberAnimation {
						duration: 2000;
						easing.type: Easing.OutCubic;
						to: 0;
					}
				}
			}
		}
	}
/*
	Social {
		anchors.fill: parent;		
	}
*/
/*
	SponsorSlider {
		anchors.left: parent.left;
		anchors.right: parent.right;
		anchors.bottom: parent.bottom;
		height: 100;

		list: ListModel {
			ListElement {
				imagePath: './logo/HanGee.jpg';
			}
			ListElement {
				imagePath: './logo/AvengerGear.jpg';
			}
			ListElement {
				imagePath: './logo/CustardCream.jpg';
			}
			ListElement {
				imagePath: './logo/TaiwanLD.jpg';
			}
			ListElement {
				imagePath: './logo/DOITT.png';
			}
		}
	}
*/
/*
	SponsorSlider {
		anchors.left: parent.left;
		anchors.right: parent.right;
		anchors.bottom: parent.bottom;
		height: 100;

		list: ListModel {
			ListElement {
				imagePath: './logo/netgear.png';
			}
			ListElement {
				imagePath: './logo/vivotek.jpg'
			}
			ListElement {
				imagePath: './logo/pearnature.png'
			}
			ListElement {
				imagePath: './logo/qt.png';
			}
		}
	}
*/

	signal updatedIRC(var msg);

	Rectangle {
		id: irc;
		color: '#0affffff';
		anchors.margins: 10;
		anchors.bottom: parent.bottom;
		anchors.left: parent.left;
		width: 0;
		height: 50;
		radius: 10;
		border.width: 2;
		border.color: '#20ffffff';
		opacity: 0;

		layer.enabled: true;
		layer.effect: Glow {
			radius: 4;
			samples: 16;
			spread: 0.1;
			cached: true;
			color: '#33aaff';
		}

		ListView {
			id: ircBox;
			anchors.fill: parent;
			anchors.margins: 10;
			model: ListModel {}
			delegate: Item {
				height: label.height;

				Text {
					id: label;
					width: ircBox.width;
					color: '#ffffff';	
					font.pointSize: 10;
					wrapMode: Text.Wrap;
					textFormat: Text.RichText;
					text: msg;

					SequentialAnimation {
						running: true

						ParallelAnimation {

							NumberAnimation {
								target: label;
								property: 'x';
								duration: 300;
								easing.type: Easing.OutBack;
								from: 20;
								to: 0;
							}

							NumberAnimation {
								target: label;
								property: 'opacity';
								duration: 300;
								easing.type: Easing.Linear;
								from: 0;
								to: 1;
							}
						}
					}
				}
			}
		}

		SequentialAnimation {
			running: clock.visible

			ParallelAnimation {

				NumberAnimation {
					target: irc;
					property: 'width';
					duration: 600;
					easing.type: Easing.OutBack;
					to: app.height * 0.3;
				}

				NumberAnimation {
					target: irc;
					property: 'opacity';
					duration: 600;
					easing.type: Easing.Linear;
					to: 1;
				}
			}

			NumberAnimation {
				target: irc;
				property: 'height';
				duration: 500;
				easing.type: Easing.OutBack;
				to: app.height * 0.4;
			}

			NumberAnimation {
				target: irc;
				property: 'width';
				duration: 600;
				easing.type: Easing.OutBack;
				to: app.width * 0.4;
			}

			ParallelAnimation {

				NumberAnimation {
					target: ircInfo;
					property: 'x';
					duration: 600;
					easing.type: Easing.OutCubic;
					from: 200;
					to: 10;
				}

				NumberAnimation {
					target: ircInfo;
					property: 'opacity';
					duration: 600;
					easing.type: Easing.Linear;
					from: 0;
					to: 1;
				}

				NumberAnimation {
					target: ircBoxLabel;
					property: 'opacity';
					duration: 500;
					easing.type: Easing.OutInBounce;
					from: 0;
					to: 1;
					loops: 1;
				}
			}
		}
	}

	Item {
		anchors.left: irc.right;
		anchors.bottom: irc.bottom;

		Text {
			id: ircInfo
			anchors.margins: 10;
			anchors.bottom: parent.bottom;
			font.pointSize: 16;
			font.family: numberFont.name;
			textFormat: Text.RichText;
			//color: '#22bbff';
			//color: '#ffaa22';
			color: '#ffffff';
			text: '#HackathonTaiwan @ freenode<br>http://goo.gl/eoGTUZ'
			opacity: 0;

			layer.enabled: true;
			layer.effect: Glow {
				radius: 4;
				samples: 16;
				spread: 0.1;
				cached: true;
				color: '#33aaff';
			}
		}

		Rectangle {
			id: ircBoxLabel;
			width: labelText.width + 30; 
			height: labelText.height + 10; 
			anchors.bottom: ircInfo.top;
			anchors.margins: 10;
			color: '#aaf0ffff';
			opacity: 0;

			layer.enabled: true;
			layer.effect: Glow {
				radius: 3;
				samples: 16;
				spread: 0.1;
				cached: true;
				color: '#33aaff';
			}

			Text {
				anchors.centerIn: parent;
				id: labelText;
				font.pointSize: 16;
				font.family: numberFont.name;
				textFormat: Text.RichText;
				color: '#000000';
				text: '<b>IRC Channel</b>'

				layer.enabled: true;
				layer.effect: Glow {
					radius: 3;
					samples: 16;
					spread: 0.1;
					cached: true;
					color: '#ffffff';
				}
			}
		}
	}

	onUpdatedIRC: {
//		ircBox.text = msg;
		ircBox.model.append({
			msg: msg
		});
		ircBox.positionViewAtEnd();
	}
}
