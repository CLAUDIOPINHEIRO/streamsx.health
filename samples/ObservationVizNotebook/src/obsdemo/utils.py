from streamsx_health.ingest.Observation import *

class ObservationTypeFilter:
    def __init__(self, signal_name):
        self.signal_name = signal_name
    def __call__(self, tuple):
        return getReadingCode(tuple) == self.signal_name

def get_patient_ID(d):
    return d['patientId']

def to_viz_obj(d):
    t = []
    y = []
    label = getReadingCode(d[0])
    for obs in d:
        t.append(getReadingTs(obs))
        y.append(getReadingValue(obs))

    data = {"data" : {"signals" : {label : {"t" : t, "y" : y}}}}
    return data