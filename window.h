#ifndef WINDOW_H
#define WINDOW_H

#include <QObject>
#include <QtDeclarative>

class Window : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(QString appShortName READ appShortName FINAL)

public:
    explicit Window(QObject *parent = 0);

    Q_INVOKABLE QString getExistingDirectory(QString path = "");

    void setView(QDeclarativeView *view);

    QString title() const;
    QString appShortName() const;


signals:
    
    void titleChanged(QString arg);

public slots:
    void setTitle(QString arg);

private:

    QDeclarativeView *m_view;

};

#endif // WINDOW_H
