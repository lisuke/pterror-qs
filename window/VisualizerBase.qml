import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Wayland
import "root:/component"
import "root:/io"
import ".."

Rectangle {
	id: root
	color: "transparent"
	property string fillColor: Config.colors.visualizer.barsBg
	property string strokeColor: "transparent"
	property int strokeWidth: 0
	property real animationDuration: 0
	property real animationVelocity: 1
	property Component inputDelegate: Cava {}
	property var fallbackInput: Loader { active: fallbackInput === input; sourceComponent: inputDelegate }
	property var input: fallbackInput
}
