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
		id: goldBrand
		height: parent.height * 0.05;
		anchors.left: parent.left;
		anchors.right: parent.right;
		anchors.bottom: parent.bottom;

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

	BrandBubble {
		id: diamondBrand;
		height: parent.height * 0.08;
		anchors.left: parent.left;
		anchors.right: parent.right;
		anchors.bottom: goldBrand.top;

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
}
