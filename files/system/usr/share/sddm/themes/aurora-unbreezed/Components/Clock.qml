import QtQuick 2.15
import QtQuick.Controls 2.15
import org.kde.kirigami 2.20 as Kirigami


Column {
    id: clock

    Label {
        id: timeLabel

        anchors.horizontalCenter: parent.horizontalCenter

        font.pointSize: root.font.pointSize * 6
        font.bold: true
        color: Kirigami.Theme.textColor
        renderType: Text.QtRendering

        function updateTime() {
            text = new Date().toLocaleTimeString(Qt.locale(Locale.ShortFormat), "HH:mm")
        }
    }

    Label {
        id: dateLabel

        anchors.horizontalCenter: parent.horizontalCenter

        font.pointSize: root.font.pointSize * 1.5
        color: Kirigami.Theme.textColor
        renderType: Text.QtRendering

        function updateTime() {
            text = new Date().toLocaleDateString(Qt.locale(Locale.LongFormat), Locale.LongFormat)
        }
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            dateLabel.updateTime()
            timeLabel.updateTime()
        }
    }

    Component.onCompleted: {
        dateLabel.updateTime()
        timeLabel.updateTime()
    }

    anchors {
        margins: 30
        top: parent.top
        horizontalCenter: parent.horizontalCenter
    }
}
