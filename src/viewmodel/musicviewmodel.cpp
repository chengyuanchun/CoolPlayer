#include "musicviewmodel.h"
#include "src/model/musicmodel.h"

MusicViewModel::MusicViewModel(QObject *parent) : QObject(parent)
  , m_musicModel(NULL)
{

}

void MusicViewModel::setMusicModel(MusicModel *musicModel)
{
    m_musicModel = musicModel;
    connect(m_musicModel, SIGNAL(currentSingerChanged(QString)), this, SIGNAL(currentSingerChanged(QString)));
    connect(m_musicModel, SIGNAL(currentSongChanged(QString)), this, SIGNAL(currentSongChanged(QString)));
    connect(m_musicModel, SIGNAL(currentSongUrlChanged(QString)), this, SIGNAL(currentSongUrlChanged(QString)));
    connect(m_musicModel, SIGNAL(currentSongLrcChanged(QString)), this, SIGNAL(currentSongLrcChanged(QString)));
    connect(m_musicModel, SIGNAL(currentCoverChanged(QString)), this, SIGNAL(currentCoverChanged(QString)));
    connect(m_musicModel, SIGNAL(volumeChanged(double)), this, SIGNAL(volumeChanged(double)));
    connect(m_musicModel, SIGNAL(currentLrcIndexChanged(int)), this, SIGNAL(currentLrcIndexChanged(int)));
    connect(m_musicModel, SIGNAL(lrcLoadFinished()), this, SIGNAL(lrcLoadFinished()));
}

void MusicViewModel::clearInfo()
{
    if (m_musicModel)
        m_musicModel->clear();
}

QStringList MusicViewModel::musicNames(const QString &singer)
{
    if (m_musicModel)
        return m_musicModel->musicNames(singer);

    return QStringList();
}

void MusicViewModel::loadLrc()
{
    if (m_musicModel)
        m_musicModel->loadLrc();
}

QStringList MusicViewModel::lrcLines()
{
    if (m_musicModel)
        return m_musicModel->lrcLines();

    return QStringList();
}

void MusicViewModel::updateLrcIndexByTime(qint64 time)
{
    if (m_musicModel)
        m_musicModel->updateCurrentLrcByTime(time);
}

QString MusicViewModel::musicTimeByName(const QString &name)
{
    if (m_musicModel)
        return m_musicModel->musicTime(name);

    return QString();
}

int MusicViewModel::currentLrcIndex()
{
    if (m_musicModel)
        return m_musicModel->currentLrcIndex();

    return 0;
}

QString MusicViewModel::currentSinger()
{
    if (m_musicModel)
        return m_musicModel->currentSinger();

    return QString();
}

void MusicViewModel::setCurrentSinger(const QString &singer)
{
    if (m_musicModel)
        m_musicModel->setCurrentSinger(singer);
}

QString MusicViewModel::currentSong()
{
    if (m_musicModel)
        return m_musicModel->currentSong();

    return QString();
}

void MusicViewModel::setCurrentSong(const QString &song)
{
    if (m_musicModel)
        m_musicModel->setCurrentSong(song);
}

QString MusicViewModel::currentSongUrl()
{
    if (m_musicModel)
        return m_musicModel->currentSongUrl();

    return QString();
}

void MusicViewModel::setCurrentSongUrl(const QString &url)
{
    if (m_musicModel)
        m_musicModel->setCurrentSongUrl(url);
}

QString MusicViewModel::currentSongLrc()
{
    if (m_musicModel)
        return m_musicModel->currentSongLrc();

    return QString();
}

void MusicViewModel::setCurrentSongLrc(const QString &lrc)
{
    if (m_musicModel)
        m_musicModel->setCurrentSongLrc(lrc);
}

QString MusicViewModel::currentCover()
{
    if (m_musicModel)
        return m_musicModel->currentCover();

    return QString();
}

void MusicViewModel::setCurrentCover(const QString &cover)
{
    if (m_musicModel)
        m_musicModel->setCurrentCover(cover);
}

double MusicViewModel::volume()
{
    if (m_musicModel)
        return m_musicModel->volume();

    return 0.0;
}

void MusicViewModel::setVolume(double value)
{
    if (m_musicModel)
        m_musicModel->setVolume(value);
}
