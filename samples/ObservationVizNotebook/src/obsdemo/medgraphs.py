# Licensed Materials - Property of IBM
# Copyright IBM Corp. 2016, 2017
import numpy as np
from bokeh.plotting import figure, show
from bokeh.layouts import column, row
from bokeh.models import Range1d, BasicTicker
from bokeh.io import output_notebook, push_notebook
from bokeh.models.widgets import Div, Paragraph
import time
import collections
import queue
from obsdemo.utils import *

class ECGGraph:
    def __init__(self, signal_label, title='ECG', min_range=-1, max_range=1, plot_width=425, plot_height=200):
        self.data_queue = queue.Queue(maxsize=1000)
        self.ts_queue = queue.Queue(maxsize=1000)
        self.sig_label = signal_label

        self.ecg_patient_id = None
        self.ecg_maxLength = 600
        self.ecg_time = 0
        self.ecg_xdata = []
        self.ecg_ydata = []

        self.ecgFig = figure(plot_width=plot_width, plot_height=plot_height, toolbar_location=None)
        self.ecgFig.title.text = title
        self.ecgFig.title.align = "center"
        self.ecgFig.outline_line_width = 1
        self.ecgFig.outline_line_color = "black"
        self.ecgFig.y_range = Range1d(start=min_range, end=max_range)
        self.ecgFig.ygrid.grid_line_color = "red"
        self.ecgFig.ygrid.grid_line_alpha = 0.3
        self.ecgFig.xgrid.grid_line_color = "red"
        self.ecgFig.xgrid.grid_line_alpha = 0.3
        self.ecgFig.ygrid.minor_grid_line_color = 'red'
        self.ecgFig.ygrid.minor_grid_line_alpha = 0.1
        self.ecgFig.xgrid.minor_grid_line_color = 'red'
        self.ecgFig.xgrid.minor_grid_line_alpha = 0.1
        self.ecgFig.xaxis.major_label_text_font_size = '0pt'

        ## at a frequency of 100Hz, every 20 point is equal to 0.2 sec
        ## and ECG chart has a major tick every 0.2 sec, with minor
        ## ticks every 0.04 sec (5 minor ticks per major tick)
        xticker = BasicTicker()
        xticker.desired_num_ticks = int(self.ecg_maxLength / 20)
        xticker.num_minor_ticks = 5
        self.ecgFig.xgrid.ticker = xticker

        self.ecgGraph = self.ecgFig.line(self.ecg_xdata, self.ecg_ydata, line_width=1, line_color="black")

    def get_figure(self):
        return self.ecgFig

    def add(self, d):
        data_points = d['data']['signals'][self.sig_label]['y']        
        #ts_points = d['data']['signals']['signal_label']['t']

        list = [self.data_queue.put(data) for data in data_points]

    def update(self):
        try:
            point_val = self.data_queue.get_nowait()
            point_ts = self.ecg_time
        except queue.Empty:
            return

        new_data = {'x' : [point_ts], 'y' : [point_val]}
        self.ecgGraph.data_source.stream(new_data, rollover=self.ecg_maxLength)

        self.ecg_time += 1