import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import ".."
import "../library/Arrays.mjs" as Arrays
import "../library/Random.mjs" as Random

QtObject {
	property real seed: Config.wallpapers.seed
	property var wallpapers: getWallpapers()
	readonly property var random: new Random.Random()
	readonly property FolderListModel folder: FolderListModel {
		showDirs: false; showOnlyReadable: true
		folder: "file://" + Config.wallpapers.folder
		nameFilters: Config.wallpapers.formats
		onStatusChanged: if (status == FolderListModel.Ready) wallpapers = getWallpapers()
	}

	function getWallpapers() {
		random.seed(seed)
		const unshuffled = []
		for (let i = 0; i < folder.count; i += 1) {
			unshuffled.push(folder.get(i, "filePath"))
		}
		const shuffled = Arrays.shuffle(unshuffled, () => random.random())
		const newWallpapers = {}
		for (const screen of Quickshell.screens) {
			newWallpapers[screen.name] = shuffled.pop()
		}
		if (Config.debug) {
			console.log("Newwallpapers:", JSON.stringify(newWallpapers))
		}
		return newWallpapers
	}
	
	onSeedChanged: wallpapers = getWallpapers()
}
