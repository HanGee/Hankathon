import QtQuick 2.3

Item {

	property alias running: timer.running;
	property var expiration: '2015-04-12 17:00:00';
	property var expirationDate: new Date(expiration);
	property var expirationTime: expirationDate.getTime();
	property int hourMS: 60 * 60 * 1000;
	property int minuteMS: 60 * 1000;

	property alias hour: timer.hour;
	property alias minute: timer.minute;
	property alias second: timer.second;
	property alias millisecond: timer.millisecond;

	signal timeout();
	signal lastHour();

	Timer {
		id: timer;
		interval: 20;
		running: false;
		repeat: true;

		property var hour: '00';
		property var minute: '00';
		property var second: '00';
		property var millisecond: '000';

		onTriggered: {
			var curDate = new Date();

			// Difference
			var diffMS = expirationTime - curDate.getTime();
			if (diffMS <= 0) {

				// Timeout
				timeout();
				return;
			}

			// Hour
			var diffHour = Math.floor(diffMS / hourMS);
			hour = String('00' + parseInt(diffHour).toString()).slice(-2);
			diffMS -= diffHour * hourMS;
			if (diffHour <= 0) {
				// Last hour
				lastHour();
			}

			// Minute
			var diffMinute = Math.floor(diffMS / minuteMS);
			minute = String('00' + parseInt(diffMinute).toString()).slice(-2);
			diffMS -= diffMinute * minuteMS;

			// Second
			var diffSecond = Math.floor(diffMS / 1000);
			second = String('00' + parseInt(diffSecond).toString()).slice(-2);
			diffMS -= diffSecond * 1000;

			// Millisecond
			millisecond = String('000' + parseInt(diffMS).toString()).slice(-3);
		}
	}
}
