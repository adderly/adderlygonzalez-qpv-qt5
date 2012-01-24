import QtQuick 1.1

Rectangle {
    id: button

    property alias text: textItem.text

    property int maxWidth: 80
    property int minWidth: 30

    property int margin: 2
    property int textMargin: 4

    signal clicked

    height: 30
    width: 60
    anchors.leftMargin: margin
    anchors.rightMargin: margin
    border.width: 1
    border.color: "#999999"
    radius: 4
    smooth: true
    state: "normal"

    Item {
        anchors.fill: parent

        Text {
            id: textItem
            anchors.fill: parent
            anchors.margins: button.textMargin
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: button.clicked()
        onPressed: button.state = "pressed"
        onReleased: button.state = "normal"
    }

    states: [
        State {
            name: "normal"
            PropertyChanges {target: button; gradient: backgrounGradient}
        },
        State {
            name: "pressed"
            PropertyChanges {target: button; gradient: backgroundPressedGradient}
        }
    ]

    Gradient {
        id: backgrounGradient
        GradientStop { position: 0.0; color: "#EFEBE7" }
        GradientStop { position: 0.5; color: "#dFdBd7" }
        GradientStop { position: 1.0; color: "#EFEBE7" }
    }

    Gradient {
        id: backgroundPressedGradient
        GradientStop { position: 0.0; color: "#81B4EB" }
        GradientStop { position: 0.5; color: "#729fcf" }
        GradientStop { position: 1.0; color: "#81B4EB" }
    }
}

