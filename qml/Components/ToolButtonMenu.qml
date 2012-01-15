
import QtQuick 1.1


ToolButton {
    id: tbmenu

    property int maxWidth: 250

    signal menuClicked(string name)

    onClicked:  menubox.visible = !menubox.visible

    function add(name, title, enabled) {
        menuModel.append({ "name": name, "title": title, "enabled": enabled})
    }

    MouseArea {
        id: holder
        width: window.width
        height: window.height
        x: 0
        y: menubox.y
        hoverEnabled: true
        onClicked: menubox.visible = false
        visible: menubox.visible
        onVisibleChanged: {
            if (visible) {
                var wp = mapFromItem(null, 0, 0);
                holder.x = wp.x
            } else {
                holder.x = 0
            }
        }
    }

    Rectangle {
        id: menubox
        width: 180
        height: 240 // fixme
        y: tbmenu.y + tbmenu.height + 10

        border.color: "#666666"
        border.width: 1
        radius: 6
        smooth: true
        visible: false
        onVisibleChanged: adjustX()

        function adjustX() {
            if (visible) {
                var defX = menubox.width / 2 * -1;
                var minX = mapFromItem(null, window.width - menubox.width - 10, y).x;
                menubox.x = Math.min(defX, minX);
            } else {
                menubox.x = 0
            }
        }

        ListModel {
            id: menuModel
        }

        ListView {
            id: menuView
            anchors.fill: parent
            interactive: false
            model: menuModel
            delegate: menuDelegate
        }

        Component {
            id: menuDelegate

            Item {
                anchors.right: parent.right
                anchors.left: parent.left
                height: 40

                Rectangle {
                    anchors.right: parent.right
                    anchors.left: parent.left
                    height: 1
                    color: "#2e3436"
                    visible: model.index > 0
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    smooth: true
                    text: model.title
                    font.pointSize: 14
                    color: model.enabled ? "#2e3436" : "#888a85"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked:{
                        menubox.visible = false
                        tbmenu.menuClicked(model.name)
                    }
                }
            }
        }
    }
}
