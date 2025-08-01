import QtQuick
import qs.component
import qs.io
import qs

SelectionArea {
	property string app: Config._.terminal
	anchors.fill: parent
	screen: window.screen
	selectionArea: selectionLayer.selectionArea

	SelectionLayer {
		id: selectionLayer

		onSelectionComplete: (x: int, y: int, width: int, height: int) => {
			Hyprland.exec(
				null,
				[
					"dispatch",
					"exec",
					`[float;; noanim; move ${x} ${y}; size ${width} ${height}] ${app}`,
				],
				() => {
					selectionLayer.selectionArea.selecting = false
				}
			)
		}

		Connections {
			target: Shell
			function onSelectingWindowAreaChanged() {
				if (Shell.selectingWindowArea) {
					selectionArea.startSelection(true)
				} else {
					selectionArea.endSelection()
				}
			}
		}
	}
}
