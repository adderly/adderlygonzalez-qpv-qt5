QT = core gui declarative svg

win32:RC_FILE = win_icon.rc

RESOURCES += \
    resources.qrc

SOURCES += main.cpp \
    explorermodel.cpp \
    fileinfo.cpp \
    imageprovider.cpp \
    settings.cpp \
    window.cpp

HEADERS += \
    explorermodel.h \
    fileinfo.h \
    imageprovider.h \
    settings.h \
    window.h

OTHER_FILES += \
    qml/Main.qml \
    qml/ToolButton.qml \
    qml/PathNav.qml \
    qml/Fn.js \
    qml/Components/ToolPanel.qml \
    qml/Components/ToolButton.qml \
    qml/Components/NavigationPanel.qml \
    qml/Components/PageTemplate.qml \
    qml/Components/Page.qml \
    qml/Components/ToolButtonMenu.qml \
    qml/Components/Progress.qml \
    qml/Components/ImageViewBox.qml \
    qml/Components/ThumbGrid.qml














