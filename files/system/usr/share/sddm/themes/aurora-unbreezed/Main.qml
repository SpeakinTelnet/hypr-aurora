import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Effects
import QtMultimedia
import org.kde.kirigami 2.20 as Kirigami

import "Components"

Item {
  id: root
  height: Screen.height
  width: Screen.width

  property font font: Qt.font({
    family: config.Font,
    pointSize: config.FontSize !== "" ? config.FontSize : parseInt(height / 80) || 13
  })

  // Track whether user has moved mouse (triggers blur/darken effect)
  property bool userActive: false

  // Timer to fade out blur effect after inactivity
  Timer {
    id: blurTimer
    interval: (config.BlurTimeout !== "" ? parseInt(config.BlurTimeout) : 5) * 1000
    running: false
    repeat: false
    onTriggered: {
      // Fade out blur and darken effects
      blurEffect.opacity = 0
      darkenOverlay.opacity = 0
      userActive = false
    }
  }

  Rectangle {
    id: background
    anchors.fill: parent
    height: parent.height
    width: parent.width
    z: 0
    color: Kirigami.Theme.backgroundColor
  }

  Image {
    id: backgroundImage
    anchors.fill: parent
    height: parent.height
    width: parent.width
    fillMode: Image.PreserveAspectCrop
    visible: config.CustomBackground == "true" ? true : false
    z: 1
    source: config.Background
    asynchronous: false
    cache: true
    mipmap: true
    clip: true
  }

  MultiEffect {
    id: blurEffect
    anchors.fill: backgroundImage
    source: backgroundImage
    visible: config.CustomBackground == "true" ? true : false
    z: 2

    // Blur settings
    blurEnabled: true
    blur: 1.0
    blurMax: 64
    blurMultiplier: 1.0

    // Initially transparent, becomes visible on mouse move
    opacity: 0

    Behavior on opacity {
      NumberAnimation {
        duration: 500
        easing.type: Easing.OutCubic
      }
    }
  }

  Rectangle {
    id: darkenOverlay
    anchors.fill: parent
    z: 2
    color: "#000000"
    opacity: 0

    Behavior on opacity {
      NumberAnimation {
        duration: 500
        easing.type: Easing.OutCubic
      }
    }
  }

  MouseArea {
    id: mouseDetector
    anchors.fill: parent
    z: 0
    hoverEnabled: true
    propagateComposedEvents: true

    onPositionChanged: {
      if (!userActive) {
        userActive = true
        blurEffect.opacity = 1.0
        darkenOverlay.opacity = 0.3
      }

      if (blurTimer.interval > 0) {
        blurTimer.restart()
      }
    }

    onPressed: mouse.accepted = false
    onReleased: mouse.accepted = false
    onClicked: mouse.accepted = false
  }
  Item {
    id: mainPanel
    z: 3
    anchors {
      fill: parent
      margins: 50
    }
    Clock {
      id: clock
      visible: config.ClockEnabled == "true" ? true : false
    }
    LoginPanel {
      id: loginPanel
      anchors.fill: parent
    }
  }
}
