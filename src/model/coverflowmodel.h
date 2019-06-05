#ifndef COVERFLOWMODEL_H
#define COVERFLOWMODEL_H

#include <QAbstractListModel>
#include <QList>
#include "common.h"

class CoverFlowModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum CoverRoles { NameRole = Qt::UserRole + 1, CoverRole };

    explicit CoverFlowModel(QObject *parent = nullptr);
    void resetCoverData(const QList<CoverData> &datas);
    QString currentName(int index);

protected:
    QVariant data(const QModelIndex &index, int role) const override;
    int rowCount(const QModelIndex &parent) const override;
    QHash<int, QByteArray> roleNames() const override;

private:
    QList<CoverData> m_datas;
};

#endif // COVERFLOWMODEL_H
