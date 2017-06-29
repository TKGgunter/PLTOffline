import sys, os

sys.path.append(os.getcwd() + "/lib")

import libPLTU, libPLTHit

print "PLTU", libPLTU.FIRSTROW, libPLTU.LASTROW
hit = libPLTHit.PLTHit(1, 2,3, 4, 5)
print "Hit", hit.ROC(), hit.ADC() 
