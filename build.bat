del dist
pyinstaller -D main.spec
rcc -binary src/qml.qrc -o dist/Ventilador/qml.rcc