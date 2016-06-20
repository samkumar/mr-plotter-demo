#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <libmrplotter.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    initLibMrPlotter();

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
