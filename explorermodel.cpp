#include "explorermodel.h"

ExplorerModel::ExplorerModel(QObject *parent) :
    QAbstractListModel(parent)
{
    QHash<int, QByteArray> roles;
    roles.insert(rFileInfo, "fileInfo");
    setRoleNames(roles);


    m_suffixFilter = QImageReader::supportedImageFormats();
    //m_suffixFilter << "bmp" << "jpg" << "jpeg" << "png";

    m_dir.setSorting(QDir::DirsFirst | QDir::Name);

    m_mode = Folders;
    m_path = "#";
}

ExplorerModel *ExplorerModel::instance()
{
    static ExplorerModel *_instance = 0;
    if (!_instance) {
        _instance = new ExplorerModel();
    }

    return _instance;
}

QVariant ExplorerModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid())
        return QVariant();

    int row = index.row();

    switch (role) {
    case rFileInfo: {
        return QVariant::fromValue(m_filesList.at(row));
    } break;
    default:
        break;

    };

    return QVariant();
}

int ExplorerModel::rowCount(const QModelIndex &parent) const
{
    return m_filesList.count();
}

void ExplorerModel::update()
{
    emit beginUpdate();
    beginResetModel();

    clear();

    QFileInfo fileInfo;
    QFileInfoList list;

    switch (m_mode) {
    case Drivers: {
        list = m_dir.drives();
        setPath("");
    } break;
    case Folders: {
        list = m_dir.entryInfoList();
        setPath(m_dir.absolutePath());
    } break;
    }

    for (int i = 0; i < list.count(); ++i) {
        fileInfo = list.at(i);
        if (fileInfo.isDir() || m_suffixFilter.contains(fileInfo.suffix().toLower().toAscii())) {
            if (fileInfo.fileName() != "." && fileInfo.fileName() != "..") {
                FileInfo *fi = new FileInfo(fileInfo);
                fi->setIsDrive(m_mode == Drivers);
                m_filesList.append(fi);
            }
        }
    }

    endResetModel();
    emit endUpdate();
}

void ExplorerModel::clear()
{
    for (int i = 0; i < m_filesList.count(); ++i) {
        delete m_filesList.at(i);
    }

    m_filesList.clear();
}

void ExplorerModel::drives()
{
    m_mode = Drivers;
    update();
}

void ExplorerModel::changeDir(FileInfo *fileInfo)
{
    m_mode = Folders;
    if (fileInfo->info()->isDir()) {
        m_dir.cd(fileInfo->info()->absoluteFilePath());
        update();
    }
}

void ExplorerModel::changePath(QString path)
{
    if (!path.isEmpty()) {
        m_dir.setPath(path);
        update();
    } else {
        drives();
    }
}

void ExplorerModel::goUp()
{
    if (m_mode != Drivers) {
        if (m_dir.cdUp())
            update();
        else
            drives();
    }
}

void ExplorerModel::setPath(QString path)
{
    if (m_path != path) {
        m_path = path;
        emit pathChanged(path);
        emit dirChanged(path.right(path.count() - path.lastIndexOf("/") - 1));
    }
}

QString ExplorerModel::path() const
{
    return m_path;
}
