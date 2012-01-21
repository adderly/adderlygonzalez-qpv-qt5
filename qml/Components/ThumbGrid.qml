
import QtQuick 1.1

Item {
    id: gridBox

    property alias view: gridView

    width: gridView.cellWidth * gridView.columns
    clip: true

    function thumbSizeIn() {
        if (gridView.thumbSize <= 360) {
            gridView.thumbSize += 30
            if (gridView.columns == 0) gridView.thumbSize -= 30
            explorerModel.update();
        }
    }

    function thumbSizeOut() {
        if (gridView.thumbSize >= 90) {
            gridView.thumbSize -= 30
            explorerModel.update();
        }
    }

    GridView {
        id: gridView

        property int thumbSize: settings.thumbSize
        property int cellMargin: 60

        property int columns: Math.max(Math.floor(gridBox.parent.width / gridView.cellWidth), 1)

        onThumbSizeChanged: {
            thumb.size = gridView.thumbSize;
            settings.thumbSize = gridView.thumbSize;
        }

        Component.onCompleted: thumb.size = gridView.thumbSize;

        anchors.fill: parent
        anchors.topMargin: cellMargin / 2

        cellHeight: thumbSize + cellMargin
        cellWidth: thumbSize + cellMargin

        model: explorerModel
        delegate: Item {
            width: gridView.cellWidth
            height: gridView.cellHeight

            Column {
                anchors.fill: parent
                Rectangle {
                    width: gridView.thumbSize + border.width
                    height: gridView.thumbSize + border.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    border.color: "#eeeeee"
                    border.width: 1

                    Image {
                        id: imageItem
                        anchors.centerIn: parent
                        asynchronous: true
                        cache: false
                        source: "image://thumb/" + fileInfo.source;
                    }

                    Image {
                        id: selectedItem
                        source: "image://icon/:images/selected.svg";
                        visible: fileInfo.selected
                    }

                    MouseArea {
                        property int row: Math.floor(model.index / gridView.columns)
                        property int column: model.index - row * gridView.columns
                        property int deltaX: (column * gridView.cellWidth) + ((gridView.cellWidth - imageItem.width) / 2)
                        property int deltaY: (row * gridView.cellHeight) + ((gridView.cellHeight - imageItem.height) / 2) - gridView.contentY + gridView.y
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            if (fileInfo.isDir())
                                explorerModel.changeDir(fileInfo);
                            else
                                explorerModel.changeSelected(fileInfo);//fileInfo.selected = !fileInfo.selected
                        }
                        onEntered: viewBox.show(fileInfo);
                        onExited: viewBox.hide();
                        onMouseXChanged: viewBox.mouseX = deltaX + mouseX;
                        onMouseYChanged: viewBox.mouseY = deltaY + mouseY
                    }
                }

                Text {
                    anchors.right: parent.right
                    anchors.left: parent.left
                    horizontalAlignment: Text.AlignHCenter
                    elide: Text.ElideMiddle
                    text: fileInfo.name
                }
            }
        }
    }
}
