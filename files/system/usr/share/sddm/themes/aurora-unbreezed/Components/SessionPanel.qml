import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQml.Models 2.15
import org.kde.kirigami 2.20 as Kirigami

Item {
  property var session: sessionList.currentIndex
  implicitHeight: sessionButton.height
  implicitWidth: sessionButton.width
  DelegateModel {
    id: sessionWrapper
    model: sessionModel
    delegate: ItemDelegate {
      id: sessionEntry
      height: inputHeight
      width: parent.width
      highlighted: sessionList.currentIndex == index
      contentItem: Text {
        renderType: Text.NativeRendering
        font.family: config.Font
        font.pointSize: config.FontSize
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: Kirigami.Theme.textColor
        text: name
      }
      background: Rectangle {
        id: sessionEntryBackground
        color: Kirigami.Theme.alternateBackgroundColor
        radius: 3
      }
      states: [
        State {
          name: "hovered"
          when: sessionEntry.hovered
          PropertyChanges {
            target: sessionEntryBackground
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
          sessionList.currentIndex = index
          sessionPopup.close()
        }
      }
    }
  }
  Column {
    id: sessionButton
    spacing: 8
    Image {
      source: Qt.resolvedUrl("../assets/icons/system-user-prompt.svg")
      height: inputHeight * 1.8
      width: inputHeight * 1.8
      anchors.horizontalCenter: parent.horizontalCenter
      smooth: true
      antialiasing: true
      mipmap: true
      sourceSize: Qt.size(width, height)
      MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
          sessionPopup.visible ? sessionPopup.close() : sessionPopup.open()
        }
      }
    }
    Text {
      text: "Other..."
      font.family: config.Font
      font.pointSize: config.FontSize
      color: Kirigami.Theme.textColor
      anchors.horizontalCenter: parent.horizontalCenter
    }
  }
  Popup {
    id: sessionPopup
    width: inputWidth + padding * 2
    x: (sessionButton.width - sessionList.spacing)
    y: -(contentHeight + padding * 2) + sessionButton.height
    padding: inputHeight / 10
    background: Rectangle {
      radius: 5.4
      color: Kirigami.Theme.backgroundColor
    }
    contentItem: ListView {
      id: sessionList
      implicitHeight: contentHeight
      spacing: 8
      model: sessionWrapper
      currentIndex: sessionModel.lastIndex
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
          from: sessionPopup.x + (inputWidth * 0.1)
          to: sessionPopup.x
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
