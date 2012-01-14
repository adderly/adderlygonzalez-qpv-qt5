#include "settings.h"

Settings::Settings(QObject *parent) :
    QObject(parent)
{
}

Settings *Settings::instance()
{
    static Settings *_instance = 0;
    if (!_instance) {
        _instance = new Settings();
    }

    return _instance;
}

void Settings::setThumbSize(QVariant arg)
{
    if (arg != thumbSize()) {
        m_settings.setValue("thumbSize", arg);
    }
}

QVariant Settings::thumbSize() const
{
    return m_settings.value("thumbSize", QVariant::fromValue(180));
}

void Settings::setLastPath(QVariant arg)
{
    if (arg != lastPath()) {
        m_settings.setValue("lastPath", arg);
    }
}

QVariant Settings::lastPath() const
{
    return m_settings.value("lastPath", QVariant::fromValue(QString("")));
}
