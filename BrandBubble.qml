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
		id: listView;
		anchors.fill: parent;
		orientation: ListView.Horizontal;
		model: ListModel {
			ListElement {
				imagePath: './logo/HanGee.jpg';
			}
			ListElement {
				imagePath: './logo/AvengerGear.jpg';
			}
			ListElement {
				imagePath: './logo/qt.png';
			}
			ListElement {
				imagePath: './logo/CustardCream.jpg';
			}
			ListElement {
				imagePath: './logo/TaiwanLD.jpg';
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
