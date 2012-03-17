#!/bin/sh

gcc -Wall -g -O0 -L ./ cholmod_test_spinv.c -lcholmod -lcholmod-extra -o cholmod_test_spinv.out

#gcc -Wall -g -O0 -c -fPIC cholmod_spinv.c -o cholmod_spinv.o
gcc -Wall -O2 -c -fPIC cholmod_spinv.c -o cholmod_spinv.o

#gcc -O3 -c -fPIC cholmod_spdist2.c -o cholmod_spdist2.o
#gcc -O3 -c -fPIC sparse_distance.c -o sparse_distance.o
#gcc -O3 -c -fPIC sparse_distance_wrap.c -o sparse_distance_wrap.o

# Static library
ar rcs libcholmod-extra.a cholmod_spinv.o cholmod_spdist2.o

# Shared library
gcc -shared -W1,-soname,libcholmod-extra.so.1 -lcholmod -o libcholmod-extra.so.1.0.1 cholmod_spinv.o cholmod_spdist2.o

