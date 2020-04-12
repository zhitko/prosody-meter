#include <QtWidgets/QApplication>
#include <QQmlApplicationEngine>

#include "backend.h"
#include "qml/qmlfileinfo.h"
#include "qml/qmlpoint.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    qmlRegisterType<Backend>("intondemo.backend", 1, 0, "Backend");
    qRegisterMetaType<QmlFileInfo>("FileInfo");
    qRegisterMetaType<QmlPoint>("Point");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return QApplication::exec();
}
