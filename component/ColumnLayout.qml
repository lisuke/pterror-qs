import QtQuick
import QtQuick.Layouts as Q
import qs

Rectangle {
	default property alias content: container.children
	property alias spacing: container.spacing
	property alias margins: container.anchors.margins
	color: Config._.debugFlags.debugRectangles ? "#20ff0000" : "transparent"
	border.color: Config._.debugFlags.debugRectangles ? "#80ff0000" : "transparent"
	border.width: Config._.debugFlags.debugRectangles ? 1 : 0
	implicitWidth: container.implicitWidth + container.anchors.margins * 2
	implicitHeight: container.implicitHeight + container.anchors.margins * 2

	Q.ColumnLayout {
		id: container
		anchors.fill: parent
	}
}
