from collections import deque

class TumblingWindow:
    def __init__ (self, length):
        self.length = length
        self.window = {}
    
    def __call__ (self, tuple):
        patientId = self.get_patient_id(tuple)
        self.window.setdefault(patientId, [])
        
        self.window[patientId].append(tuple)
        if(len(self.window[patientId]) == self.length):
             temp = self.window[patientId]
             self.window[patientId] = []
             return temp
            
    def get_patient_id(self, tuple):
        return tuple['patientId']