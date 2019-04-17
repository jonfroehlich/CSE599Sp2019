/*
 * This example demonstrates using an external pull-down and pull-up resistor configuration
 * with digital input as well as an internal pull-up resistor configuration. 
 * 
 * Hook up a button to D2 with a pull-down resistor, a button to D4 with a pull-up resistor, 
 * and a button to D6 with an internal pull-up resistor (so no resistor is needed). Also hook
 * up LEDs to output pins D3, D5, and D7 to illuminate when the button is pressed
 * 
 * By Jon Froehlich
 * http://makeabilitylab.io
 */

const int BUTTON_INPUT_PIN_PD = 2; // button with a pull-down (PD) resistor
const int LED_OUTPUT_PIN_PD = 3;   // the LED for the PD button
const int BUTTON_INPUT_PIN_PU = 4; // btton with a pull-up (PU) resistor
const int LED_OUTPUT_PIN_PU = 5;   // the LED for the PU button
const int BUTTON_INPUT_PIN_IPU = 6; // btton with an internal pull-up (IPU) resistor
const int LED_OUTPUT_PIN_IPU = 7;   // the LED for the IPU button

void setup() {
  pinMode(BUTTON_INPUT_PIN_PD, INPUT);
  pinMode(LED_OUTPUT_PIN_PD, OUTPUT);

  pinMode(BUTTON_INPUT_PIN_PU, INPUT);
  pinMode(LED_OUTPUT_PIN_PU, OUTPUT);

  pinMode(BUTTON_INPUT_PIN_IPU, INPUT_PULLUP);
  pinMode(LED_OUTPUT_PIN_IPU, OUTPUT);
}

void loop() {

  // Read the button configured with a pull-down resistor. It will be HIGH when pressed and
  // LOW when not pressed
  int buttonValPD = digitalRead(BUTTON_INPUT_PIN_PD);

  // Write out HIGH or LOW
  digitalWrite(LED_OUTPUT_PIN_PD, buttonValPD);

  // Read the button configured with a pull-up resistor. It will be LOW when pressed and
  // HIGH when not pressed
  int buttonValPU = digitalRead(BUTTON_INPUT_PIN_PU);

  // Write out HIGH or LOW. Note that we invert the button value because it's hooked up
  // to a pull-up resistor (that is, when the button is pressed, the signal goes LOW but
  // we want to illuminate our LED when the button is pressed).
  digitalWrite(LED_OUTPUT_PIN_PU, !buttonValPU);

  // Read the button configured with an internal pull-up resistor. It will be LOW when pressed and
  // HIGH when not pressed
  int buttonValIPU = digitalRead(BUTTON_INPUT_PIN_IPU);

  // Write out HIGH or LOW. Note that we invert the button value because it's hooked up
  // to a pull-up resistor (that is, when the button is pressed, the signal goes LOW but
  // we want to illuminate our LED when the button is pressed).
  digitalWrite(LED_OUTPUT_PIN_IPU, !buttonValIPU);
  
  // Check for new input every 100ms (10 times a sec)
  delay(100);
}
