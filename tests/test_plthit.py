#Thoth Gunter
#June 28, 2017
#Test PLTHit bindings
#by testing the PLTHit class, methods and members.
import sys, os
sys.path.append(os.getcwd() + "/../lib")

from libPLTHit import PLTHit


#Test 1 initialization
#PLTHit's class definition includes and overloaded constructor. 
#The initialization should return the same values.
hit_1 = PLTHit()

hit_2 = PLTHit("2 1 30 15 5")
hit_3 = PLTHit(2, 1, 30, 15, 5)

if (hit_2.ROC() == hit_3.ROC() and\
   hit_2.Channel() == hit_3.Channel() and\
   hit_2.ADC() == hit_3.ADC() and\
   hit_2.Column() == hit_3.Column() and\
   hit_2.Row() == hit_3.Row()):
  
  print( "Overloaded contructor test passed.")


#Test set and get local position coordinates
lx = 12.3
ly = 15.2
hit_1.SetLXY(lx, ly)
print( "Test pass?:", [lx, ly] == [round(hit_1.LX(), 2), round(hit_1.LY(), 2)])
print( "Set: ", lx, ly, "\nRtrn:", hit_1.LX(), hit_1.LY())

#Test set and get telescope position coordinates
tx = 12.3
ty = 15.2
tz = 3.1
hit_1.SetTXYZ(tx, ty, tz)
print( "Test pass?:", [tx, ty, tz] == [round(i,2) for i in [hit_1.TX(), hit_1.TY(), hit_1.TZ()]])
print( "Set: ", tx, ty, tz, "\nRtrn:", hit_1.TX(), hit_1.TY(), hit_1.TZ())


#Test set and get global position coordinates
gx = 12.3
gy = 15.2
gz = 3.1
hit_1.SetGXYZ(gx, gy, gz)
print( "Test pass?:", [gx, gy, gz] == [round(i, 2) for i in (hit_1.GX(), hit_1.GY(), hit_1.GZ())])
print( "Set: ", gx, gy, gz, "\nRtrn:", hit_1.GX(), hit_1.GY(), hit_1.GZ())




