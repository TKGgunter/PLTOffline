#Thoth Gunter
#June 28,2017
#Test the pltu binding by calling values 
import sys, os
sys.path.append(os.getcwd() + "/../lib")

import libPLTEvent as PLTEvent


DataFileName = 
GainCalFileName = 
AlignmentFileName =

event = PLTEvent(DataFileName, GainCalFileName, AlignmentFileName)
event.ReadOnlinePixelMask("../Mask_2016_VdM_v1.txt")






