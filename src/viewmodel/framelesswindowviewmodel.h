#ifndef FRAMELESSWINDOWVIEWMODEL_H
#define FRAMELESSWINDOWVIEWMODEL_H

#include <QObject>

class FramelessWindowViewModel : public QObject
{
    Q_OBJECT

public:
    explicit FramelessWindowViewModel(QObject *parent = nullptr);

signals:
    void switchCoverFlowPage();
    void switchMusicPage();

};

#endif // FRAMELESSWINDOWVIEWMODEL_H
