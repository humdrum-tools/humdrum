## GNU makefile for Humdrum Toolkit C programs
##
## Description: This Makefile will compile C programs in the toolkit-source
##		directory, writing the executables directly into the
##		../../bin directory.  To compile the C programs, you must 
##		first have gcc installed on your computer.  Windows users 
##		should install in the cygwin unix terminal (available from 
##		http://www.cygwin.com).
##
## To run this makefile, type (without quotes) "make".
##

# Set the environmental variable $MACOSX_DEPLOYMENT_TARGET to
# "10.6" in Apple OS X to compile for OS X 10.6 and later (for example,
# you can compile for OS X 10.6 computers even if you are using a 10.8
# computer).
ENV    = MACOSX_DEPLOYMENT_TARGET=10.6
OSTYPE =
ARCH   =

# if OSTYPE is not defined, then this if statement will be run:
ifeq ($(origin OSTYPE), undefined)
   ifeq ($(shell uname),Darwin)
      OSTYPE = OSXPC
      ENV = MACOSX_DEPLOYMENT_TARGET=10.6
      # use the following to compile for 32-bit architecture on 64-bit comps:
      #ARCH = -m32 -arch i386
   else 
      OSTYPE = LINUX
      # use the following to compile for 32-bit architecture on 64-bit comps:
      # (you will need 32-bit libraries in order to do this)
      # ARCH = -m32 
   endif
endif
# Next if statement needed for some versions of make which already set OSTYPE:
ifeq ($(OSTYPE),linux)
   OSTYPE = LINUX
   # use the following to compile for 32-bit architecture on 64-bit comps:
   # (you will need 32-bit libraries in order to do this)
   # ARCH = -m32 
endif

# Cygwin (and MinGW?) adds the string ".exe" to the end of compiled programs.
# so select EXTEN = .exe when compiling in cygwin
EXTEN     =
ifeq ($(findstring CYGWIN,$(SYSTEM)), CYGWIN)
   EXTEN  = .exe
endif

SRCDIR    = .
TARGDIR   = ../../bin
COMPILER  = LANG=C $(ENV) gcc $(ARCH)
PREFLAGS  = -O3 -Wall
#PREFLAGS += -static
POSTFLAGS = 

vpath %.c $(SRCDIR)
PROGS = $(notdir $(patsubst %.c,%,$(wildcard $(SRCDIR)/*.c)))
.PHONY: all 

all: $(addprefix $(TARGDIR)/,$(PROGS))
	@echo Finished compiling all programs.

clean:
	-rm $(PROGS)

cleanbin: clean-bin
clean-bin:
	-(cd $(TARGDIR); rm $(PROGS))

# Compile to the $(TARGDIR) directory:
$(TARGDIR)/%: $(notdir %.c)
ifeq ($(wildcard $(TARGDIR)),)
	mkdir -p $(TARGDIR)
endif
	@echo [CC] $@
	@$(COMPILER) $(PREFLAGS) -o $@$(EXTEN) $< $(POSTFLAGS) \
		&& strip $@$(EXTEN)

# Test compile into the current directory:
%: $(notdir %.c)
	@echo [CC] $@
	@$(COMPILER) $(PREFLAGS) -o $@$(EXTEN) $< $(POSTFLAGS) \
		&& strip $@$(EXTEN)



