import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
  implicitHeight: rebootButton.height
  implicitWidth: rebootButton.width
  Column {
    id: rebootButton
    spacing: 8
    Image {
      source: Qt.resolvedUrl("../assets/icons/system_reboot.svg")
      height: inputHeight * 1.5
      width: inputHeight * 1.5
      anchors.horizontalCenter: parent.horizontalCenter
      MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: sddm.reboot()
      }
    }
    Text {
      text: "Restart"
      font.family: config.Font
      font.pointSize: config.FontSize
      color: "white"
      anchors.horizontalCenter: parent.horizontalCenter
    }
  }
}
