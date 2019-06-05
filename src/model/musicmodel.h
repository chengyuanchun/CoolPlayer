#ifndef MUSICMODEL_H
#define MUSICMODEL_H

#include <QObject>
#include <QList>
#include "common.h"

class LrcParser;

class MusicModel : public QObject
{
    Q_OBJECT

public:
    explicit MusicModel(QObject *parent = nullptr);

    // 读取歌手歌曲信息
    void loadSingerAndSongs();

    // 加载歌词
    void loadLrc();

    // 通过时间更新当前歌词
    void updateCurrentLrcByTime(qint64 time);

    // 获取所有歌词
    QStringList lrcLines();

    // 获取当前歌词所在坐标
    int currentLrcIndex();

    // 返回封面信息
    QList<CoverData> coverInfos();

    // 返回歌曲列表
    QList<QString> musicNames(const QString &singer);

    // 根据歌曲返回时间
    QString musicTime(const QString &musicName);

    // 设置当前歌手
    void setCurrentSinger(const QString &currentSinger);
    QString currentSinger();

    // 设置当前歌曲
    void setCurrentSong(const QString &currentSong);
    QString currentSong();

    // 设置音量
    double volume();
    void setVolume(double value);

    // 获取当前歌曲url
    QString currentSongUrl();
    void setCurrentSongUrl(const QString &url);

    // 获取当前歌曲lrc
    QString currentSongLrc();
    void setCurrentSongLrc(const QString &lrc);

    // 获取当前cover
    QString currentCover();
    void setCurrentCover(const QString &cover);

    // 清空信息
    void clear();

signals:
    void currentSingerChanged(QString);
    void currentSongChanged(QString);
    void volumeChanged(double);
    void currentSongUrlChanged(QString);
    void currentSongLrcChanged(QString);
    void currentCoverChanged(QString);
    void currentLrcIndexChanged(int);
    void lrcLoadFinished();

private:
    // 更新当前歌曲信息
    void updateCurrentSongInfo();
    // 更新当前歌手信息
    void updateCurrentSingerInfo();

private:
    QList<SingerInfo> m_singers;
    QString m_currentSinger;
    QString m_currentSong;
    QString m_currentSongUrl;
    QString m_currentSongLrc;
    QString m_currentCover;
    double m_volume;

    LrcParser *m_lrcParser;
};

#endif // MUSICMODEL_H
