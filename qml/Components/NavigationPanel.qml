import QtQuick 1.1

Item {

    id: root_pn

    property string path: ""
    property string compName: qsTr("Computer")

    signal changePath(string path)

    anchors.top: parent.top
    anchors.bottom: parent.bottom

    function getNewPath(index) {
        var arr = new Array;
        arr = path.split("/");

        var newPath = "";
        for (var i = 0; i < index; ++i) {
            newPath += arr[i] + "/";
        }
        delete arr;

        changePath(newPath);
    }

    onPathChanged: {
        var arr = new Array;
        arr = path.split("/");

        pathModel.clear();
        pathModel.add(compName);
        for (var i = 0; i < arr.length; ++i) {
            var text = arr[i];
            if (text !== "")
                pathModel.add(text);
        }
        delete arr;

        view.positionViewAtEnd();
    }

    onWidthChanged: view.positionViewAtEnd();

    ListModel {
        id: pathModel

        function add(text) {
            append({"text": text})
        }
    }

    ListView {
        id: view
        anchors.fill: parent
        orientation: ListView.Horizontal
        clip: true
        model: pathModel
        delegate: pathButton
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
