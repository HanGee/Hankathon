import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.1

ApplicationWindow {
	visible: true;
	color: '#ee000000';
	width: 1024;
	height: 768;
//	visibility: Window.FullScreen;

	FontLoader {
		id: numberFont;
		source: 'fonts/aldrich.regular.ttf';
	}

	Logo {
		anchors.centerIn: parent;
		width: parent.width * 0.15;
		height: parent.height * 0.15;

		onFinished: {
		}

		Timer {
			interval: 1000;
			running: (parent.state == 'normal');
			repeat: false;
			onTriggered: {
				clock.visible = true;
//				timerPanel.running = true;
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
	}

	TimerPanel {
		id: timerPanel;
		height: parent.height * 0.5;
		width: height;
		anchors.centerIn: parent;
		running: (clock.state == 'normal');
	}

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
}
