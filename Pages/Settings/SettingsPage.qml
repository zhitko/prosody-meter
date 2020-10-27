import QtQuick 2.14

import intondemo.backend 1.0

SettingsPageForm {
    anchors.fill: parent

    Backend {
        id: backend
    }

    Component.onCompleted: {
        intensityFrameValue.value = backend.getIntensityFrame();
        intensityShiftValue.value = backend.getIntensityShift();
        intensitySmoothFrameValue.value = backend.getIntensitySmoothFrame();
        intensityDoubleSmoothFrameValue.value = backend.getIntensityDoubleSmoothFrame();
        intensityMaxLengthValue.value = backend.getIntensityMaxLengthValue();
        pausesMaxLengthValue.value = backend.getIntensityDoubleSmoothMaxLengthValue();
    }

    intensityMaxLengthValue.onValueChanged: {
        backend.setIntensityMaxLengthValue(intensityMaxLengthValue.value);
    }

    pausesMaxLengthValue.onValueChanged: {
        backend.setIntensityDoubleSmoothMaxLengthValue(pausesMaxLengthValue.value);
    }

    intensityFrameValue.onValueChanged: {
        backend.setIntensityFrame(intensityFrameValue.value);
    }

    intensityShiftValue.onValueChanged: {
        backend.setIntensityShift(intensityShiftValue.value);
    }

    intensitySmoothFrameValue.onValueChanged: {
        backend.setIntensitySmoothFrame(intensitySmoothFrameValue.value);
    }

    intensityDoubleSmoothFrameValue.onValueChanged: {
        backend.setIntensityDoubleSmoothFrame(intensityDoubleSmoothFrameValue.value);
    }
}
