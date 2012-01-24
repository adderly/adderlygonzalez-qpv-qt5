import QtQuick 1.1


Item {
    id: holder

    property alias text: textItem.text

    signal accepted
    signal rejected

    width: window.width
    height: window.height

    MouseArea {
        id: holdMouseEvent
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
    }

    Rectangle {
        id: msgBox

        width: 280
        height: 120

        x: window.width / 2 - width / 2
        y: window.height / 2 - height / 2
        radius: 6
        border.width: 2
        border.color: "#666666"

        Item {
            id: contentItem
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: buttonLayout.top
            Text {
                id: textItem
                anchors.fill: parent
                anchors.margins: 4
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }
        }

        Row {
            id: buttonLayout
            height: 40
            width: childrenRect.width
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20
            Button {
                id: btnAcceptItem
                width: 90
                text: qsTr("Yes");
                onClicked: {
                    holder.accepted();
                    holder.visible = false;
                    holder.destroy();
                }
            }
            Button {
                id: btnRejectItem
                width: 90
                text: qsTr("No");
                onClicked: {
                    holder.rejected();
                    holder.visible = false;
                    holder.destroy();
                }
            }
        }
    }
}
