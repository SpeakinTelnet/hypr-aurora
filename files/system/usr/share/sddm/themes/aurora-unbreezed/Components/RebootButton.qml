import QtQuick 2.15
import QtQuick.Controls 2.15
import org.kde.kirigami 2.20 as Kirigami

Item {
  implicitHeight: rebootButton.height
  implicitWidth: rebootButton.width
  Column {
    id: rebootButton
    spacing: 8
    Image {
      source: Qt.resolvedUrl("../assets/icons/system_reboot.svg")
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
        onClicked: sddm.reboot()
      }
    }
    Text {
      text: "Restart"
      font.family: config.Font
      font.pointSize: config.FontSize
      color: Kirigami.Theme.textColor
      anchors.horizontalCenter: parent.horizontalCenter
    }
  }
}
