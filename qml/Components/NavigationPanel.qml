import QtQuick 1.1

Item {

    id: root_pn

    property string path: ""

    signal changePath(string path)

    anchors.top: parent.top
    anchors.bottom: parent.bottom

    function getNewPath(index) {
        var arr = new Array;
        arr = path.split("/");
        var newPath = "";
        for (var i = 0; i <= index; ++i) {
            newPath += arr[i] + "/";
        }
        delete arr;
        changePath(newPath);
    }

    onPathChanged: {
        var arr = new Array;
        arr = path.split("/");

        pathModel.clear();
        for (var i = 0; i < arr.length; ++i) {
            var text = arr[i];
            if (text !== "")
                pathModel.add(text);
        }
        delete arr;
        input.text = path;
        view.positionViewAtEnd();
    }

    onWidthChanged: view.positionViewAtEnd();

    ListModel {
        id: pathModel

        function add(text) {
            append({"text": text})
        }
    }

    Rectangle {
        id: button

        height: parent.height
        width: height
        anchors.left: parent.left
        border.width: 1
        border.color: "#999999"
        radius: 4
        smooth: true
        gradient: Gradient {
            id: baclgrounGradient
            GradientStop { position: 0.0; color: "#EFEBE7" }
            GradientStop { position: 0.5; color: "#dFdBd7" }
            GradientStop { position: 1.0; color: "#EFEBE7" }
        }

        Image {
            id: icon
            anchors.fill: parent
            anchors.margins: 4
            smooth: true
            source: "image://icon/:images/computer.svg"
        }

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: {
                if (mouse.button == Qt.RightButton)
                    root_pn.toggleInputPanel();
                else
                    root_pn.changePath("");
            }
            onPressAndHold: root_pn.toggleInputPanel()
        }
    }

    ListView {
        id: view
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: button.right
        anchors.right: parent.right
        orientation: ListView.Horizontal
        clip: true
        model: pathModel
        delegate: pathButton
    }

    Rectangle {
        id: inputPanel
        height: root_pn.height
        anchors.top: view.bottom
        anchors.right: view.right
        anchors.topMargin: 2
        radius: 4
        anchors.left: view.left
        border.width: 1
        border.color: "#666666"
        visible: false

        TextInput {
            id: input
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 4
            font.pointSize: 10
            selectByMouse: true
        }

        Keys.onPressed: {
            switch (event.key) {
            case Qt.Key_Return:
            case Qt.Key_Enter: {
                root_pn.changePath(input.text);
            } break;
            case Qt.Key_Escape: {
                inputPanel.visible = false;
            } break;
            default:
                break
            }
            event.accepted = true;
        }
    }

    function toggleInputPanel() {
        inputPanel.visible = !inputPanel.visible
    }

    Component {
        id: pathButton
        Item {
            id: item

            property int maxWidth: 80
            property int minWidth: 30

            property int margin: 2
            property int textMargin: 4

            anchors.top: parent ? parent.top : undefined
            anchors.bottom: parent ? parent.bottom : undefined
            width: {
                var w = Math.min(textHelper.paintedWidth, maxWidth) + margin * 2 + textMargin * 2
                return Math.max(w, minWidth)
            }

            Rectangle {
                anchors.fill: parent
                anchors.leftMargin: margin
                anchors.rightMargin: margin
                border.width: 1
                border.color: "#999999"
                radius: 4
                smooth: true
                gradient: Gradient {
                    id: baclgrounGradient
                    GradientStop { position: 0.0; color: "#EFEBE7" }
                    GradientStop { position: 0.5; color: "#dFdBd7" }
                    GradientStop { position: 1.0; color: "#EFEBE7" }
                }

                Item {
                    anchors.fill: parent

                    Text {
                        id: text
                        anchors.fill: parent
                        anchors.margins: item.textMargin
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        elide: Text.ElideRight
                        text: model.text
                    }
                }

                Text {
                    id: textHelper
                    text: text.text
                    visible: false
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: root_pn.getNewPath(model.index);
                }
            }
        }
    }
}
