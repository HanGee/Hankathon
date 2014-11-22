import QtQuick 2.2
import QtGraphicalEffects 1.0

Item {
	id: hackTimer;

	property bool heating: false;
	property var heatingMode: 'freeze';
	property var durationMS: hourMS * 48;
	property var leftMS: durationMS;
	property var expiration: '2014-11-22 18:00:00';
//	property var expiration: '2014-09-21 18:00:00';
	property var expirationDate: new Date(expiration);
	property int hourMS: 60 * 60 * 1000;
	property int minuteMS: 60 * 1000;

	signal ended();
	signal lastMile();

	Timer {
		interval: 20;
		running: heating;
		repeat: true;

		onTriggered: {
			var dateObj = new Date();
			var curProgress = 1;

			// Difference
			var diffMS = leftMS = expirationDate.getTime() - dateObj.getTime();
			if (diffMS <= 0) {
				hackTimer.state = 'end';
				ended();
				return;
			}

			// Hour
			var diffHour = Math.floor(diffMS / hourMS);
			var hourLabel = String('00' + parseInt(diffHour).toString()).slice(-2);
			diffMS -= diffHour * hourMS;
			if (diffHour <= 0) {
				hackTimer.state = 'lastMile';
				lastMile();
			}

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
					switch(state) {
					case 'lastMile':
						heatingMode = 'quick';
						break;

					default:
						heatingMode = 'normal';
					}
				}
			}

			timerHourDisplay.text = hourLabel;
			timerMinuteDisplay.text = minLabel;
			timerSecondDisplay.text = secLabel;
			timerMillisecondDisplay.text = '.' + String('000' + parseInt(diffMS).toString()).slice(-3);
		}
	}

	Text {
		id: endLabel;
		text: '時間到';
		color: '#ffffff';
		font.pointSize: Math.floor(parent.width * 0.2) || 60;
		anchors.horizontalCenter: parent.horizontalCenter;
		anchors.verticalCenter: parent.verticalCenter;
		opacity: 0;
	}

	Text {
		id: title;
		color: '#00ffff';
		text: 'HanGee 黑客松';
		font.pointSize: Math.floor(parent.width * 0.03) || 60;
		font.weight: Font.DemiBold;
		anchors.horizontalCenter: parent.horizontalCenter;
		visible: false;
	}

	Glow {
		anchors.fill: title;
		radius: 8
		samples: 16
		color: '#00ffff';
		source: title;
	}

	Circle {
		id: circle
		height: parent.height * 0.7;
		width: height;
		anchors.centerIn: parent;
		border: 30;
		color: '#ffffff';
		opacity: 0.3;
	}

	Circle {
		id: progress;
		height: circle.height * 0.95;
		width: height;
		anchors.centerIn: parent;
		color: '#ffffff';
		border: 30;
		angle: 360 * (leftMS / durationMS).toFixed(2);
		opacity: 0.15;

		Behavior on angle {
			NumberAnimation {
				duration: 1000;
				easing.type: Easing.OutBack;
			}
		}
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
		id: timeLeftLabel;
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
		visible: false;
	}

	Glow {
		anchors.fill: timerHourDisplay;
		radius: 16
		samples: 32
		color: '#ffffff';
		source: timerHourDisplay;
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
		running: (heatingMode == 'normal') ? true : false;

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
				to: 0.25;
				easing.type: Easing.OutCubic;
			}
		}
	}

	SequentialAnimation {
		id: quickHeatingAnimation;
		running: (heatingMode == 'quick') ? true : false;

		ParallelAnimation {

			NumberAnimation {
				target: circle;
				property: 'scale';
				duration: 100;
				to: 1.1;
				easing.type: Easing.OutCubic;
			}

			NumberAnimation {
				target: circle;
				property: 'opacity';
				duration: 100;
				to: 0;
				easing.type: Easing.OutCubic;
			}
		}

		ParallelAnimation {

			NumberAnimation {
				target: circle;
				property: 'scale';
				duration: 100;
				to: 1;
				easing.type: Easing.OutCubic;
			}

			NumberAnimation {
				target: circle;
				property: 'opacity';
				duration: 100;
				to: 1;
				easing.type: Easing.OutCubic;
			}
		}
	}

	states: [
		State {
			name: 'end';

			PropertyChanges {
				target: endLabel;
				opacity: 1;
			}

			PropertyChanges {
				target: hackTimer;
				heating: false;
			}

			PropertyChanges {
				target: circle;
				visible: false;
			}

			PropertyChanges {
				target: timeLeftLabel;
				visible: false;
			}

			PropertyChanges {
				target: timerHourDisplay;
				visible: false;
			}

			PropertyChanges {
				target: timerMinuteDisplay;
				visible: false;
			}

			PropertyChanges {
				target: timerSecondDisplay;
				visible: false;
			}

			PropertyChanges {
				target: timerMillisecondDisplay;
				visible: false;
			}

			PropertyChanges {
				target: timerSpinner;
				visible: false;
			}

			PropertyChanges {
				target: timerHourUnitDisplay;
				visible: false;
			}

			PropertyChanges {
				target: timerMinuteUnitDisplay;
				visible: false;
			}

			PropertyChanges {
				target: timerSecondUnitDisplay;
				visible: false;
			}
		},
		State {
			name: 'lastMile';

			PropertyChanges {
				target: circle;
				border.color: '#bb0000';
			}

			PropertyChanges {
				target: subLevel;
				anchors.fill: circle;
				anchors.topMargin: circle.height * 0.3;
			}

			PropertyChanges {
				target: timeLeftLabel;
				color: '#cc0000';
			}

			PropertyChanges {
				target: timerHourDisplay;
				color: '#ff0000';
				opacity: 0;
			}

			PropertyChanges {
				target: timerHourUnitDisplay;
				visible: false;
			}

			PropertyChanges {
				target: timerMinuteDisplay;
				color: '#ff0000';
				opacity: 1;
			}

			PropertyChanges {
				target: timerSecondDisplay;
				color: '#ff0000';
				opacity: 1;
			}

			PropertyChanges {
				target: timerMillisecondDisplay;
				color: '#ff0000';
			}

			PropertyChanges {
				target: timerSpinner;
				border.color: '#bb0000';
			}
		}

	]

	Component.onCompleted: {
		heating = true;
	}
}
