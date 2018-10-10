#===============================================================================
# Makefile: for compiling the CHOLMOD-EXTRA library
#===============================================================================

VERSION = 1.1.0

OPTIMIZATION = -O3

# C and C++ compiler flags.  The first three are standard for *.c and *.cpp
CF = $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -fexceptions -fPIC -Wall $(OPTIMIZATION)

# copy, delete, and rename a file
CP = cp -f
MV = mv -f
RM = rm -rf

# For "make install"
PREFIX = $(HOME)
#PREFIX = /usr/local
INSTALL_LIB = $(PREFIX)/lib
INSTALL_INCLUDE = $(PREFIX)/include/cholmod-extra

BLAS = -lopenblas

# Which version of MAKE you are using (default is "make")
# MAKE = make
# MAKE = gmake

#------------------------------------------------------------------------------
# remove object files
#------------------------------------------------------------------------------
CLEAN = Build/*.o Build/

default: library

#-------------------------------------------------------------------------------

C = $(CC) $(CF) $(CHOLMOD_CONFIG) $(CONFIG)

all: Build/libcholmod-extra.so tests issues

library: Build/libcholmod-extra.so

purge: distclean

distclean: clean
	- $(RM) Build/libcholmod-extra.so

clean:
	- $(RM) $(CLEAN)

#-------------------------------------------------------------------------------
# All include files:
#-------------------------------------------------------------------------------

INC =   Include/cholmod_extra.h

I = -I Include/

#-------------------------------------------------------------------------------
# CHOLMOD Extra library modules (int, double)
#-------------------------------------------------------------------------------

EXTRA = Build/cholmod_spinv.o

DI = $(EXTRA)

#-------------------------------------------------------------------------------
# CHOLMOD Extra library modules (long, double)
#-------------------------------------------------------------------------------

LEXTRA = Build/cholmod_l_spinv.o

DL = $(LEXTRA)

#-------------------------------------------------------------------------------

# to compile just the double/int version, use OBJ = $(DI)
OBJ = $(DI) $(DL)
LIBFLAGS = -shared -lcholmod -lm $(BLAS)

Build/libcholmod-extra.so: $(OBJ)
	$(C) $(LIBFLAGS) -o  $@ $^

$(OBJ): $(INC)

#-------------------------------------------------------------------------------
# Extra Module:
#-------------------------------------------------------------------------------

Build/cholmod_spinv.o: Source/cholmod_spinv.c Build
	$(C) -c $(I) $< -o $@

#-------------------------------------------------------------------------------

Build/cholmod_l_spinv.o: Source/cholmod_spinv.c Build
	$(C) -DDLONG -c $(I) $< -o $@

Build:
	mkdir -p Build

# install CHOLMOD Extra
install:
	mkdir -p $(INSTALL_LIB)
	mkdir -p $(INSTALL_INCLUDE)
	$(CP) Build/libcholmod-extra.so $(INSTALL_LIB)/libcholmod-extra.so.$(VERSION)
	( cd $(INSTALL_LIB) ; ln -sf libcholmod-extra.so.$(VERSION) libcholmod-extra.so )
	$(CP) Include/cholmod_extra*.h $(INSTALL_INCLUDE)
	chmod 755 $(INSTALL_LIB)/libcholmod-extra.so*
	chmod 644 $(INSTALL_INCLUDE)/cholmod_extra*.h

# uninstall CHOLMOD Extra
uninstall:
	$(RM) $(INSTALL_LIB)/libcholmod-extra.so*
	$(RM) $(INSTALL_INCLUDE)/cholmod_extra*.h

# Compile tests
tests: library
	$(C) $(I) Source/cholmod_test_spinv.c -Wl,-rpath,. -LBuild -lcholmod-extra -lcholmod -lm $(BLAS) -o Build/cholmod_test_spinv

issues: library
	$(C) $(I) Source/issue1.c -Wl,-rpath,. -LBuild -lcholmod-extra -lcholmod -lm $(BLAS) -o Build/issue1

check: tests
	LD_LIBRARY_PATH=Build/ Build/cholmod_test_spinv
