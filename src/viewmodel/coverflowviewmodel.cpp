#include "coverflowviewmodel.h"
#include "src/model/coverflowmodel.h"
#include "src/model/musicmodel.h"

CoverFlowViewModel::CoverFlowViewModel(QObject *parent) : QObject(parent)
  , m_musicModel(NULL)
{
    qRegisterMetaType<CoverFlowModel *>("CoverFlowModel *");

    m_coverFlowModel = new CoverFlowModel(this);
}

CoverFlowModel *CoverFlowViewModel::coverFlowModel()
{
    return m_coverFlowModel;
}

void CoverFlowViewModel::setCoverFlowModel(CoverFlowModel *coverModel)
{
    if (m_coverFlowModel != coverModel)
    {
        m_coverFlowModel = coverModel;
        emit coverFlowModelChanged(m_coverFlowModel);
    }
}

void CoverFlowViewModel::setMusicModel(MusicModel *musicModel)
{
    if (musicModel)
    {
        m_musicModel = musicModel;
    }
}

void CoverFlowViewModel::loadCoverData()
{
    if (m_musicModel && m_coverFlowModel)
    {
        m_coverFlowModel->resetCoverData(m_musicModel->coverInfos());
    }
}

QString CoverFlowViewModel::currentName(int index)
{
    if (m_coverFlowModel)
    {
        return m_coverFlowModel->currentName(index);
    }
    return QString();
}
