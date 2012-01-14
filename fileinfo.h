#ifndef FILEITEM_H
#define FILEITEM_H

#include <QObject>
#include <QtDeclarative>

class FileInfo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name NOTIFY nameChanged)
    Q_PROPERTY(QString source READ source NOTIFY sourceChanged)

public:
    explicit FileInfo(QFileInfo fileInfo = QFileInfo(), QObject *parent = 0);

    QFileInfo *info();

    QString name() const;
    QString source() const;

    Q_INVOKABLE bool isDir();

    void setIsDrive(bool arg);


signals:
    void nameChanged(QString arg);
    void sourceChanged(QString arg);

public slots:

private:
    QFileInfo m_fileInfo;
    bool m_isDrive;
};

QML_DECLARE_TYPE(FileInfo)

#endif // FILEITEM_H
