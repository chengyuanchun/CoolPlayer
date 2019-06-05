#ifndef COMMON_H
#define COMMON_H

#include <QString>
#include <QList>

const QString MUSIC_FILE = "music.xml";

struct MusicInfo
{
    QString name;
    QString url;
    QString lrc;
    QString time;
};

struct SingerInfo
{
    QString name;
    QString cover;
    QList<MusicInfo> musics;
};

struct CoverData
{
    QString name;
    QString cover;
};

#endif // COMMON_H
