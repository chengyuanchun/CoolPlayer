#ifndef MUSICVIEWMODEL_H
#define MUSICVIEWMODEL_H

#include <QObject>

class MusicModel;

class MusicViewModel : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString currentSinger READ currentSinger WRITE setCurrentSinger NOTIFY currentSingerChanged)
    Q_PROPERTY(QString currentSong READ currentSong WRITE setCurrentSong NOTIFY currentSongChanged)
    Q_PROPERTY(QString currentSongUrl READ currentSongUrl WRITE setCurrentSongUrl NOTIFY currentSongUrlChanged)
    Q_PROPERTY(QString currentSongLrc READ currentSongLrc WRITE setCurrentSongLrc NOTIFY currentSongLrcChanged)
    Q_PROPERTY(QString currentCover READ currentCover WRITE setCurrentCover NOTIFY currentCoverChanged)
    Q_PROPERTY(double volume READ volume WRITE setVolume NOTIFY volumeChanged)
    Q_PROPERTY(int currentLrcIndex READ currentLrcIndex NOTIFY currentLrcIndexChanged)

public:
    explicit MusicViewModel(QObject *parent = nullptr);

    void setMusicModel(MusicModel *musicModel);

    // 清空信息
    Q_INVOKABLE void clearInfo();

    // 通过歌手名获取所有歌曲名
    Q_INVOKABLE QStringList musicNames(const QString &singer);

    // 加载歌词
    Q_INVOKABLE void loadLrc();

    // 获取所有歌词
    Q_INVOKABLE QStringList lrcLines();

    // update lrc index by time
    Q_INVOKABLE void updateLrcIndexByTime(qint64 time);

    // 根据歌名获取歌曲时间
    Q_INVOKABLE QString musicTimeByName(const QString &name);

    // 当前歌词坐标
    int currentLrcIndex();

    // 当前歌手名
    QString currentSinger();
    void setCurrentSinger(const QString &singer);

    // 当前歌曲名
    QString currentSong();
    void setCurrentSong(const QString &song);

    // 当前歌曲url
    QString currentSongUrl();
    void setCurrentSongUrl(const QString &url);

    // 当前歌曲lrc
    QString currentSongLrc();
    void setCurrentSongLrc(const QString &lrc);

    // 当前歌手封面
    QString currentCover();
    void setCurrentCover(const QString &cover);

    // 音量大小0.0-1.0
    double volume();
    void setVolume(double value);


signals:
    void currentSingerChanged(QString text);
    void currentSongChanged(QString text);
    void currentSongUrlChanged(QString text);
    void currentSongLrcChanged(QString text);
    void currentCoverChanged(QString text);
    void volumeChanged(double value);
    void currentLrcIndexChanged(int);
    void lrcLoadFinished();

    void play();
    void pause();
    void stop();
    void finished();

    void selectBackground(int type);

public slots:

private:
    MusicModel *m_musicModel;
};

#endif // MUSICVIEWMODEL_H
