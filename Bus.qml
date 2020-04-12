import QtQuick 2.14
import QtQuick.Controls 2.14

Item {
    id: bus

    property var stackView

    property string waveFilePage: "Pages/WaveFile/WaveFilePage.qml";
    property string waveFilesPage: "Pages/WaveFiles/FilesPage.qml";
    property string welcomePage: "Pages/Welcome/WelcomePage.qml";
    property string settingsPage: "Pages/Settings/SettingsPage.qml";
    property string testPage: "Pages/TestPage.qml";
    property string recorderPage: "Pages/Recorder/RecorderPage.qml";

    signal openedWaveFilePage(string path)
    function openWaveFilePage(path)
    {
        console.log("Try to open Wave Fila Page " + path);
        stackView.pop()
        stackView.push(waveFilePage, {name: "User Record", path: path, bus: bus})
        openedWaveFilePage(path)
    }

    signal openedWaveFilesPage()
    function openWaveFilesPage()
    {
        stackView.push(waveFilesPage, {bus: bus})
        openedWaveFilesPage()
    }

    signal openedWelcomePage()
    function openWelcomePage()
    {
        stackView.clear();
        stackView.push(welcomePage, {bus: bus})
        openedWelcomePage()
    }

    signal openedSettingsPage()
    function openSettingsPage()
    {
        stackView.push(settingsPage, {bus: bus})
        openedWelcomePage()
    }

    signal openedTestPage()
    function openTestPage()
    {
        stackView.push(testPage, {bus: bus})
        openedTestPage()
    }

    signal openedRecorderPage()
    function openRecorderPage()
    {
        stackView.push(recorderPage, {bus: bus})
        openedRecorderPage()
    }
}
