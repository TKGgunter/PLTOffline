#!/usr/bin/env python
#Thoth Gunter
from subprocess import call
import os

src_list = os.listdir(os.getcwd() + '/src/')#"/interface/" )
print src_list

obj_rq_map = {}

for src in src_list:
  if (".c" not in src) and (".h" not in src):
    continue
  obj = src.split(".")[0]


  call("g++ -std=c++11 -MM  -Iinterface/ -I/home/tgunter/GIT/pybind11/include/" +\
      " -I/data/CernRoot/root_v5.34.05/root/include/ -I/home/tgunter/anaconda2/include/python2.7/  src/{0}.cc > {0}.d".format(obj), shell=True)


  obj_rq_file = open( obj+".d", 'r')

  obj_rq = obj_rq_file.read().split(" ")
  obj_rq_file.close()

  call("rm {0}.d".format(obj), shell=True)

  obj_rq_list = []
  for f in src_list:
    if any(f in obj for obj in obj_rq):
      obj_rq_list.append("obj/" + f.split(".")[0])

  print obj_rq_list
  obj_rq_map[obj] = obj_rq_list




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
