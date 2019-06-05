#include "coverflowreader.h"
#include "common.h"
#include <QDomDocument>
#include <QDomElement>
#include <QDomAttr>
#include <QFile>
#include <QDebug>

CoverFlowReader::CoverFlowReader(QObject *parent) : QObject(parent)
{

}

QList<CoverData> CoverFlowReader::readCoverFlow()
{
    QList<CoverData> datas;

    QFile file(MUSIC_FILE);
    if (!file.open(QIODevice::ReadOnly))
    {
        qDebug() << "open file " << MUSIC_FILE << " failed";
        return datas;
    }

    QDomDocument doc;
    if (!doc.setContent(&file))
    {
        qDebug() << "parser xml failed";
        return datas;
    }

    QDomElement rootEle = doc.documentElement();
    for (QDomElement singerEle = rootEle.firstChildElement(); !singerEle.isNull(); singerEle = singerEle.nextSiblingElement())
    {
        CoverData coverData;
        coverData.name = singerEle.attribute("name");
        coverData.cover = singerEle.attribute("cover");
        datas.append(coverData);
    }

    return datas;
}
