// - GUI to select which gesture. Have nothing as a gesture?
// - Hit space to start and stop. When starting, counts down from 3, 2, 1
// - Status is shown in big letters
// - Saves both fullstream plus presegmented?
// - Shows capture snapshot?
// - Maybe save Arduino time, Processing timestamp too?
// - Draw axes? If so, need rectangular boundary to draw data < full width/height of window
// - Write out save file name after gesture finished recording? Maybe put in GestureAnnotation overlay
// - [Fixed] Looks like data not being removed from array

// Appending text to a file: 
//  - https://stackoverflow.com/questions/17010222/how-do-i-append-text-to-a-csv-txt-file-in-processing
//  - https://docs.oracle.com/javase/7/docs/api/java/io/FileWriter.html
//  - Use sketchPath(string) to store in local sketch folder: https://stackoverflow.com/a/36531925
import processing.serial.*;
import java.awt.Rectangle;
import java.io.BufferedWriter;
import java.io.FileWriter;

final String GESTURE_DIR_NAME = "Gestures";
final int YAXIS_MIN = 0; // minimum y value to graph
final int YAXIS_MAX = 1023; // maximum y value to graph
final color XCOLOR = color(255, 61, 0, 200);
final color YCOLOR = color(73, 164, 239, 200);
final color ZCOLOR = color(255, 183, 0, 200);
final color [] SENSOR_VALUE_COLORS = { XCOLOR, YCOLOR, ZCOLOR };
final color DEFAULT_BACKGROUND_COLOR = color(88, 83, 82);
//final color RECORDING_BACKGROUND_COLOR = color(255, 222, 222);
final color RECORDING_BACKGROUND_COLOR = color(40, 0, 0);

final int MIN_SENSOR_VAL = 0;
final int MAX_SENSOR_VAL = 1023;
final int ARDUINO_SERIAL_PORT_INDEX = 3; // our serial port index

// The serial port is necessary to read data in from the Arduino
Serial _serialPort;

final int _timeWindowMs = 1000 * 30; // 30 secs
long _currentXMin;
ArrayList<AccelSensorData> _displaySensorData =  new ArrayList<AccelSensorData>();
ArrayList<GestureAnnotation> _displayGestureAnnotations = new ArrayList<GestureAnnotation>();

PrintWriter _printWriterAllData;

//GestureRecording _gestureRecording = null

final int COUNTDOWN_TIME_MS = 4 * 1000;
long _timestampStartCountdownMs = -1;
boolean _recordingGesture = false;
long _timestampRecordingStarted = -1;

Rectangle _legendRect;

void setup() {
  size(1000, 480);

  // Open the serial port
  _serialPort = new Serial(this, Serial.list()[ARDUINO_SERIAL_PORT_INDEX], 9600);

  // Don't generate a serialEvent() unless you get a newline character:
  _serialPort.bufferUntil('\n');

  _currentXMin = System.currentTimeMillis() - _timeWindowMs;

  int legendHeight = 60;
  int legendWidth = 200;
  int legendXBuffer = 10;
  int legendYBuffer = 5;
  _legendRect = new Rectangle(width - legendWidth - legendXBuffer, legendYBuffer, legendWidth, legendHeight);
  
  String filenameNoPath = "fulldata.csv";
  File fDir = new File(sketchPath(GESTURE_DIR_NAME));
  if(!fDir.exists()){
    fDir.mkdirs(); 
  }
  File file = new File(fDir,filenameNoPath); 
     
  try {
    _printWriterAllData = new PrintWriter(new BufferedWriter(new FileWriter(file, true)));
  }catch (IOException e){
    e.printStackTrace();
  }

  noLoop(); // doesn't automatically loop over draw()
}

void draw() {
  if (_recordingGesture) {
    background(RECORDING_BACKGROUND_COLOR);
  } else {
    background(DEFAULT_BACKGROUND_COLOR);
  }

  //if(_displaySensorData.size() > 0){
  //  AccelSensorData accelSensorData = _displaySensorData.get(_displaySensorData.size() - 1);
  //  float circleSize = map(accelSensorData.x, MIN_SENSOR_VAL, MAX_SENSOR_VAL, 0, width / 2.0);
  //  println("accelSensorData.x=" + accelSensorData.x + " circleSize=" + circleSize);
  //  circle(50,50,circleSize);
  //}

  println("Drawing! _displaySensorData.size()=" + _displaySensorData.size() + " _timeWindowMs=" + _timeWindowMs);
  for (int i = 1; i < _displaySensorData.size(); i++) {
    AccelSensorData lastAccelSensorData = _displaySensorData.get(i - 1);
    AccelSensorData curAccelSensorData = _displaySensorData.get(i);

    drawSensorLine(XCOLOR, lastAccelSensorData.timestamp, lastAccelSensorData.x, curAccelSensorData.timestamp, curAccelSensorData.x);
    drawSensorLine(YCOLOR, lastAccelSensorData.timestamp, lastAccelSensorData.y, curAccelSensorData.timestamp, curAccelSensorData.y);
    drawSensorLine(ZCOLOR, lastAccelSensorData.timestamp, lastAccelSensorData.z, curAccelSensorData.timestamp, curAccelSensorData.z);
  }

  if (_timestampStartCountdownMs != -1) {
    updateAndDrawCountdownTimer();
  }

  drawGestureRecordingAnnotations();
  drawLegend(_legendRect);
}

void drawLegend(Rectangle legendRect) {
  color textColor = color(255, 255, 255, 128);
  stroke(textColor);
  strokeWeight(1);
  noFill();
  rect(legendRect.x, legendRect.y, legendRect.width, legendRect.height);

  // Setup dimension calculations for legend times
  int yBuffer = 4;
  int xBuffer = 4;
  int numLegendItems = 3;
  float legendItemHeight = (legendRect.height - (numLegendItems * yBuffer)) / (float)numLegendItems;  
  String [] legendStrs = { "X", "Y", "Z" };
  textSize(legendItemHeight);
  float strHeight = textAscent() + textDescent();
  float xLegendItemPos = legendRect.x + xBuffer;
  float yLegendItemPos = legendRect.y + strHeight - textDescent();
  AccelSensorData accelSensorData = _displaySensorData.get(_displaySensorData.size() - 1);
  int [] accelSensorVals = accelSensorData.getSensorValues();
  float strWidth = textWidth("X");
  float maxValStrWidth = textWidth(Integer.toString(MAX_SENSOR_VAL));
  float xBar = xLegendItemPos + strWidth + xBuffer;
  float maxBarSize = legendRect.width - (xBuffer + strWidth + 3 * xBuffer + maxValStrWidth);
  
  // Draw each legend item
  for (int i = 0; i < legendStrs.length; i++) {
    String legendStr = legendStrs[i];
    fill(textColor);
    text(legendStr, xLegendItemPos, yLegendItemPos);

    // draw dynamic legend values
    float barWidth = map(accelSensorVals[i], MIN_SENSOR_VAL, MAX_SENSOR_VAL, 0, maxBarSize);
    fill(SENSOR_VALUE_COLORS[i]);
    noStroke();
    rect(xBar, yLegendItemPos - strHeight + textDescent() + yBuffer, barWidth, legendItemHeight - yBuffer);
    float xSensorTextLoc = xBar + barWidth + xBuffer;
    text(Integer.toString(accelSensorVals[i]), xSensorTextLoc, yLegendItemPos);
    yLegendItemPos += legendItemHeight + yBuffer;
  }
}

void drawGestureRecordingAnnotations() {
  
  while(_displayGestureAnnotations.size() > 0 && 
        _displayGestureAnnotations.get(0).hasGestureCompleted() &&
        _displayGestureAnnotations.get(0).endTimestamp < _currentXMin){
    _displayGestureAnnotations.remove(0);
  }
  
  if(_displayGestureAnnotations.size() <= 0) { return; }
  
  for(GestureAnnotation gestureAnnotation : _displayGestureAnnotations){
    textSize(10);
    fill(255);
    stroke(255);
    strokeWeight(1);
    
    String strGesture = "Gesture: \n" + gestureAnnotation.name;
    float xPixelStartGesture = getXPixelFromTimestamp(gestureAnnotation.startTimestamp);
    line(xPixelStartGesture, 0, xPixelStartGesture, height);
    text(strGesture, xPixelStartGesture + 2, 20);  
    
    if(gestureAnnotation.hasGestureCompleted()){
      String strEndGesture = "Gesture End: \n" + gestureAnnotation.name;
      float xPixelEndGesture = getXPixelFromTimestamp(gestureAnnotation.endTimestamp);
      
      noStroke();
      fill(255, 255, 255, 50);
      rect(xPixelStartGesture, 0, xPixelEndGesture - xPixelStartGesture, height);
      
      stroke(255);
      line(xPixelEndGesture, 0, xPixelEndGesture, height);
    }
  }
  
}

void updateAndDrawCountdownTimer() {
  textSize(50);

  long curTimestampMs = System.currentTimeMillis();
  long elapsedTimeMs = curTimestampMs - _timestampStartCountdownMs;
  int countdownTimeSecs = (int)((COUNTDOWN_TIME_MS - elapsedTimeMs) / 1000.0);

  // draw center of screen
  String str = "";
  if (countdownTimeSecs <= 0) {
    str = "Recording!";

    if (!_recordingGesture) {
      _recordingGesture = true;
      _timestampRecordingStarted = curTimestampMs;
      GestureAnnotation gestureAnnotation = new GestureAnnotation("Baseball Throw", curTimestampMs);
      _displayGestureAnnotations.add(gestureAnnotation);
    }
  } else {
    str = String.format("%d", countdownTimeSecs);
  }
  float strWidth = textWidth(str);
  float strHeight = textAscent() + textDescent();

  fill(255);
  text(str, width / 2.0 - strWidth / 2.0, height / 2.0 + strHeight / 2.0 - textDescent());
}

void drawSensorLine(color col, long timestamp1, int sensorVal1, long timestamp2, int sensorVal2) {
  stroke(col);
  strokeWeight(2);
  float xLastPixelVal = getXPixelFromTimestamp(timestamp1);
  float yLastPixelVal = getYPixelFromSensorVal(sensorVal1);
  float xCurPixelVal = getXPixelFromTimestamp(timestamp2);
  float yCurPixelVal = getYPixelFromSensorVal(sensorVal2); 
  line(xLastPixelVal, yLastPixelVal, xCurPixelVal, yCurPixelVal);
}

float getYPixelFromSensorVal(int sensorVal) {
  return map(sensorVal, MIN_SENSOR_VAL, MAX_SENSOR_VAL, 0, height);
}

float getXPixelFromTimestamp(long timestamp) {
  return (timestamp - _currentXMin) / (float)_timeWindowMs * width;
}

void keyPressed() {
  if (key == ' ') { 
    if (_recordingGesture) {
      // save gesture!
      _recordingGesture = false;
      _timestampStartCountdownMs = -1;
      long currentTimestampMs = System.currentTimeMillis();
      GestureAnnotation curGestureRecording = _displayGestureAnnotations.get(_displayGestureAnnotations.size() - 1);
      curGestureRecording.endTimestamp = currentTimestampMs;
      curGestureRecording.save();
    } else {
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

    if (inString != null) {
      int [] data;

      // Our parser can handle either csv strings or just one float per line
      if (inString.contains(",")) {
        data = int(split(inString, ','));
      } else {
        data = new int[] { int(inString) };
      }

      AccelSensorData accelSensorData = new AccelSensorData(currentTimestampMs, data[0], data[1], data[2]);
      //println(accelSensorData);
      _displaySensorData.add(accelSensorData);

      // Remove data that is no longer relevant to be displayed
      while(_displaySensorData.get(0).timestamp < _currentXMin){
        _displaySensorData.remove(0);
      }

      _printWriterAllData.println(accelSensorData.toCsvString());
      
      redraw();
    }
  }
  catch(Exception e) {
    println(e);
  }
}

class GestureAnnotation{ // change name
  public long startTimestamp;
  public long endTimestamp = -1;
  public String name;
  
  ArrayList<AccelSensorData> listSensorData =  new ArrayList<AccelSensorData>();
  
  public GestureAnnotation(String gestureName, long startTimestamp){
    this.name = gestureName;
    this.startTimestamp = startTimestamp;
  }
  
  public boolean hasGestureCompleted(){
    return this.endTimestamp != -1;
  }
  
  public void save(){
    long currentTimestampMs = System.currentTimeMillis();
    String filenameNoPath = this.name + "_" + currentTimestampMs + "_" +  this.listSensorData.size() +  ".csv";
    File fDir = new File(sketchPath(GESTURE_DIR_NAME));
    if(!fDir.exists()){
      fDir.mkdirs(); 
    }
    File file = new File(fDir,filenameNoPath); 
       
    try {
      PrintWriter printWriter = new PrintWriter(new BufferedWriter(new FileWriter(file, false)));
      printWriter.println(AccelSensorData.CSV_HEADER);
      for(AccelSensorData accelSensorData : listSensorData){
        printWriter.println(accelSensorData.toCsvString());
      }
      printWriter.flush();
      printWriter.close();
    }catch (IOException e){
      e.printStackTrace();
    }
  }
}

// Class for the accelerometer data
class AccelSensorData {
  public final static String CSV_HEADER = "Arduino Timestamp (ms), Processing Timestamp (ms), X, Y, Z";
  
  public int x;
  public int y;
  public int z;
  public long timestamp;
  public long arduinoTimestamp;

  public AccelSensorData(long timestamp, int x, int y, int z) {
    this.timestamp = timestamp;
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  // Creates a dynamic array on every call
  public int[] getSensorValues(){
    return new int[] {this.x, this.y, this.z};
  }
  
  public String toCsvHeaderString(){
    return CSV_HEADER;
  }
  
  public String toCsvString(){
    return String.format("%d, %d, %d, %d, %d", this.arduinoTimestamp, this.timestamp, this.x, this.y, this.z);
  }

  public String toString() { 
    return String.format("timestamp=%d x=%d y=%d z=%d", this.timestamp, this.x, this.y, this.z);
  }
}
