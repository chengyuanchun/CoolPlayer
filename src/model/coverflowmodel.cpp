#include "coverflowmodel.h"
#include "coverflowreader.h"

CoverFlowModel::CoverFlowModel(QObject *parent) : QAbstractListModel(parent)
{

}

void CoverFlowModel::resetCoverData(const QList<CoverData> &datas)
{
    beginResetModel();
    m_datas = datas;
    endResetModel();
}

QString CoverFlowModel::currentName(int index)
{
    if (m_datas.size() > index && index >= 0)
    {
        return m_datas[index].name;
    }
    return QString();
}

QVariant CoverFlowModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() > m_datas.size())
        return QVariant();

    switch (role)
    {
    case CoverRoles::NameRole:
        return m_datas[index.row()].name;
        break;
    case CoverRoles::CoverRole:
        return m_datas[index.row()].cover;
    default:
        break;
    }

    return QVariant();
}

int CoverFlowModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_datas.size();
}

QHash<int, QByteArray> CoverFlowModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[CoverRoles::NameRole] = "name";
    names[CoverRoles::CoverRole] = "cover";

    return names;
}
