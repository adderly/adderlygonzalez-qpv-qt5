#include "fileinfo.h"

FileInfo::FileInfo(QFileInfo fileInfo, QObject *parent) :
    QObject(parent)
{
    m_fileInfo = fileInfo;
    m_isDrive = false;
    m_selected = false;
}

QFileInfo *FileInfo::info()
{
    return &m_fileInfo;
}

QString FileInfo::name() const
{
    QString name = m_fileInfo.fileName();
    if (name.isEmpty())
        name = m_fileInfo.filePath();

    return name;
}

QString FileInfo::source() const
{
    QString source;

    if (m_isDrive) {
        source = ":images/harddisk.svg";
    } else if (m_fileInfo.isDir()) {
        source = ":images/folder.svg";
    } else {
        source = m_fileInfo.absoluteFilePath();
    }

    return source;
}

bool FileInfo::isDir()
{
    return m_fileInfo.isDir();
}

void FileInfo::setIsDrive(bool arg)
{
    m_isDrive = arg;
}

bool FileInfo::isDrive()
{
    return m_isDrive;
}

void FileInfo::setSelected(bool arg)
{
    if (m_selected != arg) {
        m_selected = arg;
        emit selectedChanged(arg);
    }
}

bool FileInfo::selected() const
{
    return m_selected;
}
