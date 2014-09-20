import QtQuick 2.0
import QtQuick.Controls 1.2

ApplicationWindow {
	visible: true;
	color: '#000000';
	width: 1024;
	height: 768;

	FontLoader {
		id: numberFont;
		source: 'fonts/monofont.ttf';
	}

	FontLoader {
		source: 'fonts/NotoSansCJKtc-Regular.otf';
	}

	BackgroundShow {
		id: background;
		anchors.fill: parent;
	}

	HackTimer {
		anchors.fill: parent;

		onEnded: {
			background.state = 'end';
		}

		onLastMile: {
			background.state = 'lastMile';
		}
	}

	BrandBubble {
		height: parent.height * 0.1;
		anchors.left: parent.left;
		anchors.right: parent.right;
		anchors.bottom: parent.bottom;
	}
}
