export QT_SELECT=qt5
echo "REMOVENDO RCC ASSETS ANTIGO"
rm *.rcc
echo "GERANDO NOVO RCC"
rcc -binary src/qml.qrc -o qml.rcc
python main.py
