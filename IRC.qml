import QtQuick 2.3
import QtGraphicalEffects 1.0

Item {

	property alias ircTextbox: ircBox;

	Rectangle {
		id: ircContainer;
		color: '#0affffff';
		anchors.bottom: parent.bottom;
		anchors.left: parent.left;
		width: 0;
		height: 50;
		radius: 10;
		border.width: 2;
		border.color: '#20ffffff';
		opacity: 0;

		layer.enabled: true;
		layer.effect: Glow {
			radius: 4;
			samples: 16;
			spread: 0.1;
			cached: true;
			color: '#33aaff';
		}

		ListView {
			id: ircBox;
			anchors.fill: parent;
			anchors.margins: 10;
			model: ListModel {}
			delegate: Item {
				height: label.height;

				Text {
					id: label;
					width: ircBox.width;
					color: '#ffffff';	
					font.pointSize: 10;
					wrapMode: Text.Wrap;
					textFormat: Text.RichText;
					text: msg;

					SequentialAnimation {
						running: true

						ParallelAnimation {

							NumberAnimation {
								target: label;
								property: 'x';
								duration: 300;
								easing.type: Easing.OutBack;
								from: 20;
								to: 0;
							}

							NumberAnimation {
								target: label;
								property: 'opacity';
								duration: 300;
								easing.type: Easing.Linear;
								from: 0;
								to: 1;
							}
						}
					}
				}
			}
		}

		SequentialAnimation {
			running: clock.visible

			ParallelAnimation {

				NumberAnimation {
					target: ircContainer;
					property: 'width';
					duration: 600;
					easing.type: Easing.OutBack;
					to: app.height * 0.3;
				}

				NumberAnimation {
					target: ircContainer;
					property: 'opacity';
					duration: 600;
					easing.type: Easing.Linear;
					to: 1;
				}
			}

			NumberAnimation {
				target: ircContainer;
				property: 'height';
				duration: 500;
				easing.type: Easing.OutBack;
				to: app.height * 0.4;
			}

			NumberAnimation {
				target: ircContainer;
				property: 'width';
				duration: 600;
				easing.type: Easing.OutBack;
				to: app.width * 0.4;
			}

			ParallelAnimation {

				NumberAnimation {
					target: ircInfo;
					property: 'x';
					duration: 600;
					easing.type: Easing.OutCubic;
					from: 200;
					to: 10;
				}

				NumberAnimation {
					target: ircInfo;
					property: 'opacity';
					duration: 600;
					easing.type: Easing.Linear;
					from: 0;
					to: 1;
				}

				NumberAnimation {
					target: ircBoxLabel;
					property: 'opacity';
					duration: 500;
					easing.type: Easing.OutInBounce;
					from: 0;
					to: 1;
					loops: 1;
				}
			}
		}
	}

	Item {
		anchors.left: ircContainer.right;
		anchors.bottom: ircContainer.bottom;

		Text {
			id: ircInfo
			anchors.margins: 10;
			anchors.bottom: parent.bottom;
			font.pointSize: 16;
			font.family: numberFont.name;
			textFormat: Text.RichText;
			//color: '#22bbff';
			//color: '#ffaa22';
			color: '#ffffff';
			text: '#HackathonTaiwan @ freenode<br>http://goo.gl/eoGTUZ'
			opacity: 0;

			layer.enabled: true;
			layer.effect: Glow {
				radius: 4;
				samples: 16;
				spread: 0.1;
				cached: true;
				color: '#33aaff';
			}
		}

		Rectangle {
			id: ircBoxLabel;
			width: labelText.width + 30; 
			height: labelText.height + 10; 
			anchors.bottom: ircInfo.top;
			anchors.margins: 10;
			color: '#aaf0ffff';
			opacity: 0;

			layer.enabled: true;
			layer.effect: Glow {
				radius: 3;
				samples: 16;
				spread: 0.1;
				cached: true;
				color: '#33aaff';
			}

			Text {
				anchors.centerIn: parent;
				id: labelText;
				font.pointSize: 16;
				font.family: numberFont.name;
				textFormat: Text.RichText;
				color: '#000000';
				text: '<b>IRC Channel</b>'

				layer.enabled: true;
				layer.effect: Glow {
					radius: 3;
					samples: 16;
					spread: 0.1;
					cached: true;
					color: '#ffffff';
				}
			}
		}
	}
}
