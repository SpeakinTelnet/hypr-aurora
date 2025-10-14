import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
  implicitHeight: sleepButton.height
  implicitWidth: sleepButton.width
  Column {
    id: sleepButton
      spacing: 8
      Image {
        source: Qt.resolvedUrl("../assets/icons/system-suspend.svg")
        height: inputHeight * 1.8
        width: inputHeight * 1.8
        anchors.horizontalCenter: parent.horizontalCenter
        MouseArea {
          anchors.fill: parent
          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor
          onClicked: sddm.suspend()
        }
      }
      Text {
        text: "Sleep"
        font.family: config.Font
        font.pointSize: config.FontSize
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
      }
  }
}
