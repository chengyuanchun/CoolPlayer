#include "musicmodel.h"
#include "lrcparser.h"
#include <QDomDocument>
#include <QDomElement>
#include <QDomAttr>
#include <QDebug>

MusicModel::MusicModel(QObject *parent) : QObject(parent)
  , m_volume(0.0)
  , m_lrcParser(NULL)
{
    m_lrcParser = new LrcParser(this);
    connect(m_lrcParser, SIGNAL(currentIndexChanged(int)), this, SIGNAL(currentLrcIndexChanged(int)));
    connect(m_lrcParser, SIGNAL(lrcLoadFinished()), this, SIGNAL(lrcLoadFinished()));
    loadSingerAndSongs();
}

void MusicModel::loadSingerAndSongs()
{
    QFile file(MUSIC_FILE);
    if (!file.open(QIODevice::ReadOnly))
    {
        qDebug() << "open file " << MUSIC_FILE << " failed";
        return;
    }

    QDomDocument doc;
    if (!doc.setContent(&file))
    {
        qDebug() << "parser xml failed";
        return;
    }

    m_singers.clear();

    QDomElement rootEle = doc.documentElement();
    for (QDomElement singerEle = rootEle.firstChildElement(); !singerEle.isNull(); singerEle = singerEle.nextSiblingElement())
    {
        SingerInfo singerInfo;
        singerInfo.name = singerEle.attribute("name");
        singerInfo.cover = singerEle.attribute("cover");

        for (QDomElement musicEle = singerEle.firstChildElement(); !musicEle.isNull(); musicEle = musicEle.nextSiblingElement())
        {
            MusicInfo musicInfo;
            musicInfo.name = musicEle.attribute("name");
            musicInfo.url = musicEle.attribute("url");
            musicInfo.lrc = musicEle.attribute("lrc");
            musicInfo.time = musicEle.attribute("time");
            singerInfo.musics.append(musicInfo);
        }

        m_singers.append(singerInfo);
    }
}

void MusicModel::loadLrc()
{
    if (m_lrcParser)
        m_lrcParser->resolveLrc(m_currentSongLrc);
}

void MusicModel::updateCurrentLrcByTime(qint64 time)
{
    if (m_lrcParser)
        m_lrcParser->updateLrcByTime(time);
}

QStringList MusicModel::lrcLines()
{
    if (m_lrcParser)
        return m_lrcParser->lrcs();

    return QStringList();
}

int MusicModel::currentLrcIndex()
{
    if (m_lrcParser)
        return m_lrcParser->currentIndex();

    return 0;
}

QList<CoverData> MusicModel::coverInfos()
{
    QList<CoverData> coverDatas;
    foreach (SingerInfo singer, m_singers)
    {
        CoverData coverData;
        coverData.name = singer.name;
        coverData.cover = singer.cover;
        coverDatas.append(coverData);
    }

    return coverDatas;
}

QList<QString> MusicModel::musicNames(const QString &singer)
{
    QList<QString> songs;
    for (int i = 0; i < m_singers.count(); i++)
    {
        if (m_singers[i].name == singer)
        {
            foreach (MusicInfo musicInfo, m_singers[i].musics)
            {
                songs.append(musicInfo.name);
            }
            break;
        }
    }

    return songs;
}

QString MusicModel::musicTime(const QString &musicName)
{
    QString timeStr;
    for (auto it = m_singers.begin(); it != m_singers.end(); it++)
    {
        if (it->name == m_currentSinger)
        {
            for (auto musicIt = it->musics.begin(); musicIt != it->musics.end(); musicIt++)
            {
                if (musicIt->name == musicName)
                {
                    timeStr = musicIt->time;
                    break;
                }
            }
        }
    }

    return timeStr;
}

void MusicModel::setCurrentSinger(const QString &currentSinger)
{
    m_currentSinger = currentSinger;
    emit currentSingerChanged(m_currentSinger);

    // 更新歌手信息
    updateCurrentSingerInfo();
}

QString MusicModel::currentSinger()
{
    return m_currentSinger;
}

void MusicModel::setCurrentSong(const QString &currentSong)
{
    m_currentSong = currentSong;
    emit currentSongChanged(m_currentSong);

    // 更新歌曲信息
    updateCurrentSongInfo();
    // 加载歌词
    loadLrc();
}

QString MusicModel::currentSong()
{
    return m_currentSong;
}

double MusicModel::volume()
{
    return m_volume;
}

void MusicModel::setVolume(double value)
{
    m_volume = value;
    emit volumeChanged(m_volume);
}

QString MusicModel::currentSongUrl()
{
    return m_currentSongUrl;
}

void MusicModel::setCurrentSongUrl(const QString &url)
{
    m_currentSongUrl = url;
    emit currentSongUrlChanged(m_currentSongUrl);
}

QString MusicModel::currentSongLrc()
{
    return m_currentSongLrc;
}

void MusicModel::setCurrentSongLrc(const QString &lrc)
{
    m_currentSongLrc = lrc;
    emit currentSongLrcChanged(m_currentSongLrc);
}

QString MusicModel::currentCover()
{
    return m_currentCover;
}

void MusicModel::setCurrentCover(const QString &cover)
{
    m_currentCover = cover;
    emit currentCoverChanged(m_currentCover);
}

void MusicModel::clear()
{
    setCurrentCover("");
    setCurrentSinger("");
    setCurrentSong("");
    setCurrentSongLrc("");
    setCurrentSongUrl("");
}

void MusicModel::updateCurrentSongInfo()
{
    for (int i = 0; i < m_singers.size(); i++)
    {
        if (m_singers[i].name == m_currentSinger)
        {
            for (int j = 0; j < m_singers[i].musics.size(); j++)
            {
                if (m_singers[i].musics[j].name == m_currentSong)
                {
                    // 更新url
                    setCurrentSongUrl(m_singers[i].musics[j].url);
                    // 更新lrc
                    setCurrentSongLrc(m_singers[i].musics[j].lrc);

                    break;
                }
            }
        }
    }
}

void MusicModel::updateCurrentSingerInfo()
{
    for (int i = 0; i < m_singers.size(); i++)
    {
        if (m_singers[i].name == m_currentSinger)
        {
            setCurrentCover(m_singers[i].cover);
            break;
        }
    }
}
