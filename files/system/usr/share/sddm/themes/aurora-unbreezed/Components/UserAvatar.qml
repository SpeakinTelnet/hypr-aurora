import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects

Item {
  implicitHeight: userAvatar.height
  implicitWidth: userAvatar.width

  property string currentUser: user


  function refreshAvatar(username) {
    if (username) {
      currentUser = username
    }
    // Force reload by clearing and resetting the source
    userIcon.source = ""
    userIcon.source = getUserAvatar()
  }

  function getUserAvatar() {
    // Try multiple common locations for user avatars
    var avatarPaths = [
      "/var/lib/AccountsService/icons/" + currentUser,
      "/home/" + currentUser + "/.face",
      "/home/" + currentUser + "/.face.icon",
      "/usr/share/pixmaps/faces/" + currentUser + ".png",
      "/usr/share/pixmaps/faces/" + currentUser + ".jpg"
    ]

    // Return first path (Qt will try to load and fallback if it fails)
    return avatarPaths[0]
  }
  Rectangle {
    id: userAvatar
    width: inputHeight * 3.5
    height: inputHeight * 3.5
    color: "transparent"

    Image {
      property bool rounded: true
      property bool adapt: true
      id: userIcon
      source: getUserAvatar()
      anchors.fill: parent
      fillMode: Image.PreserveAspectCrop
      cache: false
      asynchronous: true
      z: 2
      onStatusChanged: {
        if (status === Image.Ready) {
          avatarRing.visible = true
        } else if (status === Image.Error) {
          avatarRing.visible = false
        }
      }
      layer.enabled: rounded
      layer.effect: OpacityMask {
        maskSource: Item {
          width: userIcon.width
          height: userIcon.height
          Rectangle {
            anchors.centerIn: parent
            width: userIcon.adapt ? userIcon.width : Math.min(userIcon.width, userIcon.height)
            height: userIcon.adapt ? userIcon.height : width
            radius: Math.min(width, height)
          }
        }
      }
    }
  }
  Image {
    id: avatarRing
    source: Qt.resolvedUrl("../assets/ring.svg")
    height: userAvatar.width
    width: userAvatar.width
    anchors.centerIn: userAvatar
    z: 3
  }
  anchors {
    horizontalCenter: parent.horizontalCenter
  }
}