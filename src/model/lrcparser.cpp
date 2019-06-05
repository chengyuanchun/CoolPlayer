#include "lrcparser.h"
#include <QFile>
#include <QDebug>
#include <QRegExp>
#include <QTime>

LrcParser::LrcParser(QObject *parent) : QObject(parent)
  , m_currentIndex(0)
{

}

QString LrcParser::currentLrc()
{
    return m_currentLrc;
}

void LrcParser::setCurrentLrc(QString lrc)
{
    if (lrc != m_currentLrc)
    {
        m_currentLrc = lrc;
        emit currentLrcChanged(m_currentLrc);
    }
}

int LrcParser::currentIndex()
{
    return m_currentIndex;
}

void LrcParser::setCurrentIndex(int index)
{
    if (m_currentIndex != index)
    {
        m_currentIndex = index;
        emit currentIndexChanged(m_currentIndex);
    }
}

void LrcParser::resolveLrc(const QString &fileName)
{
    QFile file(fileName);
    if (!file.open(QIODevice::ReadOnly))
    {
        qDebug() << "open " << fileName << " failed";
        return;
    }

    // 清空容器
    clear();

    QString text = QString::fromUtf8(file.readAll());
    QStringList lines = text.split("\r\n");
    // [00:05.54]
    QRegExp rx("\\[\\d{2}:\\d{2}\\.\\d+\\]");
    foreach (QString line, lines)
    {
        QString temp = line;
        temp.replace(rx, "");// 用空字符串替换时间获取歌词
        int pos = rx.indexIn(line, 0);
        while (pos != -1)
        {
            QString cap = rx.cap(0);
            // 将时间标签转换为数值 以毫秒为单位
            QRegExp regexp;
            regexp.setPattern("\\d{2}(?=:)");
            regexp.indexIn(cap);
            int minute = regexp.cap(0).toInt();
            regexp.setPattern("\\d{2}(?=\\.)");
            regexp.indexIn(cap);
            int second = regexp.cap(0).toInt();
            regexp.setPattern("\\d{2}(?=\\])");
            regexp.indexIn(cap);
            int millisecond = regexp.cap(0).toInt();
            qint64 totalTime = minute * 60000 + second * 1000 + millisecond * 10;

            m_lrcMap.insert(totalTime, temp);

            pos += rx.matchedLength();
            pos = rx.indexIn(line, pos);
        }
    }

    if (m_lrcMap.isEmpty())
    {
        qDebug() << "parse lrc error";
    }

    qDebug() << "read lrc finished";
    emit lrcLoadFinished();
}

void LrcParser::updateLrcByTime(qint64 time)
{
    // 歌曲总长度ms
    qint64 totalTimeValue = 3 * 60 * 1000;
    QTime totalTime(0, (totalTimeValue / 60000) % 60, (totalTimeValue / 1000) % 60);
    // 当前时间
    QTime currentTime(0, (time / 60000) % 60, (time / 1000) % 60);
    QString str = currentTime.toString("mm:ss") + "/" + totalTime.toString("mm:ss");

    // 获取当前时间对应的歌词
    if (!m_lrcMap.isEmpty())
    {
        // 获取当前时间在歌词中的前后两个时间点
        qint64 previous = 0;
        qint64 later = 0;
        //返回时间列表
        foreach (qint64 value, m_lrcMap.keys())
        {
            if (time >= value)
            {
                previous = value;
                setCurrentIndex(m_lrcMap.keys().indexOf(value));
            }
            else
            {
                later = value;
                break;
            }
        }

        // 达到最后一行 将later设置为歌曲总时间的值
        if (later == 0)
            later = totalTimeValue;

        // 获取当前对应的歌词内容
        QString currentLrc = m_lrcMap.value(previous);

        // 如果是新的歌词 那么重新开始显示歌词遮罩
        setCurrentLrc(currentLrc);
    }
}

QStringList LrcParser::lrcs()
{
    return m_lrcMap.values();
}

void LrcParser::clear()
{
    m_lrcMap.clear();
    m_currentLrc.clear();
    m_currentIndex = 0;
}
