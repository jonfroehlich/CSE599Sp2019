# CSE599 Prototyping Interactive Systems
![Example assignments and projects from previous incarnations of this course: CMSC838f at UMD](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/docs/ExampleAssignmentsAndProjects.jpg "Example assignments and projects")
This course explores the materiality and physicality of interactive computing via rapid prototyping. In the words of MIT professor Hiroshi Ishii, we will seek to “seamlessly couple the dual worlds of bits and atoms.” This is a particularly interesting time to survey and explore this area because of three, interrelated technology trends:

- **The emergence of the DIY/Makers movement**, which has led to widespread opportunities to interface and work with hardware that has rather low barriers of entry (e.g., the Arduino), provides new opportunities for coupling form with computation (e.g., through digital fabrication), and provides countless online materials/tutorials to help us along.
- **The pervasiveness of powerful mobile computers and IoT devices** that are constantly on and nearly constantly with us (or around us) and imbued with a rich array of sensors such as accelerometers, gyroscopes, and location-sensing that allow for new types of off-the-desktop interaction
- **Advancements in machine learning and computer vision and maturing ML/CV toolkits/APIs** that enable us to process and use sensor data in new ways for human-computer interaction (without being experts in ML or CV ourselves!)
Taken together, we can no longer simply consider the [GUI](https://en.wikipedia.org/wiki/Graphical_user_interface) and [WIMP](https://en.wikipedia.org/wiki/WIMP_%28computing) interfaces as primary interaction models for computing. We must explore new spaces of interaction that are, in part, enabled by the above three points. In this class, we will use materials to help us think and to push our own boundaries of what interactive computing is and could be. 

The full syllabus, assignments, and discussions are on our private [Canvas site](https://canvas.uw.edu/courses/1311479). 

In this repository, we host example code and lecture PDFs (please email me for the raw PowerPoints, which gives you access to animations and the plentiful embedded movies).

## Course Curriculum
While informed by my previous graduate courses—namely, [Tangible Interactive Computing](https://web.archive.org/web/20170605201324/http:/cmsc838f-s15.wikispaces.com/) at UMD and [Ubiquitous Computing](https://github.com/jonfroehlich/CSE590Sp2018) at UW—this is a new class that will be purposefully experimental. For the most part, I will be building the course as we go, which enables freshness, flexibility, and adaptability but at a cost, perhaps, of predictability and polish. For my graduate courses (like this one!), I always try to incorporate new technologies, techniques, and methods--some which are new to me—which means that we will be learning together. :) Optmistically, I plan to cover:

- **Prototyping Interactive Devices**
  - Background and theories about ideation, prototyping, and the science of design
  - When and how to prototype
  - Apply HCI design process to interactive device design from form to function
- **Physical Computing (Prototyping Embedded Systems)**
  - Introduce and learn basics of electronic circuits, including voltage, current, and resistance
  - Introduce and learn basic circuit design concepts, including voltage dividers, pull-up and pull-down resistors
  - Introduce and learn the popular embedded prototyping platform Arduino and programming concepts therein
  - Introduce and learn basic IoT concepts (e.g., connecting to a device, I/O).
  - Introduce and learn basics of electro-mechanical design (i.e., designing for actuation)
- **Prototyping Form**
  - Learn the basics of the 3D-fabrication workflow (measuring, CAD modeling, slicing, printing, iterating)
  - Gain experience building hardware enclosures for an electro-mechanical design
  - Gain experience and basic knowledge of a state-of-the-art CAD tool (Autodesk Fusion 360)
- **Applied Machine Learning for HCI**
  - Introduce and learn basic machine learning approaches popular in HCI/UbiComp, including shape matching and feature-based classification
  - Introduce and learn basic machine learning pipeline: data collection, signal processing, model training, and model testing using k-fold cross validation
  - Introduce and learn popular data analytics tools and toolkits (e.g., Jupyter Notebook, scipy)
  - Introduce and learn popular machine learning toolkits (scikit learn, cloud-based apis)
- **Applied Computer Vision for HCI**
  - Introduce and learn basic image processing and computer vision techniques most relevant to HCI
  - Gain experience using computer vision libraries and basic understandings of CV principles
  - Reinforce ML pipeline previously discussed

## Jupyter Notebooks
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/jonfroehlich/CSE599Sp2019/master)

For the applied signal processing and machine learning parts of the course, I've begun creating tutorial notebooks in Jupyter Notebook. You can play with [interactive versions](https://mybinder.org/v2/gh/jonfroehlich/CSE599Sp2019/master) in the cloud, view static versions in your browser (github has a static viewer), or download the ipynb files and run them locally on your machine. Because they are new, expect some draftiness and frequent updates.

- [MyFirstNotebook.ipynb](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Notebooks/MyFirstNotebook.ipynb), which was used in class to introduce students to the basics of Jupyter Notebook (*e.g.,* cells, execution)
- [PythonTutorial.ipynb](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Notebooks/PythonTutorial.ipynb): we use lots of programming languages in this class. This notebook is intended to be a quick Python primer (and refresher).
- [MatplotlibPyplotTutorial.ipynb](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Notebooks/MatplotlibPyplotTutorial.ipynb): matplotlib is the Python-based visualization framework we will be using in class
- [NumpyTutorial.ipynb](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Notebooks/NumpyTutorial.ipynb): numpy is a popular library for processing array/matrix data in scientific computing and data science
- [PlayingWithSignals.ipynb](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Notebooks/PlayingWithSignals.ipynb): an initial notebook to illustrate basic signal processing and signal comparison using numpy and scipy.

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

### Lecture 13: In-Class Exercises and Project Checkin
- Went over some [tutorial notebooks](https://github.com/jonfroehlich/CSE599Sp2019/tree/master/Notebooks)
- Project checkins
- In-class work time on A3

### [Lecture 14: Applied Signal Processing and Machine Learning 3: A3 Shares Outs, A4 Assignment, and Intro to Model-Based Approaches](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Lectures/CSE599_L14-AppliedSPandML3-IntroToModelBased.pdf)
- **A3 reflection.** What worked? What didn’t? Challenges? Solutions?
- Quick intro to **model-based approaches**
- JupyterNotebook exercises with [SVMGestureRecognizer ipynb](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Assignments/A4-SVMGestureRecognizer/SVMGestureRecognizer.ipynb)

### [Lecture 15: Applied Signal Processing and Machine Learning 4: Scikit Learn](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Lectures/CSE599_L15-AppliedSPandML4-ScikitLearn.pdf)
- Using **machine learning toolkits** like scikit-learn
- The **scikit-learn ML framework**
- How the **K Nearest Neighbor ( kNN )** classification model works
- How the **Support Vector Machine (SVM)** classification model works
- Briefly: feature selection , feature scaling , parameter tuning

### Lecture 16: Project Feedback and Work Time
- Project walkarounds and feedback from Jasper and Jon

### [Lecture 17: A4 Share Outs and Evaluating Models with Scikit](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Lectures/CSE599_L17-A4ShareOutsAndKFoldInScikit.pdf)
- **A4 Share Outs** How well did your models perform? What input features did you use? How did you choose?
- **K-Fold Cross-Validation** We used custom code for k-fold, what if we used scikit-learn's built-in functionality?

### [Lecture 18: Feature Selection and Parameter Tuning](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Lectures/CSE599_L18-FeatureSelectionAndParameterTuning.pdf)
- Quick intro to **Pandas** to make it easier to analyze and visualize input features
- Using Pandas **describe()**, **hist()**, **scatter_matrix()**, and **corr()**
- How do we choose input features to our model? **Automatic Feature Selection** to the rescue! We cover four main approahces, including **analysis of variance**, **univariate statistics**, **model-based feature selection**, and **iterative model-based feature selection** like recursive feature elimination
- How do we select the parameters to tune our selected ML model? For example, should we use a linear kernel or a non-linear kernel with an SVM? This is called **parameter tuning** and scikit-learn has support for this too. We will illustrate this using GridSearchCV and an example Jupyter Notebook shared in class.

### Lecture 19: Project Work Time
- Project walkarounds and feedback from Jasper
- See [accel.plotter.py](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Python/accel_plotter.py) for an example of a real-time Python-based visualization (using matplotlib) of incoming accelerometer data from the Arduino
- See [gesture_rec.py](https://github.com/jonfroehlich/CSE599Sp2019/blob/master/Python/gesture_rec.py) for a code skeleton showing how to do (simple) real-time segmentation of incoming accelerometer data for gesture recognition





