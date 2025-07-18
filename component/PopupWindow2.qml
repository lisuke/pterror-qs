import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs

PopupWindow {
	default property alias content: container.children
	color: "transparent"
	implicitWidth: container.children[0].implicitWidth || 1
	implicitHeight: container.children[0].implicitHeight || 1

	id: root
	property list<var> extraGrabWindows: []
	onVisibleChanged: grab.active = visible

	HyprlandFocusGrab {
		id: grab; windows: [root].concat(extraGrabWindows); active: true
		onActiveChanged: root.visible = active
	}

	Rectangle {
		id: container
		color: Config._.style.window.bg
		radius: Config._.style.window.radius
		anchors.fill: parent
	}
}
