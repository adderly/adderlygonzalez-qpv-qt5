#ifndef WINDOW_H
#define WINDOW_H

#include <QObject>

class Window : public QObject
{
    Q_OBJECT
public:
    explicit Window(QObject *parent = 0);

    Q_INVOKABLE QString getExistingDirectory(QString path = "");
    
signals:
    
public slots:
    
};

#endif // WINDOW_H
