#ifndef EXPLORERMODEL_H
#define EXPLORERMODEL_H

#include <QtDeclarative>
#include <QAbstractListModel>
#include "fileinfo.h"

class ExplorerModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(QString path READ path NOTIFY pathChanged)
    Q_PROPERTY(int selectedCount READ selectedCount NOTIFY selectedCountChanged)

public:
    explicit ExplorerModel(QObject *parent = 0);
    static ExplorerModel *instance();

    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;

    Q_INVOKABLE void update();
    void clear(bool notSelected = true);

    Q_INVOKABLE void drives();
    Q_INVOKABLE void changeDir(FileInfo *fileInfo);
    Q_INVOKABLE bool changePath(QString path);
    Q_INVOKABLE void goUp();
    Q_INVOKABLE void changeSelected(FileInfo *fi);
    Q_INVOKABLE void clearSelected();
    Q_INVOKABLE void copySelected(QString path);
    Q_INVOKABLE void showSelected();
    Q_INVOKABLE void deleteSelected();

    QString path() const;
    void setPath(QString path);
    int selectedCount() const;

signals:
    void beginUpdate();
    void endUpdate();
    void pathChanged(QString arg);
    void dirChanged(QString dirName);
    void progressChanged(double value);
    void selectedCountChanged(int arg);

public slots:


private:

    enum Roles {
        rFileInfo = Qt::UserRole + 1
    };

    enum Mode {
        Drivers = 0,
        Folders
    };

    Mode m_mode;
    QDir m_dir;
    QList<QByteArray> m_suffixFilter;
    QList<FileInfo *> m_filesList;

    QHash<QString, FileInfo *> m_selectedCache;

    QString m_compName;
    QString m_path;
    QString m_lastPath;
};

QML_DECLARE_TYPE(ExplorerModel)

#endif // EXPLORERMODEL_H
