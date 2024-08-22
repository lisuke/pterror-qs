import QtQuick
import QtQuick.Effects
import Quickshell
import "root:/io"

ConfigBase {
	id: root
	property Component wallpaperEffect: MultiEffect { brightness: 0.4; contrast: -0.5 }
	Component.onCompleted: {
		wallpapers.folder = Quickshell.env("HOME") + "/.config/wallpapers/light/"
		wallpapers.effect = wallpaperEffect
		colors.primaryFg = "#80080220"
		colors.secondaryFg = "#80080220"
		colors.secondaryBg = "#300f0e0d"
		colors.selectionBg = "#20080f0f"
		colors.accentFg = "#a0cc77aa"
	}
}
