import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.1
import QtGraphicalEffects 1.0
import QtQuick.Particles 2.0
//import Qt3D 2.0
//import Qt3D.Shapes 2.0

ApplicationWindow {
	id: app;
	visible: true;
	color: '#dd000000';
	width: 1024;
	height: 768;
//	visibility: Window.FullScreen;
	title: 'Hankathon';

	Item {
		focus: true;
		Keys.onPressed: {
			switch(event.key) {
			case Qt.Key_Left:
				timerPanel.setFocus();
				break;

			case Qt.Key_Right:
				timerPanel.anchors.centerIn = undefined;
				timerPanel.minimize();
				break;

			case Qt.Key_F:
				if (app.visibility != Window.FullScreen)
					app.visibility = Window.FullScreen;
				else
					app.visibility = Window.Windowed;
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

	Core {
		id: core;
		circleSize: parent.height * 0.2;
		anchors.bottom: parent.bottom;
		anchors.right: parent.right;
		anchors.bottomMargin: parent.height * 0.05;
		anchors.rightMargin: parent.width * 0.05;
		visible: (clock.state == 'normal');
	}

	Clock {
		id: clock;
		property int baseSize: parent.height * 0.5;
		anchors.centerIn: parent;
		anchors.margins: parent.width * 0.05;
		height: parent.height * 0.5;
		width: height;
		visible: false;
		onFinished: {
			clock.width = Qt.binding(function() {
				return clock.baseSize * 0.4;
			});
			clock.height = Qt.binding(function() {
				return clock.baseSize * 0.4;
			});
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

			//timerPanel.anchors.centerIn = undefined;
			//timerPanel.minimize();
		}
		onTimeout: {
			timerPanel.anchors.centerIn = parent;
			messageBox.color = '#33ff1111';
			timerPanel.setFocus();
			timerPanel.state = 'timesup';
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

				PropertyChanges {
					target: timerPanel;
					width: timerPanel.baseSize;
					height: timerPanel.baseSize;
				}

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
			timerPanel.state = 'minimize';
		}

		function setFocus() {
			timerPanel.state = 'focus';
		}
	}

	/* Side circle */
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

			ParallelAnimation {
				loops: Animation.Infinite;
				running: core.visible;

				SequentialAnimation {

					NumberAnimation {
						target: centerCircle;
						property: 'scale';
						duration: 400;
						easing.type: Easing.OutBack;
						to: 1;
					}

					NumberAnimation {
						target: centerCircle;
						property: 'scale';
						duration: 1600;
						easing.type: Easing.OutCubic;
						to: 0.8;
					}
				}

				SequentialAnimation {

					NumberAnimation {
						target: centerCircle;
						property: 'opacity';
						duration: 600;
						easing.type: Easing.OutCubic;
						to: 0.2;
					}

					NumberAnimation {
						target: centerCircle;
						property: 'opacity';
						duration: 1400;
						easing.type: Easing.OutCubic;
						to: 0.05;
					}
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

			layer.enabled: true;
			layer.effect: Glow {
				radius: 8;
				samples: 16;
				spread: 0.5;
				cached: true;
				color: '#33aaff';
			}

			ParallelAnimation {
				loops: Animation.Infinite;
				running: core.visible;

				SequentialAnimation {

					NumberAnimation {
						target: spinner1;
						property: 'border';
						duration: 1000;
						easing.type: Easing.OutBack;
						to: spinner1.circleSize * 0.12;
					}

					PauseAnimation {
						duration: 2000;
					}

					NumberAnimation {
						target: spinner1;
						property: 'border';
						duration: 1000;
						easing.type: Easing.OutBack;
						to: spinner1.circleSize * 0.1;
					}

					PauseAnimation {
						duration: 1000;
					}
				}

				SequentialAnimation {

					NumberAnimation {
						target: spinner1;
						property: 'opacity';
						duration: 1000;
						easing.type: Easing.OutBack;
						to: 0.3;
					}

					PauseAnimation {
						duration: 2000;
					}

					NumberAnimation {
						target: spinner1;
						property: 'opacity';
						duration: 1000;
						easing.type: Easing.OutBack;
						to: 0.1;
					}

					PauseAnimation {
						duration: 1000;
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

			SequentialAnimation {
				loops: Animation.Infinite;
				running: core.visible;

				NumberAnimation {
					target: spinner2;
					property: 'scale';
					duration: 1000;
					easing.type: Easing.OutBack;
					to: 0.9;
				}

				NumberAnimation {
					target: spinner2;
					property: 'scale';
					duration: 1600;
					easing.type: Easing.OutCubic;
					to: 1;
				}

				PauseAnimation {
					duration: 1000;
				}

				NumberAnimation {
					target: spinner2;
					property: 'scale';
					duration: 600;
					easing.type: Easing.OutBack;
					to: 1.4;
				}

				PauseAnimation {
					duration: 2000;
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
						duration: 5000;
						easing.type: Easing.OutCubic;
						to: 0;
					}
				}
			}

			SequentialAnimation {
				loops: Animation.Infinite;
				running: core.visible;

				NumberAnimation {
					target: spinner3;
					property: 'scale';
					duration: 1000;
					easing.type: Easing.OutBack;
					to: 0.9;
				}

				NumberAnimation {
					target: spinner3;
					property: 'scale';
					duration: 1600;
					easing.type: Easing.OutCubic;
					to: 1;
				}

				PauseAnimation {
					duration: 1000;
				}

				NumberAnimation {
					target: spinner3;
					property: 'scale';
					duration: 600;
					easing.type: Easing.OutBack;
					to: 1.5;
				}

				PauseAnimation {
					duration: 2000;
				}
			}
		}
	}


	IRC {
		id: irc;

		height: app.height * 0.4;
		anchors.margins: 10;
		anchors.bottom: parent.bottom;
		anchors.left: parent.left;
	}

	signal readyForIRC();
	signal updatedIRC(var msg);

	onUpdatedIRC: {
//		ircBox.text = msg;
		irc.ircTextbox.model.append({
			msg: msg
		});
		irc.ircTextbox.positionViewAtEnd();
	}
}
