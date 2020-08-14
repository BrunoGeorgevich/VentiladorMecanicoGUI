void setup() {
  Serial.begin(9600); // abre a porta serial a 9600 bps:
  randomSeed(analogRead(0));
}

float aux;
String message = "";
bool isConnected = 0;
bool isSending = 0;
bool isPlateauTime = 1;
int sendPlateau = 30;
int sendAutopeep = 30;
int counter = 0;

void loop() {
  if (Serial.available() > 0) {
    // lê do buffer o dado recebido:
    message = Serial.readStringUntil('\n');
    if (message.equals("CONNECT")) {
      Serial.println("OK");
      isConnected = 1;
    }
    if (message.equals("SEND_DATA")) {
      isSending = 1;
    }
    if (message.equals("STOP_SENDING")) {
      isSending = 0;
    }
  }
  if (isSending) {
    aux = (random(6100) - 100) / 100.0;
    Serial.print("$paw:");
    Serial.print(aux);
    aux = (random(100100) - 100) / 100.0;
    Serial.print(",vtidal:");
    Serial.print(aux);
    aux = (random(20000) - 10000) / 100.0;
    Serial.print(",flow:");
    Serial.print(aux);
    aux = random(100) / 1.0;
    Serial.print(",ve:");
    Serial.print(aux);
    aux = random(100) / 1.0;
    Serial.print(",pe:");
    Serial.print(aux);
    aux = random(100) / 1.0;
    Serial.print(",fio2:");
    Serial.print(aux);
    aux = random(100) / 1.0;
    Serial.print(",tInsp:");
    Serial.print(aux);
    if (isPlateauTime) {
      aux = random(100) / 1.0;
      Serial.print(",plateau:");
      Serial.print(aux);
      counter += 1;
      if (counter == sendPlateau) {
        counter = 0;
        isPlateauTime = !isPlateauTime;
      }
    }
    if (!isPlateauTime) {
      aux = random(100) / 1.0;
      Serial.print(",autopeep:");
      Serial.print(aux);
      counter += 1;
      if (counter == sendAutopeep) {
        counter = 0;
        isPlateauTime = !isPlateauTime;
      }
    }
    Serial.println("%");
    delay(166);
  }
}
