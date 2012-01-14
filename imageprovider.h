#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H

#include <QObject>
#include <QDeclarativeImageProvider>
#include <QImageReader>

class ImageProvider : public QObject, public QDeclarativeImageProvider
{
    Q_OBJECT
    Q_PROPERTY(int width READ width NOTIFY widthChanged)
    Q_PROPERTY(int height READ height NOTIFY heightChanged)
    Q_PROPERTY(int maxWidth READ maxWidth WRITE setMaxWidth NOTIFY widthChanged)
    Q_PROPERTY(int maxHeight READ maxHeight WRITE setMaxHeight NOTIFY heightChanged)

public:
    explicit ImageProvider(QObject *parent = 0);
    ~ImageProvider();
    virtual QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize);
    static QImage limitedImage(const QString &file_name, int maxWidth, int maxHeight);

    int width() const;
    int height() const;
    int maxWidth() const;
    int maxHeight() const;

public slots:
    void setWidth(int w);
    void setHeight(int h);
    void setMaxWidth(int mw);
    void setMaxHeight(int mh);

signals:
    void widthChanged(int arg);
    void heightChanged(int arg);

private:
    QString m_lastId;
    QImageReader m_reader;
    QImage m_image;
    int m_maxWidth;
    int m_maxHeight;
    int m_width;
    int m_height;
};

class ThumbImageProvider : public QObject, public QDeclarativeImageProvider
{
    Q_OBJECT
    Q_PROPERTY(int size READ size WRITE setSize NOTIFY sizeChanged)


public:
    explicit ThumbImageProvider(QObject *parent = 0);
    ~ThumbImageProvider();
    virtual QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize);

    int size() const;

public slots:
    void setSize(int arg);

signals:
    void sizeChanged(int arg);

private:
    int m_size;
};


class IconImageProvider : public QObject, public QDeclarativeImageProvider
{
    Q_OBJECT
    Q_PROPERTY(int size READ size WRITE setSize NOTIFY sizeChanged)


public:
    explicit IconImageProvider(QObject *parent = 0);
    ~IconImageProvider();
    virtual QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize);

    int size() const;

public slots:
    void setSize(int arg);

signals:
    void sizeChanged(int arg);

private:
    int m_size;
};


#endif // IMAGEPROVIDER_H
