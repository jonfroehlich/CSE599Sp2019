"""
Display CSV-formatted serial data from Arduino using Python (matplotlib). Designed to work with
should work with ADXL335GestureRecorder.ino with default settings

By Jon Froehlich
http://makeabilitylab.io

Based on:
- https://electronut.in/plotting-real-time-data-from-arduino-using-python/ by Mahesh Venkitachalam
- https://www.thepoorengineer.com/en/arduino-python-plot/ 

"""

import sys, serial, argparse
import numpy as np
from time import sleep
from collections import deque
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
    def __init__(self, str_port, baud_rate=9600, max_length=100):
        # open serial port
        self.ser = serial.Serial(str_port, 9600)

        self.data = list()
        num_values_to_plot = 4
        for i in range(0, num_values_to_plot):
            buf = deque([0.0] * max_length)
            self.data.append(buf)

        self.x = self.data[0]
        self.y = self.data[1]
        self.z = self.data[2]
        self.mag = self.data[3] 

        self.max_length = max_length

    def __add_to_buffer(self, buf, val):
        if len(buf) < self.max_length:
            buf.append(val)
        else:
            buf.popleft()
            buf.append(val)

    def add_data(self, csv_data):
        self.__add_to_buffer(self.x, csv_data[AccelPlot.ARDUINO_CSV_INDEX_X])
        self.__add_to_buffer(self.y, csv_data[AccelPlot.ARDUINO_CSV_INDEX_Y])
        self.__add_to_buffer(self.z, csv_data[AccelPlot.ARDUINO_CSV_INDEX_Z])
        mag = math.sqrt(csv_data[AccelPlot.ARDUINO_CSV_INDEX_X] ** 2 + 
            csv_data[AccelPlot.ARDUINO_CSV_INDEX_Y] ** 2 + 
            csv_data[AccelPlot.ARDUINO_CSV_INDEX_Z]** 2) 
        self.__add_to_buffer(self.mag, mag)
    
    # update plot
    def update(self, frameNum, args, plt_lines):
        try:
            while self.ser.in_waiting:
                line = self.ser.readline()
                line = line.decode('utf-8')
                data = line.split(",")
                data = [float(val.strip()) for val in line.split(",")]
                print(data)
                self.add_data(data)

                # plot the data
                for i in range(0, len(plt_lines)):
                    plt_lines[i].set_data(range(self.max_length), self.data[i])

        except KeyboardInterrupt:
            print('exiting')

        except Exception as e:
            print('Error '+ str(e))

        #return a0,
        return plt_lines

    # clean up
    def close(self):
        # close serial
        self.ser.flush()
        self.ser.close()

    # main() function


def main():
    # python accel_plotter.py --port /dev/cu.usbmodem14601
    # windows: python accel_plotter.py --port COM5	
    # create parser
    parser = argparse.ArgumentParser(description="Accel Serial Plotter")

    # add expected arguments
    parser.add_argument('--port', dest='port', required=True, help='the serial port for incoming data')
    parser.add_argument('--max_len', dest='max_len', required=False, default=500, type=int, 
        help='the number of samples to plot at a time')

    # parse args
    args = parser.parse_args()

    # strPort = '/dev/tty.usbserial-A7006Yqh'
    str_port = str(args.port)

    print('Reading from serial port: {}'.format(str_port))

    # plot parameters
    accel_plot = AccelPlot(str_port, max_length=args.max_len)

    # set up animation
    fig = plt.figure(figsize=(10, 5))
    ax = plt.axes(xlim=(0, args.max_len), ylim=(0, 1023))
    #ax.autoscale(enable=True, axis='y') # TODO: look into auto-scaling y-axis
  
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
