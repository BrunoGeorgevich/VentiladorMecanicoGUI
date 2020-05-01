echo "REMOVENDO RCC ASSETS ANTIGO"
rm *.rcc
echo "GERANDO NOVO RCC"
rcc -binary src/qml.qrc -o qml.rcc
python main.py
