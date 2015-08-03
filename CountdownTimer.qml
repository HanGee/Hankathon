import QtQuick 2.3

Item {

	id: countdownTimer;

	property alias running: timer.running;
	property var expiration: '2015-05-23 17:00:00';
	property var expirationDate: new Date(expiration);
	property var expirationTime: expirationDate.getTime();
	property int hourMS: 60 * 60 * 1000;
	property int minuteMS: 60 * 1000;

	property string hour: {
		return String('00' + timer.hour.toString()).slice(-2);
	}
	property string minute: {
		return String('00' + timer.minute.toString()).slice(-2);
	}
	property string second: {
		return String('00' + timer.second.toString()).slice(-2);
	}
	property string millisecond: {
		return String('000' + timer.millisecond.toString()).slice(-3);
	}

	signal timeout();
	signal lastHour();

	Timer {
		id: timer;
		interval: 1000;
		running: false;
		repeat: true;

		property int hour: 0;
		property int minute: 0;
		property int second: 0;
		property int millisecond: 0;

		onTriggered: {
			var curDate = new Date();

			// Difference
			var diffMS = expirationTime - curDate.getTime();
			if (diffMS <= 0) {

				// Stop to countdown
				running = false;

				// Timeout
				hour = 0;
				minute = 0;
				second = 0;
				millisecond = 0;

				timeout();
				return;
			}

			// Hour
			var diffHour = Math.floor(diffMS / hourMS);
			var _hour = parseInt(diffHour);
			if (_hour != hour)
				hour = _hour;

			diffMS -= diffHour * hourMS;
			if (diffHour <= 0) {
				// Last hour
				lastHour();
			}

			// Minute
			var diffMinute = Math.floor(diffMS / minuteMS);
			var _minute = parseInt(diffMinute);
			if (_minute != minute)
				minute = _minute;

			diffMS -= diffMinute * minuteMS;

			// Second
			var diffSecond = Math.floor(diffMS / 1000);
			var _second = parseInt(diffSecond);
			if (_second != second)
				second = _second;

			diffMS -= diffSecond * 1000;
		}
	}

	NumberAnimation {
		running: timer.running;
		loops: Animation.Infinite;
		target: timer;
		property: 'millisecond';
		duration: 1000;
		from: 999;
		to: 0;
	}
}
