#ifndef FILEITEM_H
#define FILEITEM_H

#include <QObject>
#include <QtDeclarative>

class FileInfo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name NOTIFY nameChanged)
    Q_PROPERTY(QString source READ source NOTIFY sourceChanged)
    Q_PROPERTY(bool selected READ selected WRITE setSelected NOTIFY selectedChanged)

public:
    explicit FileInfo(QFileInfo fileInfo = QFileInfo(), QObject *parent = 0);

    QFileInfo *info();

    QString name() const;
    QString source() const;
    bool selected() const;

    Q_INVOKABLE bool isDir();

    void setIsDrive(bool arg);
    bool isDrive();

signals:
    void nameChanged(QString arg);
    void sourceChanged(QString arg);
    void selectedChanged(bool arg);

public slots:
    void setSelected(bool arg);

private:
    QFileInfo m_fileInfo;
    bool m_isDrive;
    bool m_selected;
};

QML_DECLARE_TYPE(FileInfo)

#endif // FILEITEM_H
