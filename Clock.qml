import QtQuick 2.3
import QtGraphicalEffects 1.0

Item {
	id: clock;

	property date curDate: new Date();
	property var hour: '00';
	property var minute: '00';
	property var second: '00';

	signal finished();

	Item {
		anchors.fill: parent;
		property real baseSize: parent.height;

		Spinner {
			width: parent.baseSize * 0.54;
			height: width;
			anchors.centerIn: parent;
			angleMarginFactor: 30;
			count: 60;
			border: parent.baseSize * 0.05;
			//color: '#aaeeff';
			color: '#ee1111';
			//opacity: 0.5;
			opacity: 0.8;
			duration: 5000;
		}

		Circle {
			width: parent.baseSize * 0.54;
			height: width;
			anchors.centerIn: parent;

			//color: '#11bbff';
			color: '#ff1111';
			border: parent.baseSize * 0.1;
			//opacity: 0.5;
			opacity: 0.7;
			useGradient: true;

			SequentialAnimation on scale {
				running: clock.visible;

				NumberAnimation {
					duration: 600;
					easing.type: Easing.OutCubic;
					from: 0;
					to: 1.5;
				}

				NumberAnimation {
					duration: 1000;
					easing.type: Easing.OutBack;
					to: 1;
				}
			}
		}

		Spinner {
			width: parent.baseSize * 0.59;
			height: width;
			anchors.centerIn: parent;
			angleMarginFactor: 0.5;
			count: 10;
			border: parent.baseSize * 0.016;
			//color: '#55ddff';
			color: '#ff5555';
			opacity: 0.5;
			duration: 3000;
		}

		Spinner {
			width: parent.baseSize * 0.8;
			height: width;
			anchors.centerIn: parent;
			//angleMarginFactor: 1;
			//count: 12;
			angleMarginFactor: 30;
			count: 60;
			border: parent.baseSize * 0.1;
			//color: '#00ffff';
			//color: '#eecc55';
			color: '#ffcc00';
			opacity: 0.9;
			duration: 8000;
			from: 360;
			to: 0;
		}

		Circle {
			width: parent.baseSize * 0.84;
			height: width;
			anchors.centerIn: parent;

			//color: '#11bbff';
			color: '#cc2200';
			border: parent.baseSize * 0.01;
			//opacity: 0.5;
			opacity: 0.7;
//			useGradient: true;

			SequentialAnimation on scale {
				running: clock.visible;

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
			width: parent.baseSize * 0.9;
			height: width;
			anchors.centerIn: parent;
			angleMarginFactor: 1.2;
			count: 2;
			border: parent.baseSize * 0.02;
			//color: '#ffffff';
			//color: '#ffcc00';
			color: '#eecc55';
			//opacity: 1;
			opacity: 1;
			duration: 1500;
		}

		Spinner {
			width: parent.baseSize;
			height: width;
			anchors.centerIn: parent;
			angleMarginFactor: 1;
			count: 3;
			border: parent.baseSize * 0.02;
			//color: '#ffffff';
			color: '#ffaa00';
			//opacity: 0.2;
			opacity: 0.2;
			duration: 2000;
		}
	}

	Item {
		id: textStyle;
		anchors.fill: parent;

		property real baseSize: Math.floor(parent.height * 0.2) || 200;

		Text {
			id: sep;
			anchors.centerIn: parent;
			font.pointSize: textStyle.baseSize * 0.8;
			font.family: numberFont.name;
			color: '#ffffff';
			text: ':';
		}

		Text {
			anchors.right: sep.left;
			anchors.verticalCenter: sep.verticalCenter;
			font.pointSize: textStyle.baseSize * 0.8;
			font.family: numberFont.name;
			font.bold: true;
			color: '#ffffff';
			text: hour;
		}

		Text {
			anchors.left: sep.right;
			anchors.verticalCenter: sep.verticalCenter;
			font.pointSize: textStyle.baseSize * 0.8;
			font.family: numberFont.name;
			font.bold: true;
			color: '#ffffff';
			text: minute;
		}

		Text {
			anchors.top: sep.bottom;
			anchors.horizontalCenter: sep.horizontalCenter;
			font.pointSize: textStyle.baseSize * 0.5;
			font.family: numberFont.name;
			color: '#ffffff';
			text: second;
		}

		SequentialAnimation on scale {
			running: clock.visible;

			NumberAnimation {
				duration: 1000;
				easing.type: Easing.OutBack;
				from: 0;
				to: 1;
			}
		}

		SequentialAnimation on opacity {
			running: clock.visible;

			NumberAnimation {
				duration: 1000;
				easing.type: Easing.OutCubic;
				from: 0;
				to: 1;
			}
		}
	}

	Timer {
		interval: 500;
		repeat: true;
		running: true;
		onTriggered: {
			curDate = new Date;
			hour = Qt.formatTime(curDate, 'hh');
			minute = Qt.formatTime(curDate, 'mm');
			second = Qt.formatTime(curDate, 'ss');
		}
	}

	Timer {
		interval: 1500;
		running: clock.visible;
		repeat: false;
		onTriggered: {
			finished();
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

	states: [
		State {
			name: 'normal';

			AnchorChanges {
				target: clock;
				anchors.top: clock.parent.top
				anchors.left: clock.parent.left
			}
		}
	]

	transitions: Transition {

		SequentialAnimation {

			AnchorAnimation {
				duration: 600;
				easing.type: Easing.OutCubic;
			}
		}
	}
}
