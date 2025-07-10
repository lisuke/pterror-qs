/*  Shader Wallpaper
 *  Copyright (C) 2020 @y4my4my4m | github.com/y4my4my4m
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 *  This software uses some of the QML code from JaredTao/jared2020@163.com's ToyShader for Android.
 *  See: https://github.com/jaredtao/TaoShaderToy/
 *
 *  Thanks to: Rog131 <samrog131@hotmail.com>, adhe <adhemarks2@gmail.com>
 *  for their work on the SmartVideoWallpaper plugin, I've used this as a reference for
 *  pausing the shader when fullscreen/maximed or when resources are busy
 *
 *  Thanks to github.com/simons-public for his contributions
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import qs.component
import qs

Rectangle {
	id: root
	color: "transparent"
	property var config: Config._.bouncingMaskedShader
	property bool playing: true
	property bool moving: true
	property real timeMod: Config._.bouncingMaskedShader.timeMod
	property real angle: Math.atan2(
		Config._.bouncingMaskedShader.velocityY,
		Config._.bouncingMaskedShader.velocityX
	) * 180 / Math.PI
	property real baseVelocity: Math.hypot(
		Config._.bouncingMaskedShader.velocityX,
		Config._.bouncingMaskedShader.velocityY
	)
	property real velocityMultiplierX: Math.cos(angle * Math.PI / 180)
	property real velocityMultiplierY: Math.sin(angle * Math.PI / 180)
	property real velocity: baseVelocity + extraVelocityAnimation.velocity
	property real velocityX: root.velocity * root.velocityMultiplierX
	property real velocityY: root.velocity * root.velocityMultiplierY
	property real lastFrameDate: Number(new Date())
	x: 32
	y: 64
	width: mask.width
	height: mask.height

	MomentumAnimation { id: extraVelocityAnimation }

	function impulse(value) { extraVelocityAnimation.impulse(value) }

	ShaderEffect {
		id: shader
		width: mask.width
		height: mask.height
		visible: false
		blending: false
		property vector3d iResolution: Qt.vector3d(width, height, 0)
		property real iTime: 0
		property list<real> iChannelTime: [0., 0., 0., 0.]
		property real iFrameRate: Config._.frameRate
		property real iTimeDelta: 1 / iFrameRate
		property real iSampleRate: 1
		property int iFrame: 0
		property real iX: root.x
		property real iY: root.parent.height - root.y - iH
		property int iW: root.width
		property int iH: root.height
		property int iScreenW: root.parent.width || 1920
		property int iScreenH: root.parent.height || 1080
		property real iVelocityX: root.velocity * root.velocityMultiplierX * iTimeDelta
		property real iVelocityY: root.velocity * root.velocityMultiplierY * iTimeDelta
		property vector4d iDate
		property Image iChannel0: Image {
			source: Config._.bouncingMaskedShader.channel0
			visible: false
		}
		property Image iChannel1: Image {
			source: Config._.bouncingMaskedShader.channel1
			visible: false
		}
		property Image iChannel2: Image {
			source: Config._.bouncingMaskedShader.channel2
			visible: false
		}
		property Image iChannel3: Image {
			source: Config._.bouncingMaskedShader.channel3
			visible: false
		}
		property list<vector3d> iChannelResolution: [
			Qt.vector3d(iChannel0.width, iChannel0.height, iChannel0.width / iChannel0.height),
			Qt.vector3d(iChannel1.width, iChannel1.height, iChannel1.width / iChannel1.height),
			Qt.vector3d(iChannel2.width, iChannel2.height, iChannel2.width / iChannel2.height),
			Qt.vector3d(iChannel3.width, iChannel3.height, iChannel3.width / iChannel3.height),
		]

		fragmentShader: "../shader/" + Config._.bouncingMaskedShader.shader + ".frag.qsb"

		FrameAnimation {
			running: true
			onTriggered: {
				if (playing) {
					shader.iTime += frameTime * Config._.bouncingMaskedShader.speed
					if (root.timeMod) shader.iTime %= root.timeMod
					shader.iChannelTime = [shader.iTime, shader.iTime, shader.iTime, shader.iTime]
					const newFrameDate = Number(new Date())
					const frameDelta = Math.floor(newFrameDate / shader.iTimeDelta) - Math.floor(root.lastFrameDate / shader.iTimeDelta)
					root.lastFrameDate = newFrameDate
					shader.iFrame += 1
					shader.iDate = Qt.vector4d(0., 0., 0., Number(new Date()) / 1000 % 86400)
				}
				if (moving) {
					const dx = root.velocityX * frameTime
					const nextX = root.x + dx
					const maxX = (root.parent.width || 1920) - shader.iW
					if (nextX < 0 || nextX > maxX) {
						root.angle = 180 - root.angle
					}
					root.x = Math.max(0, Math.min(maxX, nextX))
					const dy = root.velocityY * frameTime
					const nextY = root.y + dy
					const maxY = (root.parent.height || 1080) - shader.iH
					if (nextY < 0 || nextY > maxY) {
						root.angle *= -1
					}
					root.y = Math.max(0, Math.min(maxY, nextY))
				}
			}
		}
	}

	Image {
		id: mask
		layer.enabled: true; cache: false
		source: Config._.bouncingMaskedShader.mask
		property real maskAspectRatio: (implicitWidth / implicitHeight) || 0.01
		width: Config._.bouncingMaskedShader.maskWidth != -1 ?
			Config._.bouncingMaskedShader.maskWidth :
			Config._.bouncingMaskedShader.maskHeight != -1 ?
			Config._.bouncingMaskedShader.maskHeight * maskAspectRatio :
			implicitWidth
		height: Config._.bouncingMaskedShader.maskHeight != -1 ?
			Config._.bouncingMaskedShader.maskHeight :
			Config._.bouncingMaskedShader.maskWidth != -1 ?
			Config._.bouncingMaskedShader.maskWidth / maskAspectRatio :
			implicitHeight
		visible: false
	}

	MultiEffect {
		source: shader
		maskEnabled: true
		maskSource: mask
		anchors.left: parent.left
		anchors.top: parent.top
		width: mask.width
		height: mask.height
		opacity: Config._.bouncingMaskedShader.opacity
	}
}
