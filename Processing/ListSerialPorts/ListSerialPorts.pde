/*
 * This example prints the serial ports to the screen
 *   
 * By Jon Froehlich
 * http://makeabilitylab.io
 * 
 */

import processing.serial.*;

// Serial is necessary to communicate with the Arduino over the serial port
Serial _serialPort;

void setup(){
  size(400, 200);
  
  // Print to console all the available serial ports
  printArray(Serial.list());
}

void draw(){
  background(10);
  
  fill(255);
  float strHeight = textAscent() + textDescent();
  
  String [] serialPorts = Serial.list();
  float y = strHeight;
  for(int i = 0; i < serialPorts.length; i++){
    
    // TODO add a color indicator where we *think* the arduino is (based on usbmodem maybe?)
    String strPortIndexAndName = String.format("[%d] : %s)", i, serialPorts[i]);
    text(strPortIndexAndName, 5, y);
    y += strHeight;
  }
  
 
}
