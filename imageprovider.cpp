#include "imageprovider.h"
#include <QDebug>
#include <QUrl>

// ----------------------- ImageProvider -------------------------------------

ImageProvider::ImageProvider(QObject *parent)
    : QObject(parent), QDeclarativeImageProvider(QDeclarativeImageProvider::Image)
{
    m_maxWidth = 800;
    m_maxHeight = 800;
}

ImageProvider::~ImageProvider()
{
}

QImage ImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    QImage image = limitedImage(id, m_maxWidth, m_maxHeight);
    *size = image.size();
    setWidth(image.width());
    setHeight(image.height());
    return image;
}

QImage ImageProvider::limitedImage(const QString &file_name, int maxWidth, int maxHeight)
{
    QImageReader reader(file_name);
    if (!reader.canRead()) {
        QImage image;
        return image;
    }

    int image_width = reader.size().width();
    int image_height = reader.size().height();

    if (image_width > maxWidth) {
        image_height = static_cast<double>(maxWidth) / image_width * image_height;
        image_width = maxWidth;
    }

    if (image_height > maxHeight) {
        image_width = static_cast<double>(maxHeight) / image_height * image_width;
        image_height = maxHeight;
    }

    reader.setScaledSize(QSize(image_width, image_height));
    return reader.read();
}

void ImageProvider::setWidth(int arg)
{
    if (m_width != arg) {
        m_width = arg;
        emit widthChanged(arg);
    }
}

int ImageProvider::width() const
{
    return m_width;
}

void ImageProvider::setHeight(int arg)
{
    if (m_height != arg) {
        m_height = arg;
        emit heightChanged(arg);
    }
}

int ImageProvider::height() const
{
    return m_height;
}

void ImageProvider::setMaxWidth(int arg)
{
    if (m_maxWidth != arg) {
        m_maxWidth = arg;
        emit widthChanged(arg);
    }
}

int ImageProvider::maxWidth() const
{
    return m_maxWidth;
}


void ImageProvider::setMaxHeight(int arg)
{
    if (m_maxHeight != arg) {
        m_maxHeight = arg;
        emit heightChanged(arg);
    }
}

int ImageProvider::maxHeight() const
{
    return m_maxHeight;
}


// ------------------------ ThumbImageProvider ------------------------

ThumbImageProvider::ThumbImageProvider(QObject *parent)
    : QObject(parent), QDeclarativeImageProvider(QDeclarativeImageProvider::Image)
{
    m_size = 200;
}

ThumbImageProvider::~ThumbImageProvider()
{
}

QImage ThumbImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    //qDebug() << Q_FUNC_INFO << "id = " << id ;//<< " size = " << size << " requestedSize = " << requestedSize;

    QImage image = ImageProvider::limitedImage(id, m_size, m_size);
    //image.load(id);
    if (!image.isNull() && size)
        *size = image.size();
    return image;
}

void ThumbImageProvider::setSize(int arg)
{
    if (m_size != arg) {
        m_size = arg;
        emit sizeChanged(arg);
    }
}

int ThumbImageProvider::size() const
{
    return m_size;
}


// ------------------------ IconImageProvider ------------------------

IconImageProvider::IconImageProvider(QObject *parent)
    : QObject(parent), QDeclarativeImageProvider(QDeclarativeImageProvider::Image)
{
    m_size = 48;
}

IconImageProvider::~IconImageProvider()
{
}

QImage IconImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    //qDebug() << Q_FUNC_INFO << "id = " << id << " size = " << size << " requestedSize = " << requestedSize;

    QImage image = ImageProvider::limitedImage(id, m_size, m_size);
    //image.load(id);
    if (!image.isNull() && size)
        *size = image.size();
    return image;
}

void IconImageProvider::setSize(int arg)
{
    if (m_size != arg) {
        m_size = arg;
        emit sizeChanged(arg);
    }
}

int IconImageProvider::size() const
{
    return m_size;
}


