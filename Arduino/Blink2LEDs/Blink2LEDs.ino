/*
 * Demonstrates two configurations of activating LEDs. One where the LED  
 * anode (long leg) is pointed towards an output pin (in this case, Pin 3). 
 * In this configuration, driving Pin 3 HIGH will turn on the LED.
 * And the second where the LED anode is connected to 5V and the cathode
 * is connected towards Pin 4. In this configuration, driving Pin 4 HIGH
 * will turn off the LED. See lecture slides for details.
 * 
 * By Jon Froehlich
 * http://makeabilitylab.io
 * 
 */

const int LED1_OUTPUT_PIN = 3; // Anode faces Pin 3 (cathode connected to 0V)
const int LED2_OUTPUT_PIN = 4; // Cathode faces Pin 4 (anode connected to 5V)

// The setup function runs once when you press reset or power the board
void setup() {
  // Because pins 0 - 13 can either be input or output, we must specify
  // how we're using the pin by using pinMode. In this case, we want to
  // control LEDs, so set both pins to OUTPUT
  pinMode(LED1_OUTPUT_PIN, OUTPUT);
  pinMode(LED2_OUTPUT_PIN, OUTPUT);
}

// The loop function runs over and over again forever
void loop() {
  // Below, you're going to see that driving Pin 3 HIGH will turn on LED1
  // but driving Pin 4 HIGH will actually turn *off* LED2
  digitalWrite(LED1_OUTPUT_PIN, HIGH);  // turns ON LED1 (Pin 3 is now 5V and other leg of LED is 0V)
  digitalWrite(LED2_OUTPUT_PIN, HIGH);  // turns OFF LED2 (Pin 4 is now 5V and other leg of LED is 5V)
  delay(1000);                          // delay is in milliseconds; so wait one second
  
  digitalWrite(LED1_OUTPUT_PIN, LOW);   // turns OFF LED1 (Pin 3 is now 0V and other leg of LED is 0V)
  digitalWrite(LED2_OUTPUT_PIN, LOW);   // turns ON LED2 (Pin 4 is now 0V and other leg of LED is 5V)
  delay(1000);                          // wait for a second
}
