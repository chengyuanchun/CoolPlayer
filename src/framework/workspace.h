#ifndef WORKSPACE_H
#define WORKSPACE_H

#include <QObject>
#include <QQmlApplicationEngine>

class FramelessWindowViewModel;
class CoverFlowViewModel;
class MusicViewModel;
class MusicModel;

class Workspace : public QObject
{
    Q_OBJECT

public:
    explicit Workspace(QObject *parent = nullptr);
    virtual ~Workspace();

protected:
    virtual void onLaunchComplete();
    virtual void onDestory();

private:
    QQmlApplicationEngine m_qmlEngine;
    FramelessWindowViewModel *m_framelessViewModel;
    CoverFlowViewModel *m_coverFlowViewModel;
    MusicViewModel *m_musicViewModel;
    MusicModel *m_musicModel;
};

#endif // WORKSPACE_H
