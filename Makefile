#===============================================================================
# Makefile: for compiling the CHOLMOD-EXTRA library
#===============================================================================

VERSION = 1.0.0

# C and C++ compiler flags.  The first three are standard for *.c and *.cpp
CF = $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -O3 -fexceptions -fPIC

# ranlib, and ar, for generating libraries.  If you don't need ranlib,
# just change it to RANLAB = echo
RANLIB = ranlib
ARCHIVE = $(AR) $(ARFLAGS)

# copy, delete, and rename a file
CP = cp -f
MV = mv -f
# RM = rm -f

# C and Fortran libraries
LIB = -lcholmod #-lm

# For "make install"
#INSTALL_LIB = $(HOME)/.local/lib
#INSTALL_INCLUDE = $(HOME)/.local/include
INSTALL_LIB = /usr/local/lib
INSTALL_INCLUDE = /usr/local/include

# Which version of MAKE you are using (default is "make")
# MAKE = make
# MAKE = gmake

#------------------------------------------------------------------------------
# remove object files
#------------------------------------------------------------------------------
CLEAN = Build/*.o

default: all

#-------------------------------------------------------------------------------

C = $(CC) $(CF) $(CHOLMOD_CONFIG) $(CONFIG)

all: Build/libcholmod-extra.so

library: Build/libcholmod-extra.so

purge: distclean

distclean: clean
	- $(RM) Build/libcholmod-extra.so

clean:
	- $(RM) $(CLEAN)

#-------------------------------------------------------------------------------
# All include files:
#-------------------------------------------------------------------------------

INC =   Include/cholmod_extra.h \
	Include/cholmod_extra_internal.h

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
LIBFLAGS = -shared

Build/libcholmod-extra.so: $(OBJ)
	$(C) $(LIBFLAGS) -o  $@ $^

$(OBJ): $(INC)

#-------------------------------------------------------------------------------
# Extra Module:
#-------------------------------------------------------------------------------

Build/cholmod_spinv.o: Source/cholmod_spinv.c
	$(C) -c $(I) $< -o $@

#-------------------------------------------------------------------------------

Build/cholmod_l_spinv.o: Source/cholmod_spinv.c
	$(C) -DDLONG -c $(I) $< -o $@


# install CHOLMOD Extra
install:
	$(CP) Build/libcholmod-extra.so $(INSTALL_LIB)/libcholmod-extra.so.$(VERSION)
	( cd $(INSTALL_LIB) ; ln -sf libcholmod-extra.so.$(VERSION) libcholmod-extra.so )
	$(CP) Include/cholmod_extra*.h $(INSTALL_INCLUDE)
	chmod 755 $(INSTALL_LIB)/libcholmod-extra.so*
	chmod 644 $(INSTALL_INCLUDE)/cholmod_extra*.h

# uninstall CHOLMOD Extra
uninstall:
	$(RM) $(INSTALL_LIB)/libcholmod-extra.so*
	$(RM) $(INSTALL_INCLUDE)/cholmod_extra*.h

