/*
 * This example reads in a tilt switch on D2 (with an external pull-down resistor configuration
 * connected to GND and the other leg of the tilt switch connected to 5V). The LED turns on/off 
 * according to the tilt switch value
 * 
 * By Jon Froehlich
 * http://makeabilitylab.io
 */

const int BUTTON_INPUT_PIN = 2;
const int LED_OUTPUT_PIN = 3;

void setup() {
  pinMode(BUTTON_INPUT_PIN, INPUT);
  pinMode(LED_OUTPUT_PIN, OUTPUT);
  Serial.begin(9600);
}

void loop() {

  // read the button value. It will be HIGH when pressed and
  // LOW when not pressed
  int buttonVal = digitalRead(BUTTON_INPUT_PIN);

  // Write out HIGH or LOW
  digitalWrite(LED_OUTPUT_PIN, buttonVal);
  Serial.println(buttonVal == 1 ? "Facing Up" : "Facing Down");
  
  // Check for new input every 100ms (10 times a sec)
  delay(100);
}
