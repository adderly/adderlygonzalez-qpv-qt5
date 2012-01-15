#include "window.h"
#include <QFileDialog>
#include <QDebug>

Window::Window(QObject *parent) :
    QObject(parent)
{
}

QString Window::getExistingDirectory(QString path)
{
    return QFileDialog::getExistingDirectory(0, QString(), path);
}
