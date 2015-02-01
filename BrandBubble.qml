import QtQuick 2.2

Item {

	property alias list: listView.model;

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
