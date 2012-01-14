import QtQuick 1.1
import Extensions 1.0
import "." 1.0
import "Fn.js" as Fn

Item {

    id: window

    property string appName: "qpv"
    property string compName: qsTr("Computer")

    Rectangle {
        id: toolBar
        anchors.left: parent.left
        anchors.right: parent.right
        height: 48
        color: "#EFEBE7"
        //border.color: "#666666"
        //border.width: 1

        Component.onCompleted: icon.size = height

        PathNav {
            anchors.left: parent.left
            anchors.right: buttonLayout.left
            anchors.margins: 8
            compName: window.compName
            path: explorerModel.path
            onChangePath: explorerModel.changePath(path);

        }

        Row {
            id: buttonLayout
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            width: childrenRect.width
            anchors.margins: 8
            spacing: 16

            //            ToolButton {
            //                name: "go-up"
            //                source: "image://icon/images/go-up.svg"
            //                onClicked: explorerModel.goUp();
            //            }

            //            ToolButton {
            //                name: "computer"
            //                source: "image://icon/images/computer.svg"
            //                onClicked: explorerModel.drives();
            //            }

            ToolButton {
                source: "image://icon/:images/zoom-in.svg"
                onClicked: gridView.thumbSizeIn()
            }

            ToolButton {
                source: "image://icon/:images/zoom-out.svg"
                onClicked: gridView.thumbSizeOut()
            }
        }
    }

    ExplorerModel {
        id: explorerModel
        onBeginUpdate: Fn.addFolderPosition(explorerModel.path, gridView.indexAt(0, gridView.contentY))
        onEndUpdate: {
            settings.lastPath = explorerModel.path;
            gridView.positionViewAtIndex(Fn.getFolderPosition(explorerModel.path), GridView.Beginning)
        }

        onDirChanged: {
            var windowTitle = "";
            if (dirName != "")
                windowTitle = dirName;
            else if (explorerModel.path != "")
                windowTitle = explorerModel.path
            else
                windowTitle = window.compName;

            view.windowTitle = windowTitle + " - " + window.appName;
        }

        Component.onCompleted: explorerModel.changePath(settings.lastPath)
    }

    Item {
        id: gridBox

        anchors.top: toolBar.bottom
        width: gridView.cellWidth * gridView.columns
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true

        GridView {
            id: gridView

            property int thumbSize: settings.thumbSize
            property int cellMargin: 60

            property int columns: Math.max(Math.floor(window.width / gridView.cellWidth), 1)

            function thumbSizeIn() {
                if (gridView.thumbSize <= 360) {
                    gridView.thumbSize += 30
                    if (columns == 0) gridView.thumbSize -= 30
                    explorerModel.update();
                }
            }

            function thumbSizeOut() {
                if (gridView.thumbSize >= 90) {
                    gridView.thumbSize -= 30
                    explorerModel.update();
                }
            }

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

                        MouseArea {
                            property int row: Math.floor(model.index / gridView.columns)
                            property int column: model.index - row * gridView.columns
                            property int deltaX: (column * gridView.cellWidth) + ((gridView.cellWidth - imageItem.width) / 2)
                            property int deltaY: (row * gridView.cellHeight) + ((gridView.cellHeight - imageItem.height) / 2) - gridView.contentY + gridView.y
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: explorerModel.changeDir(fileInfo);
                            onEntered: showImage(fileInfo);
                            onExited: hideImage();
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

    onHeightChanged: image.maxHeight = height - viewBox.boxMargin * 2;
    onWidthChanged: image.maxWidth = width - viewBox.boxMargin * 2;

    Rectangle {
        id: faber
        anchors.fill: parent
        color: "#000000"
        opacity: viewBox.visible ? 0.8 : 0
        visible:  false
        Behavior on opacity {
            NumberAnimation { duration: 1000 }
        }
    }

    Rectangle {
        id: viewBox
        property int mouseX: 0
        property int mouseY: 0

        property int boxMargin: 10
        property int imageMargin: 5

        property int maxHeight: window.height - boxMargin * 2
        property int maxWidth: Math.max(mouseX, window.width - mouseX) - boxMargin

        onMaxHeightChanged: adjustSize();
        onMaxWidthChanged: adjustSize();

        onMouseXChanged: adjustX();
        onMouseYChanged: adjustY();

        border.color: "#666666"
        border.width: 1

        visible: false

        function adjustX() {
            if (mouseX <= width) {
                x = mouseX;
            } else {
                x = mouseX - width;
            }
        }

        function adjustY() {
            var vCenter = mouseY - height / 2;
            y = Math.max(Math.min(vCenter, window.height - height - boxMargin), boxMargin)
        }

        function adjustSize() {
            var image_width = image.width;
            var image_height = image.height;

            if (image_width > maxWidth) {
                image_height = maxWidth / image_width * image_height;
                image_width = maxWidth;
            }

            if (image_height > maxHeight) {
                image_width = maxHeight / image_height * image_width;
                image_height = maxHeight;
            }

            width = image_width;
            height = image_height;
        }

        Image {
            id: fullImage
            anchors.fill: parent
            anchors.margins: 5
            anchors.centerIn: parent
            cache: false
            smooth: true
            fillMode: Image.PreserveAspectFit
        }
    }

    function showImage(fileInfo) {
        if (fileInfo.isDir())
            return;

        fullImage.source = "image://view/" + fileInfo.source;
        viewBox.adjustSize();
        viewBox.adjustX();
        viewBox.adjustY();
        viewBox.visible = true
    }

    function hideImage() {
        viewBox.visible = false;
    }
}
