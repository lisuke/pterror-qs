pragma Singleton

import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Mpris
import "root:/"

Singleton {
	GlobalShortcut {
		name: "workspaces_overview:toggle"
		description: "open and close the workspaces overview"
		onPressed: Config._.workspacesOverview.visible = !Config._.workspacesOverview.visible
	}

	GlobalShortcut {
		name: "wlogout:toggle"
		description: "open and close the logout menu"
		onPressed: Config._.wLogout.visible = !Config._.wLogout.visible
	}

	GlobalShortcut {
		name: "media:play_pause"
		description: "toggle the current media track between playing and paused"
		onPressed: {
			if (!Config._.mpris.currentPlayer) return
			Config._.mpris.currentPlayer.playbackState =
				Config._.mpris.currentPlayer.playbackState === MprisPlaybackState.Playing
					? MprisPlaybackState.Paused
					: MprisPlaybackState.Playing
		}
	}

	GlobalShortcut {
		name: "media:play"
		description: "play the current media track"
		onPressed: {
			if (!Config._.mpris.currentPlayer) return
			Config._.mpris.currentPlayer.playbackState = MprisPlaybackState.Playing
		}
	}

	GlobalShortcut {
		name: "media:pause"
		description: "pause the current media track"
		onPressed: {
			if (!Config._.mpris.currentPlayer) return
			Config._.mpris.currentPlayer.playbackState = MprisPlaybackState.Paused
		}
	}

	GlobalShortcut {
		name: "audio:volume_up"
		description: "increase speaker volume by 5%"
		onPressed: Config._.services.audio.changeVolume(0.05)
	}

	GlobalShortcut {
		name: "audio:volume_down"
		description: "decrease speaker volume by 5%"
		onPressed: Config._.services.audio.changeVolume(-0.05)
	}

	GlobalShortcut {
		name: "audio:mic_volume_up"
		description: "increase microphone volume by 5%"
		onPressed: Config._.services.audio.changeMicVolume(0.05)
	}

	GlobalShortcut {
		name: "audio:mic_volume_down"
		description: "decrease microphone volume by 5%"
		onPressed: Config._.services.audio.changeMicVolume(-0.05)
	}

	GlobalShortcut {
		name: "audio:toggle_mute"
		description: "toggle speaker muted state"
		onPressed: Config._.services.audio.toggleMute()
	}

	GlobalShortcut {
		name: "audio:mute"
		description: "mute speaker"
		onPressed: Config._.services.audio.setMuted(true)
	}

	GlobalShortcut {
		name: "audio:unmute"
		description: "unmute speaker"
		onPressed: Config._.services.audio.setMuted(false)
	}

	GlobalShortcut {
		name: "audio:toggle_mic_mute"
		description: "toggle microphone muted state"
		onPressed: Config._.services.audio.toggleMicMute()
	}

	GlobalShortcut {
		name: "audio:mic_mute"
		description: "mute microphone"
		onPressed: Config._.services.audio.setMicMuted(true)
	}

	GlobalShortcut {
		name: "audio:mic_unmute"
		description: "unmute microphone"
		onPressed: Config._.services.audio.setMicMuted(false)
	}
}
