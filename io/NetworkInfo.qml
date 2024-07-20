pragma Singleton

import QtQuick
import Quickshell
import Qti.Filesystem
import "root:/"
import "root:/library/Units.mjs" as Units
import "root:/library/XHR.mjs" as XHR

Singleton {
	property real upload: 0
	property real download: 0
	property real uploadSec: 0
	property real downloadSec: 0
	property string uploadSecText: Units.bytesToHumanReadable(uploadSec)
	property string downloadSecText: Units.bytesToHumanReadable(downloadSec)

	Timer {
		interval: 1000; running: true; repeat: true; triggeredOnStart: true
		onTriggered: {
			file.close()
			file.open()
			const text = file.read()
			const match = text.match(new RegExp(Config.network.interface_ + /: +(\d+) +\d+ +\d+ +\d+ +\d+ +\d+ +\d+ +\d+ +(\d+)/.source))
			if (match) {
				const newUpload = Number(match[1])
				const newDownload = Number(match[2])
				uploadSec = newUpload - upload
				downloadSec = newDownload - download
				upload = newUpload
				download = newDownload
			}
		}
	}

	File { id: file; readable: true; path: "/proc/net/dev" }
}
