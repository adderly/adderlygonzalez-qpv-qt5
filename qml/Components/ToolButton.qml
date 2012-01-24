import QtQuick 1.1

Item {
    id: button

    property string name: "unknown"
    property string source: ""

    signal clicked(variant mouse)
    signal pressAndHold(variant mouse)

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
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: button.clicked(mouse)
        onPressAndHold: button.pressAndHold(mouses)
    }
}
