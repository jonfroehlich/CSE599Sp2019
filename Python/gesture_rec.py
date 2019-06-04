"""
Basic framework to segment and recognize gestures. Intended to work with:
ADXL335GestureRecorder.ino, which can be found here: https://bit.ly/2HUk9oj 
(it's in our CSE599 github in "Assignments/A3-OfflineGestureRecognizer/GestureRecorder/Arduino/ADXL335GestureRecorder")


By Jon Froehlich
http://makeabilitylab.io

Visualization code based on:
- https://electronut.in/plotting-real-time-data-from-arduino-using-python/ by Mahesh Venkitachalam
- https://www.thepoorengineer.com/en/arduino-python-plot/ 


"""

import sys, serial, argparse
import numpy as np
from time import sleep
from collections import deque
import itertools
import math

import matplotlib.pyplot as plt
import matplotlib.animation as animation


# plot class
class AccelPlot:

    ARDUINO_CSV_INDEX_TIMESTAMP = 0
    ARDUINO_CSV_INDEX_X = 1
    ARDUINO_CSV_INDEX_Y = 2
    ARDUINO_CSV_INDEX_Z = 3

    # constr
    def __init__(self, fig, ax, str_port, baud_rate=9600, max_length=100):
        # open serial port
        self.ser = serial.Serial(str_port, 9600)

        self.fig = fig
        self.ax = ax

        self.data = list()
        num_values_to_plot = 4
        for i in range(0, num_values_to_plot):
            buf = deque()
            self.data.append(buf)

        self.x = self.data[0]
        self.y = self.data[1]
        self.z = self.data[2]
        self.mag = self.data[3] 
        self.time = deque()

        self.max_length = max_length # max length to show

        # segmentation stuff
        self.window_length = 30
        self.window_step = 10
        self.window_buffer = deque()
        self.current_event = None #tuple (time list, val list)

    def __add_to_buffer(self, buf, val):
        if len(buf) < self.max_length:
            buf.append(val)
        else:
            buf.popleft()
            buf.append(val)


    def add_data(self, csv_data):
        self.__add_to_buffer(self.time, csv_data[AccelPlot.ARDUINO_CSV_INDEX_TIMESTAMP])
        self.__add_to_buffer(self.x, csv_data[AccelPlot.ARDUINO_CSV_INDEX_X])
        self.__add_to_buffer(self.y, csv_data[AccelPlot.ARDUINO_CSV_INDEX_Y])
        self.__add_to_buffer(self.z, csv_data[AccelPlot.ARDUINO_CSV_INDEX_Z])
        mag = math.sqrt(csv_data[AccelPlot.ARDUINO_CSV_INDEX_X] ** 2 + 
            csv_data[AccelPlot.ARDUINO_CSV_INDEX_Y] ** 2 + 
            csv_data[AccelPlot.ARDUINO_CSV_INDEX_Z]** 2) 
        self.__add_to_buffer(self.mag, mag)

        # add mag to window buffer used for segmentation
        self.window_buffer.append(mag)


    def segment_event(self):
        segment_result = None
        if len(self.window_buffer) >= self.window_length:
            # you may need/want to change these tolerances
            min_max_begin_segment_threshold = 90 
            min_max_continue_segment_threshold = 25 #lower threshold for continuing event
            min_event_length_ms = 600

            # analyze the buffer
            s = np.array(self.window_buffer)
            min_max_diff = abs(np.max(s) - np.min(s))

            if min_max_diff > min_max_begin_segment_threshold and self.current_event is None:
                print("begin segment!", min_max_diff)
                
                start_idx = len(self.time) - self.window_length
                end_idx = len(self.time)
                
                t = list(itertools.islice(self.time, start_idx, end_idx))
                s = list(itertools.islice(self.mag, start_idx, end_idx))

                self.ax.axvline(self.time[-self.window_length], ls='--', color='black', linewidth=1, alpha=0.8)
                self.current_event = (t, s)
            elif self.current_event is not None:
                # we are in the middle or end of a potential event
                if min_max_diff >= min_max_continue_segment_threshold: 
                    print("continue segment", min_max_diff)
       
                    start_idx = len(self.time) - self.window_step
                    end_idx = len(self.time)
                    
                    t = list(itertools.islice(self.time, start_idx, end_idx))
                    s = list(itertools.islice(self.mag, start_idx, end_idx))

                    self.current_event[0].extend(t)
                    self.current_event[1].extend(s)
                elif min_max_diff < min_max_continue_segment_threshold:
                    print("finish segment", min_max_diff)
                    event_time = self.current_event[0]
                    event_length_ms = event_time[-1] - event_time[0]
                    if event_length_ms > min_event_length_ms:
                        self.ax.axvspan(event_time[0], event_time[-1], color='red', alpha=0.4)
                        self.ax.axvline(event_time[-1], ls='--', color='black', linewidth=1, alpha=0.8)
                    else:
                        print("discarded event for being too short")

                    segment_result = {'time' : self.current_event[0],
                                      'signal' : self.current_event[1] }
                
                    self.current_event = None # clear events

            new_length = self.window_length - self.window_step
            while len(self.window_buffer) > new_length:
                self.window_buffer.popleft()

        return segment_result
    
    def classify_event(self, segment_result):
        # print("classify event", segment_result)
        t = segment_result['time']
        s = segment_result['signal']

    # update plot
    def update(self, frameNum, args, plt_lines):
        try:
            while self.ser.in_waiting:
                line = self.ser.readline()
                line = line.decode('utf-8')
                data = line.split(",")
                data = [int(val.strip()) for val in line.split(",")]
                #print(data)
                self.add_data(data)

                segment_result = self.segment_event()
                if segment_result != None:
                    cls_result = self.classify_event(segment_result)


                # plot the data
                for i in range(0, len(plt_lines)):
                    plt_lines[i].set_data(self.time, self.data[i])
                self.ax.set_xlim(self.time[0], self.time[-1])

        except KeyboardInterrupt:
            print('exiting')

        # except Exception as e:
        #     print('Error '+ str(e))

        #return a0,
        return plt_lines

    # clean up
    def close(self):
        # close serial
        self.ser.flush()
        self.ser.close()

    # main() function


def main():
	# python serial_plotter.py --port /dev/cu.usbmodem14601
	# windows: python lserial_plotter.py --port COM5	
    # create parser
    parser = argparse.ArgumentParser(description="Accel Serial Plotter")

    # add expected arguments
    parser.add_argument('--port', dest='port', required=True, help='the serial port for incoming data')
    parser.add_argument('--max_len', dest='max_len', required=False, default=770, type=int, 
        help='the number of samples to plot at a time')

    # parse args
    args = parser.parse_args()

    # strPort = '/dev/tty.usbserial-A7006Yqh'
    str_port = str(args.port)

    print('Reading from serial port: {}'.format(str_port))

    # plot parameters

    fig = plt.figure(figsize=(10, 5))
    #ax = plt.axes(xlim=(0, args.max_len), ylim=(0, 1023))
    ax = plt.axes(ylim=(0, 1500))

    accel_plot = AccelPlot(fig, ax, str_port, max_length=args.max_len)

    # set up animation
  
    lines = list()
    num_vals = 4 # x,y,z,mag
    labels = ['x', 'y', 'z', 'mag']
    alphas = [0.8, 0.8, 0.8, 0.9]
    for i in range(0, num_vals):
        line2d, = ax.plot([], [], label=labels[i], alpha=alphas[i])
        lines.append(line2d)

    plt.legend(loc='upper right')

    # for more on animation function, see https://jakevdp.github.io/blog/2012/08/18/matplotlib-animation-tutorial/
    anim = animation.FuncAnimation(fig, accel_plot.update,
                                   fargs=(args, lines), # could consider adding blit=True
                                   interval=50) #interval=50 is 20fps

    # show plot
    plt.show()

    # clean up
    accel_plot.close()

    print('Exiting...')


# call main
if __name__ == '__main__':
    main()