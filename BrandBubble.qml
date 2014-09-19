import QtQuick 2.2

Item {

	Rectangle {
		anchors.fill: parent;
//		color: '#ffffff';
		color: '#000000';
	}

	Image {
		id: hangee;
		anchors.top: parent.top;
		anchors.bottom: parent.bottom;
		height: parent.height * 0.25;

		source: 'logo/HanGee.jpg'
		fillMode: Image.PreserveAspectFit;
		smooth: true;
		cache: true;
		asynchronous: true;
	}

	Image {
		id: moedict;
		anchors.left: hangee.right;
		anchors.top: parent.top;
		anchors.bottom: parent.bottom;
		height: parent.height * 0.25;

		source: 'logo/moedict.png'
		fillMode: Image.PreserveAspectFit;
		smooth: true;
		cache: true;
		asynchronous: true;
	}

	Image {
		id: skywatch;
		anchors.left: moedict.right;
		anchors.top: parent.top;
		anchors.bottom: parent.bottom;
		height: parent.height * 0.25;

		source: 'logo/Skywatch.jpg'
		fillMode: Image.PreserveAspectFit;
		smooth: true;
		cache: true;
		asynchronous: true;
	}

	Image {
		id: doitt;
		anchors.left: skywatch.right;
		anchors.top: parent.top;
		anchors.bottom: parent.bottom;
		height: parent.height * 0.25;

		source: 'logo/DOITT.png'
		fillMode: Image.PreserveAspectFit;
		smooth: true;
		cache: true;
		asynchronous: true;
	}
}
