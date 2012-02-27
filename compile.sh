#!/bin/sh

# Static library
gcc -c -fPIC cholmod_spinv.c -I/usr/include/suitesparse/ -o cholmod_spinv.o
ar rcs libcholmod-extra.a cholmod_spinv.o

# Shared library
gcc -c -fPIC cholmod_spinv.c -I/usr/include/suitesparse/ -o cholmod_spinv.o
gcc -shared -W1,-soname,libcholmod-extra.so.1 -o libcholmod-extra.so.1.0.1 cholmod_spinv.o

