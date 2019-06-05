QT += quick xml
CONFIG += c++11 qtquickcompliler

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    src/main.cpp \
    src/framework/application.cpp \
    src/framework/workspace.cpp \
    src/viewmodel/coverflowviewmodel.cpp \
    src/model/coverflowmodel.cpp \
    src/model/coverflowreader.cpp \
    src/viewmodel/musicviewmodel.cpp \
    src/viewmodel/framelesswindowviewmodel.cpp \
    src/model/musicmodel.cpp \
    src/model/lrcparser.cpp

RESOURCES += qml.qrc \
    img.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    src/framework/application.h \
    src/framework/workspace.h \
    src/viewmodel/coverflowviewmodel.h \
    src/model/coverflowmodel.h \
    src/model/coverflowreader.h \
    src/viewmodel/musicviewmodel.h \
    src/viewmodel/framelesswindowviewmodel.h \
    src/model/musicmodel.h \
    src/model/common.h \
    src/model/lrcparser.h

#tranlator
TRANSLATIONS += coolplayer_cn.ts

#app ico
RC_FILE += CoolPlayer.rc
