#include <QtGui/QApplication>
#include <QtCore>
#include <QtDeclarative>
#include <QDebug>
#include "explorermodel.h"
#include "fileinfo.h"
#include "imageprovider.h"
#include "settings.h"
#include "window.h"

void registerTypes(const char *uri)
{
    // @uri Extensions
    qmlRegisterType<ExplorerModel>(uri, 1, 0, "ExplorerModel");
    qmlRegisterType<FileInfo>(uri, 1, 0, "FileInfo");
    qmlRegisterType<Settings>(uri, 1, 0, "Settings");
}

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QCoreApplication::setOrganizationName("Quick Photo Viewer");
    QCoreApplication::setOrganizationDomain("http://code.google.com/p/quick-photo-viewer/");
    //QCoreApplication::setApplicationName("Quick Photo Viewer");

    registerTypes("Extensions");

    QDeclarativeView view;
    QDeclarativeEngine* engine = view.engine();

    ImageProvider *viewImage = new ImageProvider();
    engine->addImageProvider("view", viewImage);
    engine->rootContext()->setContextProperty("image", viewImage);
    ThumbImageProvider *thumb = new ThumbImageProvider();
    engine->addImageProvider("thumb", thumb);
    engine->rootContext()->setContextProperty("thumb", thumb);
    IconImageProvider *icon = new IconImageProvider();
    engine->addImageProvider("icon", icon);
    engine->rootContext()->setContextProperty("icon", icon);

    engine->rootContext()->setContextProperty("settings", Settings::instance());
    Window *window = new Window();
    window->setView(&view);
    engine->rootContext()->setContextProperty("window", window);

    view.setResizeMode(QDeclarativeView::SizeRootObjectToView);
    view.setViewportUpdateMode(QGraphicsView::FullViewportUpdate);
    view.setMinimumSize(320, 480);
    view.setWindowIcon(QIcon(":/qpv.ico"));
    view.setSource(QUrl("qrc:/qml/Main.qml"));
    view.showMaximized();
    //view.show();

    return app.exec();
}
