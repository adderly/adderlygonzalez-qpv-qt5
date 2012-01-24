#include "window.h"
#include <QFileDialog>
#include <QDebug>
#include <QDesktopServices>

Window::Window(QObject *parent) :
    QObject(parent)
{
    m_view = NULL;
    m_width = 0;
    m_height = 0;
}

void Window::setView(QDeclarativeView *view)
{
    m_view = view;
    connect(view, SIGNAL(sceneResized(QSize)), this, SLOT(updateSize()));
}

QString Window::getExistingDirectory(QString path)
{
    return QFileDialog::getExistingDirectory(0, QString(), path);
}

void Window::openImage(FileInfo *fi)
{
    QDesktopServices::openUrl(QUrl::fromLocalFile(fi->source()));
}

void Window::updateSize()
{
    Q_ASSERT(m_view != NULL);

    int nw = m_view->width();
    if (m_width != nw) {
        m_width = nw;
        emit widthChanged(nw);
    }

    int nh = m_view->height();
    if (m_height != nh) {
        m_height = nh;
        emit heightChanged(nh);
    }
}

int Window::width() const
{
    return m_width;
}

int Window::height() const
{
    return m_height;
}

QString Window::appShortName() const
{
    return QString("qpv");
}

void Window::setTitle(QString arg)
{
    Q_ASSERT(m_view != NULL);
    if (m_view->windowTitle() != arg) {
        m_view->setWindowTitle(arg);
        emit titleChanged(arg);
    }
}

QString Window::title() const
{
    Q_ASSERT(m_view != NULL);
    return m_view->windowTitle();
}
