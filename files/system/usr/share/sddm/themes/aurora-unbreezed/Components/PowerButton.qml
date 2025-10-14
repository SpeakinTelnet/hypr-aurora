import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
  implicitHeight: powerButton.height
  implicitWidth: powerButton.width
  Column {
    id: powerButton
    spacing: 8
    Image {
      source: Qt.resolvedUrl("../assets/icons/system-shutdown.svg")
      height: inputHeight * 1.8
      width: inputHeight * 1.8
      anchors.horizontalCenter: parent.horizontalCenter
      MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: sddm.powerOff()
      }
    }
    Text {
      text: "Shut Down"
      font.family: config.Font
      font.pointSize: config.FontSize
      color: "white"
      anchors.horizontalCenter: parent.horizontalCenter
    }
  }
}
