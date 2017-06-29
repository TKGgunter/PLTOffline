#Thoth Gunter
#June 28,2017
#Test the pltu binding by calling values 
import sys, os
sys.path.append(os.getcwd() + "/../lib")

import libPLTU as PLTU

print("First column", PLTU.FIRSTCOL,
      "Last column", PLTU.LASTCOL,
      "First row", PLTU.FIRSTROW,
      "Last row", PLTU.LASTROW,
      "Number of columns", PLTU.NCOL,
      "Number of rows", PLTU.NROW,
      "Pixel width", PLTU.PIXELWIDTH,
      "Pixel height", PLTU.PIXELHEIGHT)




