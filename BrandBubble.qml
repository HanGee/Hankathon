import QtQuick 2.2

Item {

	Rectangle {
		anchors.left: parent.left;
		anchors.right: parent.right;
		anchors.bottom: parent.bottom;
		height: 50;
		
		color: '#000000';
	}

	ListView {
		anchors.fill: parent;
		orientation: ListView.Horizontal;
		model: ListModel {
			ListElement {
				imagePath: './logo/HanGee.jpg';
			}
			ListElement {
				imagePath: './logo/DOITT.png';
			}
			ListElement {
				imagePath: './logo/qt.png';
			}
			ListElement {
				imagePath: './logo/nodeschool.png';
			}
		}

		delegate: Image {
			height: parent.height;
			source: imagePath;
			fillMode: Image.PreserveAspectFit;
			smooth: true;
			cache: true;
			asynchronous: true;
		}
	}
}
