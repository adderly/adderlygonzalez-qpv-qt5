#include "window.h"
#include <QFileDialog>
#include <QDebug>
#include <QDesktopServices>

Window::Window(QObject *parent) :
    QObject(parent)
{
    m_view = NULL;
}

void Window::setView(QDeclarativeView *view)
{
    m_view = view;
}

QString Window::getExistingDirectory(QString path)
{
    return QFileDialog::getExistingDirectory(0, QString(), path);
}

void Window::openImage(FileInfo *fi)
{
    QDesktopServices::openUrl(QUrl::fromLocalFile(fi->source()));
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
