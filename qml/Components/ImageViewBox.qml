
import QtQuick 1.1

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

    function show(fileInfo) {
        if (fileInfo.isDir())
            return;

        fullImage.source = "image://view/" + fileInfo.source;
        viewBox.adjustSize();
        viewBox.adjustX();
        viewBox.adjustY();
        viewBox.visible = true
    }

    function hide() {
        viewBox.visible = false;
    }
}

