import QtQuick 1.1

Item {

    property variant view: null
    property real position
    property bool interactive: true
    property bool moving: timer.running

    property int sliderWidth: 8
    property int sliderHeight: 40
    property int scrollAreaWidth: 50
    property color moveColor: "#81B4EB"
    property color quietColor: "#888a85"

    id: scrollItem

    height: parent.height
    width: interactive ? 50 : sliderWidth
    anchors.right: view.right

    position: view.visibleArea.yPosition
    onPositionChanged: {
        if (!timer.running) {
            var vy

            if (view.visibleArea.heightRatio < 1) {
                vy = position * (scrollItem.height - slider.height) / (1 - view.visibleArea.heightRatio)
            } else {
                vy = position * (scrollItem.height - slider.height)
            }

            slider.y = vy
        }
    }

    Rectangle {
        id: slider
        width: sliderWidth
        height: Math.max(view.visibleArea.heightRatio * view.height, sliderHeight)
        visible: view.contentHeight > view.height
        color: quietColor
        radius: 4
        anchors.right: parent.right
    }

    MouseArea {
        id: movingArea
        enabled: parent.interactive
        drag.target: slider
        drag.axis: Drag.YAxis
        drag.minimumY: 0
        drag.maximumY: scrollItem.height - slider.height
        anchors.fill: parent
        hoverEnabled: true
        onPressed: {
            timer.running = true
            slider.width = 2 * sliderWidth
        }
        onReleased: {
            timer.running = false
            slider.width = sliderWidth
        }
    }

    Timer {
        id: timer
        interval: 100; running: false; repeat: true
        onTriggered: {
            var index = 0;
            var sliderRatio = slider.y / (scrollItem.height - slider.height)
            var needHeight = view.contentHeight * sliderRatio
            var itemHeight = view.contentHeight / view.count

            index = needHeight / itemHeight
            index = index.toFixed()
            index = (index > 0) ? (index - 1) : 0
            view.positionViewAtIndex(index, ListView.Beginning)
        }
    }

    states: [
        State {
            when: (view.moving || movingArea.drag.active || timer.running)
            PropertyChanges {target: slider; color: moveColor}
        }
    ]
}
