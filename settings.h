#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QSettings>

class Settings : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariant thumbSize READ thumbSize WRITE setThumbSize NOTIFY valueChanged)
    Q_PROPERTY(QVariant lastPath READ lastPath WRITE setLastPath NOTIFY valueChanged)

public:
    explicit Settings(QObject *parent = 0);
    static Settings *instance();

    QVariant thumbSize() const;
    QVariant lastPath() const;

signals:
    void valueChanged(const QString& valueName);
    
public slots:
    void setThumbSize(QVariant arg);
    void setLastPath(QVariant arg);

private:
    QSettings m_settings;
    
};

#endif // SETTINGS_H
