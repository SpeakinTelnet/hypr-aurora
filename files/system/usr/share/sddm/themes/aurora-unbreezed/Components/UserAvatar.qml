import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects

Item {
  implicitHeight: userAvatar.height
  implicitWidth: userAvatar.width

  property string currentUser: userModel.lastUser

  // List of paths to try for user avatars, in priority order
  property var avatarPaths: [
    "/var/lib/AccountsService/icons/" + currentUser,
    "/home/" + currentUser + "/.face",
    "/home/" + currentUser + "/.face.icon",
    "/usr/share/pixmaps/faces/" + currentUser + ".png",
    "/usr/share/pixmaps/faces/" + currentUser + ".jpg"
  ]
  property int currentPathIndex: 0

  function refreshAvatar(username) {
    if (username) {
      currentUser = username
      // Update avatar paths with new username
      avatarPaths = [
        "/var/lib/AccountsService/icons/" + currentUser,
        "/home/" + currentUser + "/.face",
        "/home/" + currentUser + "/.face.icon",
        "/usr/share/pixmaps/faces/" + currentUser + ".png",
        "/usr/share/pixmaps/faces/" + currentUser + ".jpg"
      ]
    }
    // Reset to first path and force reload by clearing and resetting the source
    currentPathIndex = 0
    userIcon.source = ""
    userIcon.source = avatarPaths[currentPathIndex]
  }

  function tryNextAvatar() {
    // Fallback implementation based on Qt Forum solution:
    // https://forum.qt.io/topic/7548/solved-creating-a-qml-image-that-will-load-different-source-if-one-source-fails-to-load
    //
    // Key insight: When status == Image.Error, trying to load another image that also errors
    // will NOT trigger onStatusChanged again. We must clear the source first to reset the state.
    if (currentPathIndex < avatarPaths.length - 1) {
      currentPathIndex++
      userIcon.source = ""  // Critical: clear source to reset status from Error to Null
      userIcon.source = avatarPaths[currentPathIndex]
    } else {
      // All paths failed, hide the avatar ring
      avatarRing.visible = false
    }
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
      source: avatarPaths[currentPathIndex]
      anchors.fill: parent
      fillMode: Image.PreserveAspectCrop
      cache: false
      asynchronous: true
      z: 2
      onStatusChanged: {
        if (status === Image.Ready) {
          avatarRing.visible = true
        } else if (status === Image.Error) {
          // Current path failed, try next avatar path
          tryNextAvatar()
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