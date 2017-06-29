CC = g++
CFLAGS=-std=c++11 -O3 -Wall `root-config --cflags`

#Python source code and shared libs
PYTHON_VERSION = 2.7
PYTHON_INCLUDE = /home/tgunter/anaconda2/include/python2.7/ 
PYTHON_LIB = /home/tgunter/anaconda2/lib/python2.7/config/ 

#ROOT lib
ROOT_LIB = /data/CernRoot/root_v5.34.05/root/lib/

#Where we're going to place our shared libs
SHARED_LIB = $(shell pwd)/lib/

#Location of pybind header files
PYBIND_INC = /home/tgunter/GIT/pybind11/include/

#Adding python and pybind include libs
CFLAGS += -I$(PYTHON_INCLUDE) -I$(PYBIND_INC) -Iinterface -I/data/CernRoot/root_v5.34.05/root/include/

#pre-compilation and compliation object defs and shared lib flags
OBJS  = $(patsubst src/%.cc,obj/%.o,$(wildcard src/*.cc))
LIBS  = $(patsubst src/%.cc,lib/lib%.so,$(wildcard src/*.cc))
SHARED_FLAGS = $(patsubst src/%.cc,-l%,$(wildcard src/*.cc))
SHARED_FLAGS += -lpthread -lrt -ldl -lutil `root-config --libs` -Llib -lMinuit -lSpectrum -lEve -lGeom 


#Executables
EXECS   = $(patsubst bin/%.cc,%,$(wildcard bin/*.cc))
EXECS := $(filter-out TestBufferReader,$(EXECS))


# Compile that shit
all: $(OBJS) $(LIBS) $(EXECS) clean_obj

%: bin/%.cc $(LIBS)
	$(CC) $(CFLAGS) -L$(SHARED_LIB) -L$(PYTHON_LIB) -L$(ROOT_LIB) $(SHARED_FLAGS) -lpython$(PYTHON_VERSION)  $< -o $@

obj/%.o: src/%.cc
	$(CC) $(CFLAGS) -fPIC -c $< -o $@


lib/libPLTTelescope.so: obj/PLTTelescope.o
	$(CC) -shared obj/PLTTelescope.o   -L$(PYTHON_LIB) -L$(ROOT_LIB) `root-config --libs` -Llib -lMinuit -lSpectrum -lEve -lGeom -lpython$(PYTHON_VERSION) -o lib/libPLTTelescope.so 


lib/libPLTHit.so: obj/PLTHit.o
	$(CC) -shared obj/PLTHit.o   -L$(PYTHON_LIB) -L$(ROOT_LIB) `root-config --libs` -Llib -lMinuit -lSpectrum -lEve -lGeom -lpython$(PYTHON_VERSION) -o lib/libPLTHit.so 


lib/libPLTAlignment.so: obj/PLTAlignment.o
	$(CC) -shared obj/PLTAlignment.o   -L$(PYTHON_LIB) -L$(ROOT_LIB) `root-config --libs` -Llib -lMinuit -lSpectrum -lEve -lGeom -lpython$(PYTHON_VERSION) -o lib/libPLTAlignment.so 


lib/libPLTTesterEvent.so: obj/PLTTesterEvent.o
	$(CC) -shared obj/PLTTesterEvent.o   -L$(PYTHON_LIB) -L$(ROOT_LIB) `root-config --libs` -Llib -lMinuit -lSpectrum -lEve -lGeom -lpython$(PYTHON_VERSION) -o lib/libPLTTesterEvent.so 


lib/libPLTTracking.so: obj/PLTTracking.o
	$(CC) -shared obj/PLTTracking.o   -L$(PYTHON_LIB) -L$(ROOT_LIB) `root-config --libs` -Llib -lMinuit -lSpectrum -lEve -lGeom -lpython$(PYTHON_VERSION) -o lib/libPLTTracking.so 


lib/libPLTHistReader.so: obj/PLTHistReader.o
	$(CC) -shared obj/PLTHistReader.o   -L$(PYTHON_LIB) -L$(ROOT_LIB) `root-config --libs` -Llib -lMinuit -lSpectrum -lEve -lGeom -lpython$(PYTHON_VERSION) -o lib/libPLTHistReader.so 


lib/libPLTU.so: obj/PLTU.o
	$(CC) -shared obj/PLTU.o   -L$(PYTHON_LIB) -L$(ROOT_LIB) `root-config --libs` -Llib -lMinuit -lSpectrum -lEve -lGeom -lpython$(PYTHON_VERSION) -o lib/libPLTU.so 


lib/libPLTGainCal.so: obj/PLTGainCal.o
	$(CC) -shared obj/PLTGainCal.o   -L$(PYTHON_LIB) -L$(ROOT_LIB) `root-config --libs` -Llib -lMinuit -lSpectrum -lEve -lGeom -lpython$(PYTHON_VERSION) -o lib/libPLTGainCal.so 


lib/libPLTBinaryFileReader.so: obj/PLTBinaryFileReader.o
	$(CC) -shared obj/PLTBinaryFileReader.o   -L$(PYTHON_LIB) -L$(ROOT_LIB) `root-config --libs` -Llib -lMinuit -lSpectrum -lEve -lGeom -lpython$(PYTHON_VERSION) -o lib/libPLTBinaryFileReader.so 


lib/libPLTError.so: obj/PLTError.o
	$(CC) -shared obj/PLTError.o   -L$(PYTHON_LIB) -L$(ROOT_LIB) `root-config --libs` -Llib -lMinuit -lSpectrum -lEve -lGeom -lpython$(PYTHON_VERSION) -o lib/libPLTError.so 


lib/libPLTTesterReader.so: obj/PLTTesterReader.o
	$(CC) -shared obj/PLTTesterReader.o   -L$(PYTHON_LIB) -L$(ROOT_LIB) `root-config --libs` -Llib -lMinuit -lSpectrum -lEve -lGeom -lpython$(PYTHON_VERSION) -o lib/libPLTTesterReader.so 


lib/libPLTCluster.so: obj/PLTCluster.o
	$(CC) -shared obj/PLTCluster.o   -L$(PYTHON_LIB) -L$(ROOT_LIB) `root-config --libs` -Llib -lMinuit -lSpectrum -lEve -lGeom -lpython$(PYTHON_VERSION) -o lib/libPLTCluster.so 


lib/libPLTEvent.so: obj/PLTEvent.o
	$(CC) -shared obj/PLTEvent.o   -L$(PYTHON_LIB) -L$(ROOT_LIB) `root-config --libs` -Llib -lMinuit -lSpectrum -lEve -lGeom -lpython$(PYTHON_VERSION) -o lib/libPLTEvent.so 


lib/libPLTPlane.so: obj/PLTPlane.o
	$(CC) -shared obj/PLTPlane.o   -L$(PYTHON_LIB) -L$(ROOT_LIB) `root-config --libs` -Llib -lMinuit -lSpectrum -lEve -lGeom -lpython$(PYTHON_VERSION) -o lib/libPLTPlane.so 


lib/libPLTTrack.so: obj/PLTTrack.o
	$(CC) -shared obj/PLTTrack.o   -L$(PYTHON_LIB) -L$(ROOT_LIB) `root-config --libs` -Llib -lMinuit -lSpectrum -lEve -lGeom -lpython$(PYTHON_VERSION) -o lib/libPLTTrack.so 





clean_obj:
	rm obj/*.o

clean:
	rm -f $(EXECS)  lib/*.so

cleanexe:
	rm -f $(EXECS)

cleanimg:
	rm -f *.eps *.gif *.jpg plots/*.*
