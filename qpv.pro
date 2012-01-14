QT = core gui declarative svg

win32:RC_FILE = win_icon.rc

RESOURCES += \
    resources.qrc

SOURCES += main.cpp \
    explorermodel.cpp \
    fileinfo.cpp \
    imageprovider.cpp \
    settings.cpp

HEADERS += \
    explorermodel.h \
    fileinfo.h \
    imageprovider.h \
    settings.h

OTHER_FILES += \
    qml/Main.qml \
    qml/ToolButton.qml \
    qml/PathNav.qml \
    qml/Fn.js














