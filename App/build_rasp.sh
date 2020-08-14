echo "REMOVINDO LAST DIST FOLDER" 
rm -r dist 
echo "COMPILING QML FILES" 
rcc -binary Frontend/qml.qrc -o qml.rcc 
echo "GENERATING EXECUTABLE" 
pyinstaller -D main_rasp.spec 
echo "COPYING CORRECT PYSIDE2 FOLDER" 
cp -a Libs/PySide2 dist/Ventilador/ 
cp -a Libs/shiboken2 dist/Ventilador/
echo "REMOVING UNUSED FILES"
rm -r qml.rcc
