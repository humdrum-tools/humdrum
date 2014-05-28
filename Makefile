## GNU makefile for Humdrum Toolkit
##
## Description: This Makefile will compile C programs in the toolkit-source
##		directory, then copy all humdrum programs and help files
##		into the bin directory.  To compile the C programs, you must 
##		first have gcc installed on your computer.  Windows users 
##		should install in the cygwin unix terminal (available from 
##		http://www.cygwin.com).
##
## To run this makefile, type (without quotes) "make".  After successful
## compiling, you must add the bin directory to your command search path.
## This can be done automatically with the command "make install".
##

.PHONY: all awk shell help clean cprogs install

BINDIR = bin

HUMDRUM_PATH    := $(shell echo $$PATH |tr : '\n'|grep 'humdrum/bin'|head -n 1)
HUMDRUM_TARGET  := $(shell echo `pwd`/bin)

all: awk shell help cprogs


cprogs:
	(cd toolkit-source/c-programs; $(ENV) $(MAKE))


clean:
	rm -rf $(BINDIR)


awk:
	mkdir -p $(BINDIR)
	cp toolkit-source/awk-programs/* $(BINDIR)/


shell:
	mkdir -p $(BINDIR)
	cp toolkit-source/shell-wrappers/* $(BINDIR)/


help:
	mkdir -p $(BINDIR)/helpscrn
	cp toolkit-source/helpscrn/* $(BINDIR)/helpscrn/


# "make install" Will add the current humdrum/bin directory to the
# .profile file in the user's home directory.  If the super user
# is installing the Humdrum Toolkit, then they should instead manually
# add the installation bin directory into the /etc/profile file.

install:

ifeq (,$(HUMDRUM_PATH))
	echo "export PATH=`pwd`/bin:\$$PATH" >> ~/.profile
	@echo "[0;32m"
	@echo "*** `pwd`/bin added to command search path"
	@echo "*** in ~/.profile.  Now either close this shell and restart"
	@echo "*** another, or type the command:"
	@echo "***     [0;31msource ~/.profile[0;32m"
	@echo "*** to update the \$$PATH environmental variable in the current"
	@echo "*** shell.  Then type:"
	@echo "***     [0;31mwhich census[0;32m"
	@echo "*** to verify that the Humdrum Tools are accessible."
	@echo "*** The computer should reply to the above command with this string:"
	@echo "***     [0;31m`pwd`/bin/census[0;32m"
	@echo "[0m"
else ifneq ($HUMDRUM_PATH,$HUMDRUM_TARGET)
	echo "export PATH=`pwd`/bin:\$$PATH" >> ~/.profile
	@echo "[0;31m"
	@echo "*** `pwd`/bin added to command search path"
	@echo "*** in ~/.profile.  A different humdrum/bin directory already"
	@echo "*** exists in the command search path.  This installation will"
	@echo "*** shadow the one in:"
	@echo "***   [0;32m$(HUMDRUM_PATH)[0;31m"
	@echo "*** Now either close this shell and restart another, or type the command:"
	@echo "***     [0;32msource ~/.profile[0;31m"
	@echo "*** to update the \$$PATH environmental variable in the current shell."
	@echo "*** Then type:"
	@echo "***     [0;32mwhich census[0;31m"
	@echo "*** to verify that the Humdrum Tools are accessible."
	@echo "*** The computer should reply to the above command with this string:"
	@echo "***     [0;32m`pwd`/bin/census[0;31m"
	@echo "[0m"
else
	@echo ""
	@echo "[0;32mHumdrum Toolkit is already installed.[0m"
	@echo ""
endif



