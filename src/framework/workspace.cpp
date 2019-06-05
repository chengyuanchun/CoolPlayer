#include "workspace.h"
#include "src/viewmodel/framelesswindowviewmodel.h"
#include "src/viewmodel/coverflowviewmodel.h"
#include "src/viewmodel/musicviewmodel.h"
#include "src/model/coverflowmodel.h"
#include "src/model/musicmodel.h"
#include <QDebug>
#include <QQmlContext>

Workspace::Workspace(QObject *parent) : QObject(parent)
{
    onLaunchComplete();
}

Workspace::~Workspace()
{
    onDestory();
}

void Workspace::onLaunchComplete()
{
    m_framelessViewModel = new FramelessWindowViewModel(this);
    m_coverFlowViewModel = new CoverFlowViewModel(this);
    m_musicViewModel = new MusicViewModel(this);
    m_musicModel = new MusicModel(this);
    m_coverFlowViewModel->setMusicModel(m_musicModel);
    m_musicViewModel->setMusicModel(m_musicModel);

    m_qmlEngine.rootContext()->setContextProperty("framelessViewModel", m_framelessViewModel);
    m_qmlEngine.rootContext()->setContextProperty("coverViewModel", m_coverFlowViewModel);
    m_qmlEngine.rootContext()->setContextProperty("musicViewModel",m_musicViewModel);

    m_qmlEngine.load(QUrl(QStringLiteral("qrc:/src/view/main.qml")));
}

void Workspace::onDestory()
{

}

