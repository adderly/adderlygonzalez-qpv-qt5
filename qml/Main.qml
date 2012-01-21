import QtQuick 1.1
import Extensions 1.0
import "Components" 1.0
import "Fn.js" as Fn

Page {

    id: main

    property Item selectedActionDialog: null
    property string lastCopyPath: ""

    ExplorerModel {
        id: explorerModel
        onBeginUpdate: Fn.addFolderPosition(explorerModel.path, grid.view.indexAt(0, grid.view.contentY))
        onEndUpdate: {
            settings.lastPath = explorerModel.path;
            grid.view.positionViewAtIndex(Fn.getFolderPosition(explorerModel.path), GridView.Beginning)
        }

        onDirChanged: {
            var title = "";
            if (dirName != "")
                title = dirName;
            else if (explorerModel.path != "")
                title = explorerModel.path
            else
                title = main.compName;

            window.title = title + " - " + window.appShortName;
        }

        Component.onCompleted: explorerModel.changePath(settings.lastPath)
        onProgressChanged: progressPanel.value = value;
    }

    ThumbGrid {
        id: grid
        anchors.top: progressPanel.bottom
        anchors.bottom: parent.bottom
    }

    Progress {
        id: progressPanel
        anchors.top: toolBar.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        value: 0
        visible: value > 0
    }

    Rectangle {
        id: toolBar
        anchors.left: parent.left
        anchors.right: parent.right
        height: 48
        color: "#EFEBE7"

        Component.onCompleted: icon.size = height

        NavigationPanel {
            anchors.left: parent.left
            anchors.right: buttonLayout.left
            anchors.margins: 8
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

            ToolButtonMenu {
                source: "image://icon/:images/selected.svg"
                Component.onCompleted: {
                    add("show", qsTr("Show"), true);
                    add("copy", qsTr("Copy"), true);
                    add("archive", qsTr("Archive"), false);
                    add("edit", qsTr("Edit"), false);
                    add("delete", qsTr("Delete"), true);
                    add("fileslist", qsTr("List of files"), false);
                }

                onMenuClicked: {
                    switch (name) {
                    case "show": {
                        explorerModel.showSelected()
                    } break;
                    case "copy": {
                        if (main.lastCopyPath == "")
                            main.lastCopyPath = explorerModel.path
                        main.lastCopyPath = window.getExistingDirectory(main.lastCopyPath);
                        explorerModel.copySelected(main.lastCopyPath);
                        progressPanel.visible = true;
                    } break;
                    case "delete": {
                        explorerModel.deleteSelected()
                        progressPanel.visible = true;
                    } break;

                    }
                }
            }

            ToolButton {
                source: "image://icon/:images/zoom-in.svg"
                onClicked: grid.thumbSizeIn()
            }

            ToolButton {
                source: "image://icon/:images/zoom-out.svg"
                onClicked: grid.thumbSizeOut()
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

    ImageViewBox {
        id: viewBox
    }
}
