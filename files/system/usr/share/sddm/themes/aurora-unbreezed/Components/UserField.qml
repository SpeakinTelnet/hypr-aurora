import QtQuick 2.15
import QtQuick.Controls 2.15
import org.kde.kirigami 2.20 as Kirigami

TextField {
  id: userField
  height: inputHeight
  width: inputWidth
  selectByMouse: true
  echoMode: TextInput.Normal
  renderType: Text.NativeRendering
  font {
    family: config.Font
    pointSize: config.FontSize
    bold: true
  }
  color: Kirigami.Theme.textColor
  horizontalAlignment: Text.AlignHCenter
  placeholderText: "Username"
  text: userModel.lastUser
  background: Rectangle {
    color: Kirigami.Theme.alternateBackgroundColor
    opacity: 0.1
    radius: 3
  }
  states: [
    State {
      name: "focused"
      when: userField.activeFocus
      PropertyChanges {
        target: userField
        color: Kirigami.Theme.highlightedTextColor
      }
    },
    State {
      name: "hovered"
      when: userField.hovered
      PropertyChanges {
        target: userField
        color: Kirigami.Theme.highlightedTextColor
      }
    }
  ]
  transitions: Transition {
    PropertyAnimation {
      properties: "color"
      duration: 300
    }
  }
}
