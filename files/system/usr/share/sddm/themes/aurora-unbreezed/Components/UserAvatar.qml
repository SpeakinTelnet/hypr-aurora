import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
  implicitHeight: userAvatar.height
  implicitWidth: userAvatar.width
  Rectangle {
    id: userAvatar
    visible: config.UserIcon == "true" ? true : false
    width: inputHeight * 3.5
    height: inputHeight * 3.5
    color: "transparent"
    Image {
      source: Qt.resolvedUrl("../assets/defaultIcon.png")
      height: parent.width
      width: parent.width
    }
    Image {
      // common icon path for KDE and GNOME
      source: Qt.resolvedUrl("/var/lib/AccountsService/icons/" + user)
      height: parent.width
      width: parent.width
    }
    Image {
      source: Qt.resolvedUrl("../assets/ring.svg")
      height: parent.width
      width: parent.width
  }
  }
  anchors {
    horizontalCenter: parent.horizontalCenter
  }
}