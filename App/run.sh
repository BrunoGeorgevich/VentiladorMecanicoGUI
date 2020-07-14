echo "GERANDO NOVO RCC"
## sudo chmod a+rw /dev/ttyACM0
rcc -binary Frontend/qml.qrc -o qml.rcc
python main.py
echo "REMOVENDO RCC ASSETS ANTIGO"
rm *.rcc
read -n 1 -s -r -p "Press any key to continue"
