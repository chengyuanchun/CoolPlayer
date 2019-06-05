#ifndef APPLICATION_H
#define APPLICATION_H

#include <QGuiApplication>

class Workspace;
class QTranslator;

class Application : public QGuiApplication
{
    Q_OBJECT

public:
    Application(int argc, char *argv[]);
    ~Application();

private:
    Workspace *m_workspace;
    QTranslator *m_translator;
};

#endif // APPLICATION_H
