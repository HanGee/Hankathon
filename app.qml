import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.1

ApplicationWindow {
	visible: true;
	color: '#000000';
	width: 1024;
	height: 768;
//	visibility: Window.FullScreen;

	FontLoader {
		id: numberFont;
		source: 'fonts/aldrich.regular.ttf';
	}

	Item {
		anchors.fill: parent;

		Text {
			id: hour;
			anchors.centerIn: parent;
			font.pointSize: 200;
			font.family: numberFont.name;
			font.bold: true;
			color: '#ffffff';
			horizontalAlignment: Text.AlignHCenter;
			verticalAlignment: Text.AlignVCenter;
			smooth: true;
			visible: true;
			text: timer.hour;
		}

		Text {
			id: minute;
			anchors.top: hour.bottom;
			anchors.horizontalCenter: hour.horizontalCenter;
			font.pointSize: 48;
			font.family: numberFont.name;
			font.bold: true;
			color: '#ffffff';
			horizontalAlignment: Text.AlignHCenter;
			verticalAlignment: Text.AlignVCenter;
			smooth: true;
			visible: true;
			text: timer.minute;
		}

		Text {
			anchors.top: minute.top;
			anchors.left: minute.right;
			font.pointSize: 48;
			font.family: numberFont.name;
			font.bold: true;
			color: '#ffffff';
			horizontalAlignment: Text.AlignHCenter;
			verticalAlignment: Text.AlignVCenter;
			smooth: true;
			visible: true;
			text: timer.second;
		}

		Text {
			anchors.top: minute.bottom;
			anchors.horizontalCenter: hour.horizontalCenter;
			font.pointSize: 20;
			font.family: numberFont.name;
			font.bold: true;
			color: '#ffffff';
			horizontalAlignment: Text.AlignHCenter;
			verticalAlignment: Text.AlignVCenter;
			smooth: true;
			visible: true;
			text: timer.millisecond;
		}
	}

	Item {
		height: parent.height;
		width: height;
		anchors.centerIn: parent;

		Spinner {
			property int circleSize: parent.height * 0.68;

			width: circleSize;
			height: circleSize;
			anchors.centerIn: parent;
			anchors.margins: width * 0.1;
			angleMarginFactor: 1;
			count: 15;
			border: 25;
			color: '#00e0d0';
			duration: 3000;
			opacity: 0.8;
		}

		Spinner {
			property int circleSize: parent.height * 0.85;

			width: circleSize;
			height: circleSize;
			anchors.centerIn: parent;
			anchors.margins: width * 0.1;
			angleMarginFactor: 0.5;
			count: 10;
			border: 60;
			color: '#55eeff';
			duration: 5000;
			from: 360;
			to: 0;
		}

		Circle {
			property int circleSize: parent.height * 0.95;
			width: circleSize;
			height: circleSize;
			anchors.centerIn: parent;
			anchors.margins: width * 0.1;
			color: '#ffffff';
			border: 20;
			opacity: 0.2;
		}

		Circle {
			property int circleSize: parent.height * 0.95;
			width: circleSize;
			height: circleSize;
			anchors.centerIn: parent;
			anchors.margins: width * 0.1;
			color: '#33bbff';
			border: 5;
			opacity: 0.5;
		}

		Spinner {
			property int circleSize: parent.height * 0.95;

			width: circleSize;
			height: circleSize;
			anchors.centerIn: parent;
			anchors.margins: width * 0.1;
			angleMarginFactor: 1;
			count: 2;
			border: 45;
			color: '#33aaff';
			duration: 2000;
			from: 360;
			to: 0;
			easingType: Easing.OutQuad;
			opacity: 0.5;
		}
	}

	CountdownTimer {
		id: timer;
		running: true;
	}

}
