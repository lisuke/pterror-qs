import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "root:/component"
import "root:/"

Rectangle {
	anchors.right: parent.right; anchors.bottom: parent.bottom
	anchors.rightMargin: 50; anchors.bottomMargin: 50
	width: content.implicitWidth
	height: content.implicitHeight
	color: "transparent"

	ColumnLayout2 {
		autoSize: true
		id: content
		Text2 {
			Layout.alignment: Qt.AlignLeft
			color: Config.style.activateLinux.fg
			font.pointSize: 22
			text: (Config.owo ? "Actwivwate " : "Activate ") + Config.activateLinux.name
		}
		Text2 {
			Layout.alignment: Qt.AlignLeft
			color: Config.style.activateLinux.fg
			font.pointSize: 14
			text: (Config.owo ? "Gowo twu Swettwings twu actwivwate " : "Go to Settings to activate ") + Config.activateLinux.name
		}
	}
}
