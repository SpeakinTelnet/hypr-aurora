import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQml.Models 2.15
import org.kde.kirigami 2.20 as Kirigami

Item {
  implicitHeight: userField.height
  implicitWidth: userField.width

  // Signal to notify when user changes
  signal userChanged(string username)

  DelegateModel {
    id: userWrapper
    model: userModel
    delegate: ItemDelegate {
      id: userEntry
      height: inputHeight
      width: parent.width
      highlighted: userList.currentIndex == index
      contentItem: Text {
        renderType: Text.NativeRendering
        font.family: config.Font
        font.pointSize: config.FontSize
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: Kirigami.Theme.textColor
        text: model.name
      }
      background: Rectangle {
        id: userEntryBackground
        color: Kirigami.Theme.alternateBackgroundColor
        radius: 3
      }
      states: [
        State {
          name: "hovered"
          when: userEntry.hovered
          PropertyChanges {
            target: userEntryBackground
            color: Kirigami.Theme.highlightColor
          }
        }
      ]
      transitions: Transition {
        PropertyAnimation {
          property: "color"
          duration: 300
        }
      }
      MouseArea {
        anchors.fill: parent
        onClicked: {
          userList.currentIndex = index
          userField.text = model.name
          userChanged(model.name)
          userPopup.close()
        }
      }
    }
  }
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

    Component.onCompleted: {
      // Emit userChanged signal on initial load to sync the user property
      if (text !== "") {
        userChanged(text)
      }
    }
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
      MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
          userPopup.visible ? userPopup.close() : userPopup.open()
        }
      }
  }
  Popup {
    id: userPopup
    width: inputWidth + padding * 2
    x: (userField.width - userList.spacing)
    y: -(contentHeight + padding * 2) + userField.height
    padding: inputHeight / 10
    background: Rectangle {
      radius: 5.4
      color: Kirigami.Theme.backgroundColor
    }
    contentItem: ListView {
      id: userList
      implicitHeight: contentHeight
      spacing: 8
      model: userWrapper
      currentIndex: userModel.lastIndex
      clip: true
    }
    enter: Transition {
      ParallelAnimation {
        NumberAnimation {
          property: "opacity"
          from: 0
          to: 1
          duration: 400
          easing.type: Easing.OutExpo
        }
        NumberAnimation {
          property: "x"
          from: userPopup.x + (inputWidth * 0.1)
          to: userPopup.x
          duration: 500
          easing.type: Easing.OutExpo
        }
      }
    }
    exit: Transition {
      NumberAnimation {
        property: "opacity"
        from: 1
        to: 0
        duration: 300
        easing.type: Easing.OutExpo
      }
    }
  }
}
