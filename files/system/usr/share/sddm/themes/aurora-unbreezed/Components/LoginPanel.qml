import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQml.Models 2.15
import org.kde.kirigami 2.20 as Kirigami
import "../assets"

Item {
  property var user: userField.text
  property var password: passwordField.text
  property var session: sessionPanel.session
  property var inputHeight: Screen.height * 0.032
  property var inputWidth: Screen.width * 0.16
  Rectangle {
    id: loginBackground
    anchors {
      verticalCenter: parent.verticalCenter
      horizontalCenter: parent.horizontalCenter
    }
    height: inputHeight * 11.2
    width: inputWidth * 1.2
    radius: 5
    visible: config.LoginBackground == "true" ? true : false
    color: Kirigami.Theme.backgroundColor
    opacity: 0.8
  }
  Column {
    id: loginSection
    spacing: 20
    z: 5
    width: inputWidth
    anchors {
      verticalCenter: parent.verticalCenter
      horizontalCenter: parent.horizontalCenter
    }
    UserAvatar {
      id: userAvatar
    }
    UserField {
      id: userField
      height: inputHeight
      width: parent.width
      // Connect user change signal to avatar refresh
      onUserChanged: function(username) {
        userAvatar.refreshAvatar(username)
      }
    }
    Row {
      spacing: 8
      width: parent.width
      PasswordField {
        id: passwordField
        height: inputHeight
        width: parent.width - loginButton.width - 8
        onAccepted: loginButton.clicked()
      }
      Button {
        id: loginButton
        height: inputHeight
        width: inputHeight
        enabled: user != "" && password != "" ? true : false
        hoverEnabled: true
        contentItem: Text {
          id: buttonText
          renderType: Text.NativeRendering
          font {
            family: config.Font
            pointSize: config.FontSize * 1.5
            bold: true
          }
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          color: Kirigami.Theme.textColor
          text: ">"
        }
        background: Rectangle {
          id: buttonBackground
          color: Kirigami.Theme.alternateBackgroundColor
          radius: 3
        }
        states: [
          State {
            name: "pressed"
            when: loginButton.down
            PropertyChanges {
              target: buttonBackground
              color: Kirigami.Theme.highlightColor
            }
          },
          State {
            name: "hovered"
            when: loginButton.hovered
            PropertyChanges {
              target: buttonBackground
              color: Kirigami.Theme.highlightColor
            }
          }
        ]
        transitions: Transition {
          PropertyAnimation {
            properties: "color"
            duration: 300
          }
        }
        onClicked: {
          sddm.login(user, password, session)
        }
      }
    }
  }
  Row {
    spacing: 80
    anchors {
      top: loginSection.bottom
      topMargin: 100
      horizontalCenter: parent.horizontalCenter
    }
    SleepButton {
      id: sleepButton
    }
    RebootButton {
      id: rebootButton
    }
    PowerButton {
      id: powerButton
    }
    SessionPanel {
      id: sessionPanel
    }
    z: 5
  }
  Connections {
    target: sddm

    function onLoginFailed() {
      passwordField.text = ""
      passwordField.focus = true
    }
  }
}
