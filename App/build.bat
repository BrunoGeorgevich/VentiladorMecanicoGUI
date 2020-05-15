del dist
pyinstaller -D main.spec
rcc -binary Frontend/qml.qrc -o dist/Ventilador/qml.rcc