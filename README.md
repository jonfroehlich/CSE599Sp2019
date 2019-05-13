## CSE599 Prototyping Interactive Systems
![Example assignments and projects from previous incarnations of this course: CMSC838f at UMD](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/docs/ExampleAssignmentsAndProjects.jpg "Example assignments and projects")
This course explores the materiality and physicality of interactive computing via rapid prototyping. The full syllabus, assignments, and discussions are on our private [Canvas site](https://canvas.uw.edu/courses/1311479). 

In this repository, we host example code and lecture PDFs (please email me for the raw PowerPoints, which gives you access to animations and the plentiful embedded movies).

## Jupyter Notebooks
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/jonfroehlich/CSE599Sp2019/master)

For the applied signal processing and machine learning parts of the course, I've begun creating tutorial notebooks in Jupyter Notebook. You can play with [interactive versions](https://mybinder.org/v2/gh/jonfroehlich/CSE599Sp2019/master) in the cloud, view static versions in your browser (github has a static viewer), or download the ipynb files and run them locally on your machine.

- [MyFirstNotebook.ipynb](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Notebooks/MyFirstNotebook.ipynb), which was used in class to introduce students to the basics of Jupyter Notebook (*e.g.,* cells, execution)
- [PythonTutorial.ipynb](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Notebooks/PythonTutorial.ipynb): we use lots of programming languages in this class. This notebook is intended to be a quick Python primer (and refresher).
- [MatplotlibPyplotTutorial.ipynb](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Notebooks/MatplotlibPyplotTutorial.ipynb): matplotlib is the Python-based visualization framework we will be using in class
- [NumpyTutorial.ipynb](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Notebooks/NumpyTutorial.ipynb): numpy is a popular library for processing array/matrix data in scientific computing and data science

## Lectures
### [Lecture 01: Prototyping Interactive Systems](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Lectures/CSE599_L01-PrototypingInteractiveSystems.pdf)
- Design activity
- Course overview
- Prototyping process

### [Lecture 02: Physical Computing 1: Circuits](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Lectures/CSE599_L02-PhysicalComputing1-Circuits.pdf)
- What is a **circuit**, **voltage**, **current**, and **resistance**
- What is a **resistor** and how to use it
- What is an **LED** and how to use it (e.g., polarity, current limiting resistor) 
- What is **Ohm’s Law** and why is it useful?
- **Series** vs. **parallel resistive** circuit configurations
- What is a **breadboard** and how to use it
- How to **read a datasheet**

### [Lecture 03: Physical Computing 2: Arduino & Basic Output](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Lectures/CSE599_L03-PhysicalComputing2-ArduinoAndOutput.pdf)
- Reinforce some **circuit concepts** from last week
- What is **Arduino?** Both hardware and software
- How to use **digital output** (i.e., turning on/off an LED using digitalWrite) 
- How to debug using **Serial Monitor** and **multimeters**
- How to use an **RGB LED** (if time)

### [Lecture 04: Physical Computing 3: Analog Output](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Lectures/CSE599_L04-PhysicalComputing3-AnalogOutput.pdf)
- What is **analog output**?
- What is **PWM** and why does it matter?
- How to use **analogWrite()**
- Using **Serial Plotter** for debugging
- Introduction to **vibration motors** and how to use them
- (Partial) Introduction to **potentiometers** and **analog input** (if time)

### [Lecture 05: Physical Computing 4: Analog Input & Resistive Sensors](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Lectures/CSE599_L05-PhysicalComputing4-AnalogInput.pdf)
- Working with **analog input**
- What is a **knob/trim potentiometer** and how to use it? 
- What is a **slide potentiometer** and how to use it?
- What are **variable resistive sensors** and how to use them?
- Understanding the **importance of voltage dividers** when working with analog input (and the relevancy of Ohm’s law!)

### [Lecture 06: A1 Share Outs & Intro to A2](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Lectures/CSE599_L06-A1ShareOutsAndA2Assignment.pdf)
- A1: Interactive Night Light share outs
- Intro to A2: 3D-Printed Interactive Night Light

### [Lecture 07: Prototyping Form 1: 3D Modeling + Printing](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Lectures/CSE599_L07-PrototypingForm-3DPrinting.pdf)
- Rapid **end-to-end demonstration** of CAD modeling + 3D printing
- How **CAD tools** + **3D printing** can be used to rapidly prototype form 
- An introduction to two primary 3D printing methods: **SLA** and **FDM**
- The **3D printing pipeline**
- Modeling designs in **Fusion 360**
- What is **slicing** and what do we use it for

### [Lecture 08: Prototyping Form 2: Fusion 360](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Lectures/CSE599_L08-PrototypingForm2-Fusion360.pdf)
- Sketching: How to **move** objects 
- Sketching: How to **resize** objects 
- Sketching: What are **construction lines**? 
- Sketching: How to use **constraints**
- 3D: How to **import** 3D objects
- 3D: How to **project** from 3D to 2D
- 3D: How to use **revolve** and **circular patterns**

### [Lecture 09: Prototyping Form 3: Wire Tools and Soldering](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Lectures/CSE599_L09-PrototypingForm3-WireToolsAndSoldering.pdf)
- Intro to **wires**
- Intro to basic **electronic hand tools**
- How to **solder**
- How to use a **perfboard**
- Design activity: build an **LED flashlight** with a **perfboard**
- (If time) **Solder** header pins on **ADXL335** accelerometer
- Ken Yasuhara from Engineering Teaching and Learning Center

### [Lecture 10a: A2 Share Outs and A3 Assignment](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Lectures/CSE599_L10-A2ShareOutsAndA3Assignment.pdf)
- A2: 3D-Printed Interactive Night Light share outs
- Intro to A3: Shape-Matching Gesture Recognizer

### [Lecture 10ba: Prototyping Process 2: How to Approach Prototyping](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Lectures/CSE599_L10-PrototypingProcess_Part2.pdf)
- Ideation and getting the **design right** and the **right design**
- Ideation process as a tree and process of **elaboration+reduction**
- When to prototype: "ABP: **Always Be Prototyping**"
- The importance of **exploring a breadth of ideas**
- Focus on **rapidly building prototypes** to explore design space
- Perceived **fidelity of prototypes** can impact responses
- **Iteration** is critical
- Prototype multiple designs in **parallel**
- **Show/test multiple prototypes** to enable comparison

### [Lecture 11: Applied Signal Processing and Machine Learning 1: Acquiring the Signal](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Lectures/CSE599_L11-AppliedSPandML1-AcquiringTheSignal.pdf)
- How do we **acquire sensor data** (i.e., signal acquisition)?
- What is a **time-series signal** and how do we represent them?
- **Decomposing** and **synthesizing** signals

### [Lecture 12: Applied Signal Processing and Machine Learning 2: Analyzing the Signal](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Lectures/CSE599_L12-AppliedSPandML2-AnalyzingTheSignal.pdf)
- Basic **signal processing** strategies
- How to **compare two signals** using 'shape matching'
- **General approaches** in HCI/Ubicomp for processing and classifying signals
- Example from a research project: [**HydroSense**](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Lectures/CSE599_L12-AppliedSPandML2-HydroSense.pdf)
- How to approach **A3**
- Jupyter Notebook exercises and **A3 worktime**








