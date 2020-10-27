#include "backend.h"

#include <QDebug>
#include <QSettings>
#include <QVariant>
#include <QDate>

#include <config.h>

#include "applicationconfig.h"


const QString SettingsKeyDate = "date";
const QString SettingsKeyIntensityFrame = "intensity/frame";
const QString SettingsKeyIntensityShift = "intensity/shift";
const QString SettingsKeyIntensitySmoothFrame = "intensity/smoothFrame";
const QString SettingsKeyIntensityDoubleSmoothFrame = "intensity/doubleSmoothFrame";
const QString SettingsKeySegmentsByIntensityMinimumLength = "segmentsByIntensity/minimumLength";
const QString SettingsKeySegmentsByIntensityDoubleSmoothMinimumLength = "segmentsByIntensityDoubleSmooth/minimumLength";
const QString SettingsKeySegmentsByIntensityThresholdAbsolute = "segmentsByIntensity/thresholdAbsolute";
const QString SettingsKeySegmentsByIntensityThresholdRelative = "segmentsByIntensity/thresholdRelative";

IntonCore::Config * Backend::getConfig()
{
    qDebug() << "getConfig";
    if (this->config == nullptr)
    {
        this->config = new IntonCore::Config();
        this->loadFromFile(config);
    }

    return this->config;
}

void Backend::loadFromFile(IntonCore::Config *config)
{
    QSettings settings(ApplicationConfig::SettingsPath);
    if (settings.contains("date"))
    {
        qDebug() << "Load config file: " << settings.fileName();
        config->setIntensityFrame(
            settings.value(SettingsKeyIntensityFrame).toUInt()
        );
        config->setIntensityShift(
            settings.value(SettingsKeyIntensityShift).toUInt()
        );
        config->setIntensitySmoothFrame(
            settings.value(SettingsKeyIntensitySmoothFrame).toUInt()
        );
        config->setIntensityDoubleSmoothFrame(
            settings.value(SettingsKeyIntensityDoubleSmoothFrame).toUInt()
        );
        config->setSegmentsByIntensityMinimumLength(
            settings.value(SettingsKeySegmentsByIntensityMinimumLength).toUInt()
        );
        config->setSegmentsByIntensityDoubleSmoothMinimumLength(
            settings.value(SettingsKeySegmentsByIntensityDoubleSmoothMinimumLength).toUInt()
        );
        config->setSegmentsByIntensityThresholdAbsolute(
            settings.value(SettingsKeySegmentsByIntensityThresholdAbsolute).toDouble()
        );
        config->setSegmentsByIntensityThresholdRelative(
            settings.value(SettingsKeySegmentsByIntensityThresholdRelative).toDouble()
        );
    }
}

void Backend::saveToFile(IntonCore::Config *config)
{
    QSettings settings(ApplicationConfig::SettingsPath);

    qDebug() << "Create new config file";
    settings.setValue(
        SettingsKeyDate,
        QDate()
    );
    settings.setValue(
        SettingsKeyIntensityFrame,
        config->intensityFrame()
    );
    settings.setValue(
        SettingsKeyIntensityShift,
        config->intensityShift()
    );
    settings.setValue(
        SettingsKeyIntensitySmoothFrame,
        config->intensitySmoothFrame()
    );
    settings.setValue(
        SettingsKeyIntensityDoubleSmoothFrame,
        config->intensityDoubleSmoothFrame()
    );
    settings.setValue(
        SettingsKeySegmentsByIntensityMinimumLength,
        config->segmentsByIntensityMinimumLength()
    );
    settings.setValue(
        SettingsKeySegmentsByIntensityDoubleSmoothMinimumLength,
        config->segmentsByIntensityDoubleSmoothMinimumLength()
    );
    settings.setValue(
        SettingsKeySegmentsByIntensityThresholdAbsolute,
        config->segmentsByIntensityThresholdAbsolute()
    );
    settings.setValue(
        SettingsKeySegmentsByIntensityThresholdRelative,
        config->segmentsByIntensityThresholdRelative()
    );
    settings.sync();
}

QVariant Backend::getIntensityFrame()
{
    IntonCore::Config * config = this->getConfig();
    return config->intensityFrame();
}

void Backend::setIntensityFrame(QVariant value)
{
    IntonCore::Config * config = this->getConfig();
    config->setIntensityFrame(value.toUInt());
    this->saveToFile(config);
}

QVariant Backend::getIntensityShift()
{
    IntonCore::Config * config = this->getConfig();
    return config->intensityShift();
}

void Backend::setIntensityShift(QVariant value)
{
    IntonCore::Config * config = this->getConfig();
    config->setIntensityShift(value.toUInt());
    this->saveToFile(config);
}

QVariant Backend::getIntensitySmoothFrame()
{
    IntonCore::Config * config = this->getConfig();
    return config->intensitySmoothFrame();
}

void Backend::setIntensitySmoothFrame(QVariant value)
{
    IntonCore::Config * config = this->getConfig();
    config->setIntensitySmoothFrame(value.toUInt());
    this->saveToFile(config);
}

QVariant Backend::getIntensityDoubleSmoothFrame()
{
    IntonCore::Config * config = this->getConfig();
    return config->intensityDoubleSmoothFrame();
}

void Backend::setIntensityDoubleSmoothFrame(QVariant value)
{
    IntonCore::Config * config = this->getConfig();
    config->setIntensityDoubleSmoothFrame(value.toUInt());
    this->saveToFile(config);
}

QVariant Backend::getIntensityMaxLengthValue()
{
    IntonCore::Config * config = this->getConfig();
    return config->segmentsByIntensityMinimumLength();
}

void Backend::setIntensityMaxLengthValue(QVariant value)
{
    IntonCore::Config * config = this->getConfig();
    config->setSegmentsByIntensityMinimumLength(value.toUInt());
    this->saveToFile(config);
}

QVariant Backend::getIntensityDoubleSmoothMaxLengthValue()
{
    IntonCore::Config * config = this->getConfig();
    return config->segmentsByIntensityDoubleSmoothMinimumLength();
}

void Backend::setIntensityDoubleSmoothMaxLengthValue(QVariant value)
{
    IntonCore::Config * config = this->getConfig();
    config->setSegmentsByIntensityDoubleSmoothMinimumLength(value.toUInt());
    this->saveToFile(config);
}

QVariant Backend::getSegmentsByIntensityMinimumLength()
{
    IntonCore::Config * config = this->getConfig();
    return config->segmentsByIntensityMinimumLength();
}

void Backend::setSegmentsByIntensityMinimumLength(QVariant value)
{
    IntonCore::Config * config = this->getConfig();
    config->setSegmentsByIntensityMinimumLength(value.toUInt());
    this->saveToFile(config);
}

QVariant Backend::getSegmentsByIntensityThresholdAbsolute()
{
    IntonCore::Config * config = this->getConfig();
    return config->segmentsByIntensityThresholdAbsolute();
}

void Backend::setSegmentsByIntensityThresholdAbsolute(QVariant value)
{
    IntonCore::Config * config = this->getConfig();
    config->setSegmentsByIntensityThresholdAbsolute(value.toDouble());
    this->saveToFile(config);
}

QVariant Backend::getSegmentsByIntensityThresholdRelative()
{
    IntonCore::Config * config = this->getConfig();
    return config->segmentsByIntensityThresholdRelative();
}

void Backend::setSegmentsByIntensityThresholdRelative(QVariant value)
{
    IntonCore::Config * config = this->getConfig();
    config->setSegmentsByIntensityThresholdRelative(value.toDouble());
    this->saveToFile(config);
}
