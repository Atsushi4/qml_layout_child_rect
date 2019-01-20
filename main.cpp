#include <QtGui/QGuiApplication>
#include <QtQuick/QQuickView>
#include <QtQml/QQmlEngine>
#include <QtQml/QQmlContext>
#include <QtCore/QFileSystemWatcher>
#include <QtCore/QDebug>
#include <QtCore/QThread>
#include <QtCore/QDir>
#include <QtCore/QFile>

QStringList qmlFiles(const QString &parent);

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQuickView view;
    QString qmlRoot = "qml/";
    QFileSystemWatcher watcher(qmlFiles(qmlRoot));
    auto reload = [&](const QString &path){
        QThread::msleep(100);
        view.engine()->clearComponentCache();
        view.setSource(QUrl::fromLocalFile(qmlRoot + QStringLiteral("main.qml")));
        if (path.isEmpty()) return;
        watcher.removePaths(watcher.files());
        watcher.addPaths(qmlFiles(qmlRoot));
    };
    QObject::connect(&watcher, &QFileSystemWatcher::fileChanged, &app, reload, Qt::QueuedConnection);

    reload({});
    view.show();
    return app.exec();
}

QStringList qmlFiles(const QString &parent)
{
    QStringList files;
    for (auto entry : QDir{parent}.entryInfoList(QDir::NoDotAndDotDot | QDir::AllEntries)) {
        if (entry.isDir()) {
            files.append(qmlFiles(entry.absoluteFilePath()));
        } else {
            files.append(entry.absoluteFilePath());
        }
    }
    return files;
}
