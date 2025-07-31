import QtQuick
import QtQuick.Controls.Basic
import qs.component

Item {
	required property AuthContext context

	Item {
		anchors.centerIn: parent

		TextField {
			id: entryBox
			anchors.centerIn: parent
			width: 600
			font.pointSize: 24
			enabled: context.status !== AuthContext.Status.Authenticating
			focus: true
			horizontalAlignment: TextInput.AlignHCenter
			echoMode: TextInput.Password
			inputMethodHints: Qt.ImhSensitiveData
			placeholderText: "Enter password"
			onAccepted: text && context.tryLogin(text)
			onEnabledChanged: enabled && (text = "")
		}

		Text {
			id: status; color: "white"; font.pointSize: 24
			anchors {
				horizontalCenter: entryBox.horizontalCenter
				top: entryBox.bottom
				topMargin: 40
			}

			text: {
				switch (context.status) {
          case AuthContext.Status.FirstLogin: { return "" }
          case AuthContext.Status.Authenticating: { return "Authenticating" }
          case AuthContext.Status.LoginFailed: { return "Login Failed" }
				}
			}
		}
	}
}
