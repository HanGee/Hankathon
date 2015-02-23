import QtQuick 2.3

Item {

	property alias list: listView.model;
/*
	Rectangle {
		anchors.left: parent.left;
		anchors.right: parent.right;
		anchors.bottom: parent.bottom;
		height: 50;
		
		color: '#000000';
	}
*/
	ListView {
		id: listView;
		anchors.fill: parent;
		orientation: ListView.Horizontal;

		delegate: Item {
			height: parent.height;
			width: 200;
/*
			Rectangle {
				anchors.fill: parent;
				color: '#22aaeeff';
				border.width: 4;
				border.color: '#6655eeff';
				radius: 10;
			}
*/
			Image {
				anchors.fill: parent;
				anchors.margins: 10;
				source: imagePath;
				mipmap: true;
				fillMode: Image.PreserveAspectFit;
				smooth: true;
				cache: true;
				asynchronous: true;
			}
		}
	}
}
