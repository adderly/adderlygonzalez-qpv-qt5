import QtQuick 1.1

Item {
    id: page

    property Item dialog: null

    function createDialog(name, source) {
        switch (source) {
        case "MsgBox": {
            source = "MsgBox.qml"
        } break;
        }

        var component = Qt.createComponent(source)

        if (component.status === Component.Ready) {
            dialog = component.createObject(page);
            if (dialog === null) {
                console.debug("Error Handling parent: " + parent);
            }
        } else if (component.status === Component.Error) {
            console.debug("Error loading component:", component.errorString());
        }

        return dialog;
    }
}
