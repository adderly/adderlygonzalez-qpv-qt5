import QtQuick 1.1

Item {
    id: button

    property string name: "unknown"
    property string source: ""

    signal clicked
    signal pressAndHold

    height: parent.height
    width: height

    Image {
        id: icon
        anchors.fill: parent
        smooth: true
        source: button.source
    }

    MouseArea {
        anchors.fill: parent
        onClicked: button.clicked()
        onPressAndHold: button.pressAndHold()
    }
}
