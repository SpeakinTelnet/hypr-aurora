import QtQuick 2.15
import QtQuick.Controls 2.15


Column {
    id: clock

    Label {
        id: timeLabel

        anchors.horizontalCenter: parent.horizontalCenter

        font.pointSize: root.font.pointSize * 9
        color: "white"
        renderType: Text.QtRendering

        function updateTime() {
            text = new Date().toLocaleTimeString(Qt.locale(Locale.ShortFormat), "HH:mm")
        }
    }

    Label {
        id: dateLabel

        anchors.horizontalCenter: parent.horizontalCenter
        
        font.pointSize: root.font.pointSize * 2
        color: "white"
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
        margins: 10
        top: parent.top
        horizontalCenter: parent.horizontalCenter
    }
}
