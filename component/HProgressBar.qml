import QtQuick
import ".."

Widget {
	id: root
	required property real fraction
	property int animationSpeed: 50
	property int animationDuration: -1
	property string fg: Config.colors.panel.accent
	property int margins: Config.layout.panel.margins
	property int innerRadius: Config.layout.panel.innerRadius
	signal input(real fraction)
	color: Config.colors.panel.bg
	radius: Config.layout.panel.radius

	Rectangle {
		property int maxWidth: parent.width - root.margins * 2
		anchors {
			left: parent.left
			top: parent.top
			bottom: parent.bottom
			margins: root.margins
		}
		width: maxWidth * Math.max(0, Math.min(1, fraction))
		color: root.fg
		radius: root.innerRadius

		Behavior on width {
			SmoothedAnimation {
				velocity: mouseArea.pressed ? 5000 : animationSpeed
				duration: animationDuration
			}
		}
	}

	MouseArea {
		id: mouseArea
		anchors.fill: parent
		anchors.margins: root.margins
		onPressed: event => root.input(1 - (event.x / width))
		onPositionChanged: event => {
			if (!pressed) return
			root.input(1 - (event.x / width))
		}
	}
}
