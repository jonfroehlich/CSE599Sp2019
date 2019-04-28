// 1. GUI to select which gesture. Have nothing as a gesture?
// 2. Hit space to start and stop. When starting, counts down from 3, 2, 1
// 3. Status is shown in big letters
// 4. Saves both fullstream plus presegmented?
// 5. Shows capture snapshot?
// 6. Maybe save Arduino time, Processing timestamp too?
// 7. Draw axes? If so, need rectangular boundary to draw data < full width/height of window
// 8. Write out save file name after gesture finished recording
import processing.serial.*;

final int YAXIS_MIN = 0; // minimum y value to graph
final int YAXIS_MAX = 1023; // maximum y value to graph
final color XCOLOR = color(255, 61, 0);
final color YCOLOR = color(73, 164, 239);
final color ZCOLOR = color(255, 183, 0);
final color DEFAULT_BACKGROUND_COLOR = color(88, 83, 82);
//final color RECORDING_BACKGROUND_COLOR = color(255, 222, 222);
final color RECORDING_BACKGROUND_COLOR = color(10, 0, 0);

final int MIN_SENSOR_VAL = 0;
final int MAX_SENSOR_VAL = 1023;
final int ARDUINO_SERIAL_PORT_INDEX = 3; // our serial port index

// The serial port is necessary to read data in from the Arduino
Serial _serialPort;

final int _timeWindowMs = 1000 * 30;
long _currentXMin;
ArrayList<AccelSensorData> _listAccelSensorData =  new ArrayList<AccelSensorData>(_timeWindowMs);

final int COUNTDOWN_TIME_MS = 4 * 1000;
long _timestampStartCountdownMs = -1;
boolean _recordingGesture = false;
long _timestampRecordingStarted = -1;

void setup(){
  size(1000, 480);
  
  // Open the serial port
  _serialPort = new Serial(this, Serial.list()[ARDUINO_SERIAL_PORT_INDEX], 9600);

  // Don't generate a serialEvent() unless you get a newline character:
  _serialPort.bufferUntil('\n');
  
  _currentXMin = System.currentTimeMillis() - _timeWindowMs;
  
  noLoop(); // doesn't automatically loop over draw()
}

void draw(){
  if(_recordingGesture){
    background(RECORDING_BACKGROUND_COLOR);
  }
  else{
    background(DEFAULT_BACKGROUND_COLOR);
  }
  
  //if(_listAccelSensorData.size() > 0){
  //  AccelSensorData accelSensorData = _listAccelSensorData.get(_listAccelSensorData.size() - 1);
  //  float circleSize = map(accelSensorData.x, MIN_SENSOR_VAL, MAX_SENSOR_VAL, 0, width / 2.0);
  //  println("accelSensorData.x=" + accelSensorData.x + " circleSize=" + circleSize);
  //  circle(50,50,circleSize);
  //}
  
  println("Drawing! _listAccelSensorData.size()= " + _listAccelSensorData.size());
  for(int i = 1; i < _listAccelSensorData.size(); i++){
    AccelSensorData lastAccelSensorData = _listAccelSensorData.get(i - 1);
    AccelSensorData curAccelSensorData = _listAccelSensorData.get(i);
    
    drawLine(XCOLOR, lastAccelSensorData.timestamp, lastAccelSensorData.x, curAccelSensorData.timestamp, curAccelSensorData.x);
    drawLine(YCOLOR, lastAccelSensorData.timestamp, lastAccelSensorData.y, curAccelSensorData.timestamp, curAccelSensorData.y);
    drawLine(ZCOLOR, lastAccelSensorData.timestamp, lastAccelSensorData.z, curAccelSensorData.timestamp, curAccelSensorData.z);
    //println(String.format("%d: xMin=%d diff=%d window=%d (%d, %d) (%d, %d)", i, _currentXMin, (lastAccelSensorData.timestamp - _currentXMin), _currentXMin + _timeWindowMs, lastAccelSensorData.timestamp, lastAccelSensorData.x, curAccelSensorData.timestamp, curAccelSensorData.x));
    //println(String.format("%d: (%.1f, %.1f) (%.1f, %.1f)", i, xLastPixelVal, yLastPixelVal, xCurPixelVal, yCurPixelVal));
  }
  
  if(_timestampStartCountdownMs != -1){
    updateAndDrawCountdownTimer();
  }
  
  if(_recordingGesture){
    drawRecordingAnnotation(); 
  }
}

void drawRecordingAnnotation(){
  textSize(20);
  fill(255);
  String str = "Gesture: " + "Baseball throw";
  float xPixelStartGesture = getXPixelFromTimestamp(_timestampRecordingStarted);
  
  stroke(255);
  strokeWeight(2);
  line(xPixelStartGesture, 0, xPixelStartGesture, height);
  
  text(str, xPixelStartGesture + 2, 20);
}

void updateAndDrawCountdownTimer(){
  textSize(50);
  
  long curTimestampMs = System.currentTimeMillis();
  long elapsedTimeMs = curTimestampMs - _timestampStartCountdownMs;
  int countdownTimeSecs = (int)((COUNTDOWN_TIME_MS - elapsedTimeMs) / 1000.0);
  
  // draw center of screen
  String str = "";
  if(countdownTimeSecs <= 0){
    str = "Recording!";
    
    if(!_recordingGesture){
      _recordingGesture = true;
      _timestampRecordingStarted = curTimestampMs;
    }
  }else{
    str = String.format("%d", countdownTimeSecs);
  }
  float strWidth = textWidth(str);
  float strHeight = textAscent() + textDescent();
  
  fill(255);
  text(str, width / 2.0 - strWidth / 2.0, height / 2.0 + strHeight / 2.0 - textDescent());
}

void drawLine(color col, long timestamp1, int sensorVal1, long timestamp2, int sensorVal2){
  stroke(col);
  strokeWeight(2);
  float xLastPixelVal = getXPixelFromTimestamp(timestamp1);
  float yLastPixelVal = getYPixelFromSensorVal(sensorVal1);
  float xCurPixelVal = getXPixelFromTimestamp(timestamp2);
  float yCurPixelVal = getYPixelFromSensorVal(sensorVal2); 
  line(xLastPixelVal, yLastPixelVal, xCurPixelVal, yCurPixelVal);
}

float getYPixelFromSensorVal(int sensorVal){
  return map(sensorVal, MIN_SENSOR_VAL, MAX_SENSOR_VAL, 0, height);
}

float getXPixelFromTimestamp(long timestamp){
  return (timestamp - _currentXMin) / (float)_timeWindowMs * width;
}

void keyPressed() {
  if (key == ' ') { 
    if(_recordingGesture){
      // save gesture!
      _recordingGesture = false;
      _timestampStartCountdownMs = -1;
      
    }
    else{
      // start countdown timer
      _timestampStartCountdownMs = System.currentTimeMillis();
    }
  } 
}

// Called automatically when there is data on the serial port
// See: https://processing.org/reference/libraries/serial/serialEvent_.html
void serialEvent (Serial myPort) {
  long currentTimestampMs = System.currentTimeMillis();
  _currentXMin = currentTimestampMs - _timeWindowMs;
  
  try {
    // Grab the data off the serial port. See: 
    // https://processing.org/reference/libraries/serial/index.html
    String inString = trim(_serialPort.readStringUntil('\n'));
    //println(inString);
    
    if(inString != null){
      int [] data;
      
      // Our parser can handle either csv strings or just one float per line
      if(inString.contains(",")){
        data = int(split(inString, ','));
      }else{
        data = new int[] { int(inString) };
      }
      
      AccelSensorData accelSensorData = new AccelSensorData(currentTimestampMs, data[0], data[1], data[2]);
      //println(accelSensorData);
      _listAccelSensorData.add(accelSensorData);
      
      // TODO change this to a loop that removes anything with a timestamp off of the chart
      if(_listAccelSensorData.size() >= _timeWindowMs){
        _listAccelSensorData.remove(0); // remove the first element
      }
      
      redraw();   
    }
  }
  catch(Exception e) {
    println(e);
  }
}

// Class for the accelerometer data
class AccelSensorData{
   public int x;
   public int y;
   public int z;
   public long timestamp;
   public long arduinoTimestamp = -1; //not used
   
   public AccelSensorData(long timestamp, int x, int y, int z){
     this.timestamp = timestamp;
     this.x = x;
     this.y = y;
     this.z = z;
   }
   
   public String toString() { 
     return String.format("timestamp=%d x=%d y=%d z=%d", this.timestamp, this.x, this.y, this.z);
   }
}
