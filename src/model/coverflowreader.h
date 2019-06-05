#ifndef COVERFLOWREADER_H
#define COVERFLOWREADER_H

#include <QObject>
#include "coverflowmodel.h"

class CoverFlowReader : public QObject
{
    Q_OBJECT

public:
    explicit CoverFlowReader(QObject *parent = nullptr);

    QList<CoverData> readCoverFlow();
};

#endif // COVERFLOWREADER_H
