import QtQuick 2.2

Item {

	property bool heating: false;
	property var expiration: '2014-09-21 18:00:00';
	property var expirationDate: new Date(expiration);
	property int hourMS: 60 * 60 * 1000;
	property int minuteMS: 60 * 1000;

	Timer {
		interval: 20;
		running: heating;
		repeat: true;

		onTriggered: {
			var dateObj = new Date();

			// Difference
			var diffMS = expirationDate.getTime() - dateObj.getTime();

			// Hour
			var diffHour = Math.floor(diffMS / hourMS);
			diffMS -= diffHour * hourMS;

			// Minute
			var diffMinute = Math.floor(diffMS / minuteMS);
			var minLabel = String('00' + parseInt(diffMinute).toString()).slice(-2);
			diffMS -= diffMinute * minuteMS;

			// Second
			var diffSecond = Math.floor(diffMS / 1000);
			var secLabel = String('00' + parseInt(diffSecond).toString()).slice(-2);
			diffMS -= diffSecond * 1000;

			if (timerHourDisplay.text || timerMinuteDisplay.text || timerSecondDisplay.text) {
				if (timerHourDisplay.text != diffHour || timerMinuteDisplay.text != minLabel || timerSecondDisplay.text != secLabel) {
					heatingAnimation.running = true;;
				}
			}


			timerHourDisplay.text = diffHour;
			timerMinuteDisplay.text = minLabel;
			timerSecondDisplay.text = secLabel;
			timerMillisecondDisplay.text = '.' + String('000' + parseInt(diffMS).toString()).slice(-3);
		}
	}

	Text {
		color: '#ffffff';
		text: 'HanGee x 萌典 x 黑客松';
		font.pointSize: Math.floor(parent.width * 0.03) || 60;
		opacity: 0.5;
		anchors.horizontalCenter: parent.horizontalCenter;
	}

	Rectangle {
		id: circle
		height: parent.height * 0.7;
		width: height;
		radius: width * 0.5;
		anchors.centerIn: parent;
		color: '#00000000';
		border.width: 30;
		border.color: '#333355';
	}

	Rectangle {
		id: subLevel;
		anchors.right: circle.right;
		anchors.bottom: circle.bottom;
		color: '#00000000';
		height: circle.height * 0.3;
		width: circle.width * 0.9;
	}

	Rectangle {
		id: timerSpinner;
		anchors.rightMargin: circle.width * 0.2;
		anchors.right: circle.right;
		anchors.bottom: subLevel.bottom;
		color: '#000000';
		width: subLevel.width * 0.2;
		height: circle.height * 0.15;
		radius: width * 0.4;
		border.width: 10;
		border.color: '#36FBDA';
	}

	Text {
		color: '#aaaaaa';
		text: '剩餘時間';
		font.pointSize: Math.floor(circle.width * 0.05) || 60;
		font.capitalization: Font.AllUppercase;
		anchors.top: circle.top;
		anchors.topMargin: circle.height * 0.1;
		anchors.horizontalCenter: circle.horizontalCenter;
	}

	Text {
		id: timerHourDisplay
		anchors.left: circle.left;
		anchors.leftMargin: circle.width * 0.1;
		anchors.top: circle.top;
		anchors.topMargin: circle.height * 0.1;
		font.pointSize: Math.floor(circle.width * 0.5) || 200;
		font.family: numberFont.name;
		font.bold: true;
		color: '#ffffff';
		horizontalAlignment: Text.AlignHCenter;
		verticalAlignment: Text.AlignVCenter;
		smooth: true;
	}

	Text {
		id: timerMinuteDisplay
		font.pointSize: subLevel.height * 0.4 || 60;
		font.family: numberFont.name;
		font.bold: true;
		color: '#ffffff';
		opacity: 0.7;
		horizontalAlignment: Text.AlignHCenter;
		verticalAlignment: Text.AlignVCenter;
		anchors.top: subLevel.top;
		anchors.right: subLevel.horizontalCenter;
		anchors.rightMargin: subLevel.width * 0.1;
	}

	Text {
		id: timerSecondDisplay
		font.pointSize: subLevel.height * 0.4 || 60;
		font.family: numberFont.name;
		font.bold: true;
		color: '#ffffff';
		opacity: 0.7;
		horizontalAlignment: Text.AlignHCenter;
		verticalAlignment: Text.AlignVCenter;
		anchors.top: subLevel.top;
		anchors.left: subLevel.horizontalCenter;
	}

	Text {
		id: timerMillisecondDisplay
		font.pointSize: timerSpinner.height * 0.4 || 30;
		font.family: numberFont.name;
		color: '#ffffff';
		horizontalAlignment: Text.AlignHCenter;
		verticalAlignment: Text.AlignVCenter;
		anchors.centerIn: timerSpinner;
	}
	
	Text {
		id: timerHourUnitDisplay
		font.pointSize: timerHourDisplay.font.pointSize * 0.1;
		font.bold: true;
		color: '#ffffff';
		horizontalAlignment: Text.AlignHCenter;
		verticalAlignment: Text.AlignVCenter;
		anchors.bottomMargin: timerHourDisplay.height * 0.15;
		anchors.bottom: timerHourDisplay.bottom;
		anchors.left: timerHourDisplay.right;
		text: '小時'
	}
	
	Text {
		id: timerMinuteUnitDisplay
		font.pointSize: 20;
		font.bold: true;
		color: '#ffffff';
		opacity: 0.7;
		horizontalAlignment: Text.AlignHCenter;
		verticalAlignment: Text.AlignVCenter;
		anchors.bottomMargin: timerMinuteDisplay.height * 0.1;
		anchors.bottom: timerMinuteDisplay.bottom;
		anchors.left: timerMinuteDisplay.right;
		anchors.leftMargin: timerMinuteDisplay.width * 0.1;
		text: '分'
	}
	
	Text {
		id: timerSecondUnitDisplay
		font.pointSize: 20;
		font.bold: true;
		color: '#ffffff';
		opacity: 0.7;
		horizontalAlignment: Text.AlignHCenter;
		verticalAlignment: Text.AlignVCenter;
		anchors.bottomMargin: timerSecondDisplay.height * 0.1;
		anchors.bottom: timerSecondDisplay.bottom;
		anchors.left: timerSecondDisplay.right;
		anchors.leftMargin: timerSecondDisplay.width * 0.1;
		text: '秒'
	}


	SequentialAnimation {
		id: heatingAnimation;
		running: false;

		ParallelAnimation {

			NumberAnimation {
				target: circle;
				property: 'scale';
				duration: 1000;
				to: 1.1;
				easing.type: Easing.OutCubic;
			}

			NumberAnimation {
				target: circle;
				property: 'opacity';
				duration: 1000;
				to: 0;
				easing.type: Easing.OutCubic;
			}
		}

		ParallelAnimation {

			NumberAnimation {
				target: circle;
				property: 'scale';
				duration: 1000;
				to: 1;
				easing.type: Easing.OutCubic;
			}

			NumberAnimation {
				target: circle;
				property: 'opacity';
				duration: 1000;
				to: 1;
				easing.type: Easing.OutCubic;
			}
		}
	}

	Component.onCompleted: {
		heating = true;
	}
}
