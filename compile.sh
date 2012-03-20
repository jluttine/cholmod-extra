#!/bin/sh


# SPINV function
gcc -Wall -g -O0 -c -fPIC cholmod_spinv.c -o cholmod_spinv.o
#gcc -Wall -O2 -c -fPIC cholmod_spinv.c -o cholmod_spinv.o

# Static library
#ar rcs libcholmod-extra.a cholmod_spinv.o cholmod_spdist2.o

# Shared library
gcc -shared -W1,-soname,libcholmod-extra.so.1 -lcholmod -o libcholmod-extra.so.1.0.1 cholmod_spinv.o

#ln -s libcholmod-extra.so.1.0.1 libcholmod-extra.so

# Testing function
gcc -Wall -g -O0 -L ./ cholmod_test_spinv.c -lcholmod -lcholmod-extra -o cholmod_test_spinv.out
