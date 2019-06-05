#ifndef COVERFLOWVIEWMODEL_H
#define COVERFLOWVIEWMODEL_H

#include <QObject>

class CoverFlowModel;
class MusicModel;

class CoverFlowViewModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(CoverFlowModel* coverFlowModel READ coverFlowModel WRITE setCoverFlowModel NOTIFY coverFlowModelChanged)

public:
    explicit CoverFlowViewModel(QObject *parent = nullptr);

    CoverFlowModel* coverFlowModel();
    void setCoverFlowModel(CoverFlowModel *coverModel);

    void setMusicModel(MusicModel *musicModel);

    Q_INVOKABLE void loadCoverData();
    Q_INVOKABLE QString currentName(int index);

signals:
    void coverFlowModelChanged(CoverFlowModel *);

private:
    CoverFlowModel *m_coverFlowModel;
    MusicModel *m_musicModel;
};

#endif // COVERFLOWVIEWMODEL_H
