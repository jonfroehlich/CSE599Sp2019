/*
 * This example shows how to fade an LED on Pin 3 using the analogWrite() function.
 * The fade goes in one direction (from off to a fade on) and then repeats (off to fade on)
 * 
 * The analogWrite() function uses PWM, so if you want to change the pin you're
 * using, be sure to use another PWM capable pin. On the Arduino Uno, the PWM pins
 * are identified with a "~" sign, like ~3, ~5, ~6, ~9, ~10 and ~11. 
 * 
 * By Jon Froehlich
 * http://makeabilitylab.io
 * Adapted from http://www.arduino.cc/en/Tutorial/Fade
 * 
 */

const int LED_OUTPUT_PIN = 3;
const int MAX_BRIGHTNESS = 255; // the max digital out value on Uno, Leonardo, etc. is 255 (8-bit max)
int _curBrightness = 0;   // how bright the LED is (between 0 - 255)

// The setup function runs once when you press reset or power the board
void setup() {
  // set the LED pin to as an output
  pinMode(LED_OUTPUT_PIN, OUTPUT);
}

// The loop function runs over and over again forever
void loop() {
  
  // set the brightness of the LED pin
  analogWrite(LED_OUTPUT_PIN, _curBrightness);

  // change the brightness for next time through the loop
  _curBrightness = _curBrightness + 1;

  // the maximum value that we can write out to analogWrite is 255
  // so check to see if the current brightness value is greater than 255
  // and if it is, reset the brightness to 0 (which is off)
  if (_curBrightness > MAX_BRIGHTNESS){
    _curBrightness = 0;
  }
  
  // wait for 30 milliseconds to see the dimming effect
  delay(30);
}
