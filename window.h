#ifndef WINDOW_H
#define WINDOW_H

#include <QObject>
#include <QtDeclarative>
#include "fileinfo.h"

class Window : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int width READ width NOTIFY widthChanged)
    Q_PROPERTY(int height READ height NOTIFY heightChanged)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(QString appShortName READ appShortName FINAL)

public:
    explicit Window(QObject *parent = 0);

    Q_INVOKABLE QString getExistingDirectory(QString path = "");
    Q_INVOKABLE void openImage(FileInfo *fi);

    void setView(QDeclarativeView *view);

    int width() const;
    int height() const;
    QString title() const;
    QString appShortName() const;


signals:
    
    void titleChanged(QString arg);
    void widthChanged(int arg);
    void heightChanged(int arg);

public slots:
    void setTitle(QString arg);
    void updateSize();

private:

    QDeclarativeView *m_view;

    int m_width;
    int m_height;

};

#endif // WINDOW_H
