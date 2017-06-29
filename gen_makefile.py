#!/usr/bin/env python
#Thoth Gunter

"""
This script creates a Makefile that appropiately links static object files when created the shared objects need for python bindings
"""

from subprocess import call
import os

#Load the list of source files for the project
src_list = os.listdir(os.getcwd() + '/src/')#"/interface/" )
print "List of source files to be compiled", src_list

#This the object requirement map. 
obj_rq_map = {}

for src in src_list:
  if (".c" not in src) :#and (".h" not in src):
    continue
  obj = src.split(".")[0]

  #Produces list all the files with are required to compile program and saves it to a .d file 
  call("g++ -std=c++11 -MM  -Iinterface/ -I/home/tgunter/GIT/pybind11/include/" +\
      " -I/data/CernRoot/root_v5.34.05/root/include/ -I/home/tgunter/anaconda2/include/python2.7/  src/{0}.cc > {0}.d".format(obj), shell=True)


  #Read and store requirements
  obj_rq_file = open( obj+".d", 'r')
  obj_rq = obj_rq_file.read().split(" ")
  obj_rq_file.close()



  #Clean up .d by moving them to the build directory.
  call("mv {0}.d build/.".format(obj), shell=True)



  #List any dependancies within our library
  obj_rq_list = []

  for f in src_list:
    if any(f.split(".")[0] in obj_ for obj_ in obj_rq): #any return true if any of the comparisons within are true
      obj_rq_list.append("obj/" + f.split(".")[0])

  print obj, "requirement list", obj_rq_list
  obj_rq_map[obj] = obj_rq_list



#Making the new Makefile
makefile_template = open("Makefile_template", "r")
makefile = open("Makefile", "w")

for line in makefile_template.read().split("#/"):

  def dress_line(line):
    line_ = ""
    if any(var in line for var in ['XXX', 'YYY']):
      for rq in obj_rq_map:
        print rq, obj_rq_map[rq]
        line_ += line
        line_ = line_.replace("XXX", rq)
        line_ = line_.replace("YYY", ".o ".join(obj_rq_map[rq]) + ".o")
    else:
      line_ += line
    return line_

  makefile.write(dress_line(line))

makefile_template.close()
makefile.close()
