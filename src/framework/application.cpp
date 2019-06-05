#include "application.h"
#include "workspace.h"
#include <QDebug>
#include <QTranslator>

Application::Application(int argc, char *argv[])
    : QGuiApplication(argc, argv)
    , m_workspace(NULL)
    , m_translator(NULL)
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    m_translator = new QTranslator(this);
    m_translator->load(":/qm/coolplayer_cn.qm");
    installTranslator(m_translator);

    m_workspace = new Workspace(this);
}

Application::~Application()
{

}
