#ifndef LRCPARSER_H
#define LRCPARSER_H

#include <QObject>
#include <QMap>

class LrcParser : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString currentLrc READ currentLrc WRITE setCurrentLrc NOTIFY currentLrcChanged)
    Q_PROPERTY(int currentIndex READ currentIndex WRITE setCurrentIndex NOTIFY currentIndexChanged)

public:
    explicit LrcParser(QObject *parent = nullptr);

    QString currentLrc();
    void setCurrentLrc(QString lrc);
    int currentIndex();
    void setCurrentIndex(int);

signals:
    void currentLrcChanged(QString);
    void currentIndexChanged(int);
    void lrcLoadFinished();

public slots:
    // 读取lrc文件
    void resolveLrc(const QString &fileName);
    // 根据时间设置当前歌词所在的index
    void updateLrcByTime(qint64 time);
    // 返回所有歌词
    QStringList lrcs();

private:
    void clear();

private:
    QMap<qint64, QString> m_lrcMap;
    QString m_currentLrc;
    int m_currentIndex;
};

#endif // LRCPARSER_H
