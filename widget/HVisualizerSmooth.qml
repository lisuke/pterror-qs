import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Wayland
import qs.component
import qs.io
import qs

VisualizerBase {
	id: root
	property bool onBottom: anchors.bottom === parent.bottom
	property int bars: 32
	height: 320
	Component.onCompleted: redrawPath()

	function redrawPath() {
		path.pathElements = [
			...Array.from({ length: curves.model }, (_, i) => curves.itemAt(i).resources[0]),
			finalLine,
		]
	}

	Connections {
		target: input
		function onCountChanged() { redrawPath() }
	}

	Shape {
		id: shape
		opacity: root.opacity
		anchors.fill: parent
		property real spacing: width / (input.count - 1)

		ShapePath {
			id: path
			fillColor: root.fillColor
			strokeColor: root.strokeColor
			strokeWidth: root.strokeWidth
			startY: root.onBottom ? root.height : 0
		}

		Repeater {
			id: curves
			model: input.count

			Item {
				required property int modelData

				PathCurve {
					x: shape.spacing * modelData
					y: {
						const height = input.values[modelData] * shape.height
						return root.onBottom ? root.height - height : height
					}
					Behavior on y {
						SmoothedAnimation { duration: root.animationDuration; velocity: root.animationVelocity }
					}
				}
			}
		}

		Item { PathLine { id: finalLine; x: root.width; y: root.onBottom ? root.height : 0 } }
	}
}
