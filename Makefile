## GNU/BSD makefile for the Humdrum Toolkit.
##
## Programmer:    Craig Stuart Sapp <craig@ccrma.stanford.edu>
## Creation Date: Mon Jun  2 18:42:00 PDT 2014
## Last Modified: Mon Jun  2 19:02:24 PDT 2014
## Filename:      ...humdrum/Makefile
##
## Description: This Makefile will compile C programs in the toolkit-source
##	directory, then copy all other humdrum programs and help files
##	into the humdrum/bin directory.  To compile the C programs, you must 
##	first have gcc installed on your computer.  Windows users 
##	should install in the cygwin unix terminal (available from 
##	http://www.cygwin.com) in which to use the Humdrum Toolkit.
##
## To run this makefile, type (without quotes) "make bin".  After successful
## compiling, you must add the bin directory to your command search path.
## This can be done automatically with the command "make install" if you
## are doing a single-user installation.
##

.PHONY: all awk shell help clean cprogs install bin regression support data

BINDIR = bin

# Variables used to give hints about setup for $PATH environmental variable:
HUMDRUM_PATH    := $(shell echo $$PATH | tr : '\n' | grep 'humdrum/bin' | head -n 1)
HUMDRUM_TARGET  := $(shell echo `pwd`/bin)

# Variables needed for remove-data target:
VALUE1 = $(shell if [ -r .gitmodules ]; then grep -A2 -n -m1 '^\[submodule "data"\]' .gitmodules | sed 's/[^0-9].*//'; fi)
VALUE2 = $(shell if [ ! -z $(VALUE1) ]; then echo "$(VALUE1)+2" | bc; fi)

# Variables needed for remove-webdoc target:
VALUE3 = $(shell if [ -r .gitmodules ]; then grep -A2 -n -m1 '^\[submodule "webdoc"\]' .gitmodules | sed 's/[^0-9].*//'; fi)
VALUE4 = $(shell if [ ! -z $(VALUE3) ]; then echo "$(VALUE3)+2" | bc; fi)



###########################################################################
##
## Default target which lists main targets that the makefile can run.
##

all: 
	@echo
	@echo "Available make targets:"
	@echo "[0;32mmake[0m            -- Print this list."
	@echo "[0;32mmake bin[0m        -- Create the bin directory from toolkit-source files."
	@echo "[0;32mmake checkpath[0m  -- Check that the PATH variable is correctly configured;"
	@echo "                   otherwise, run [0;32mmake install[0m to add bin directory"
	@echo "                   to PATH in ~/.profile." 
	@echo "[0;32mmake install[0m    -- Add bin directoy in command path (for single-user"
	@echo "                   installations)."
	@echo "[0;32mmake regression[0m -- Check Humdrum Tookit programs for configuration errors."
	@echo "[0;32mmake data[0m       -- Download humdrum-data repository (into 'data' subdirectory)."
	@echo "[0;32mmake webdoc[0m     -- Download Humdrum documentation website repository"
	@echo "                   (into 'webdoc' subdirectory)."
	@echo "[0;32mmake clean[0m      -- Delete automatic content (bin, data, webdoc)."
	@echo



###########################################################################
##
## Compile C programs and construct the humdrum/bin directory.
##

bin: awk shell help cprogs support
	@echo "[0;32m"
	@echo "*** Type '[0;31mmake checkpath[0;32m' to have the computer examine"
	@echo "*** the PATH enviroment variable and make sugguestions about the"
	@echo "*** next step in installation of the Humdrum Toolkit."
	@echo "[0m"



###########################################################################
##
## Remove all automatically generated content.
##

clean: remove-data remove-webdoc
	rm -rf $(BINDIR)



###########################################################################
##
## Targets that add content to bin directory
##

cprogs:
ifeq (($shell which gcc),)
	@echo "[0;31m"
	@echo "*** Error: you must first install gcc.  If you are using OS X Mavericks"
	@echo "*** or later, then install with the command:"
	@echo "***    [0;32mxcode-select --install[0;31m"
	@echo "*** If you are using a flavor of linux, then try either of these commands:"
	@echo "***    [0;32myum install gcc[0;31m"
	@echo "***    [0;32mapt-get install gcc[0;31m"
	@echo "[0m"
	exit 1
endif
	-(cd toolkit-source/c-programs; $(ENV) $(MAKE))


awk:
	mkdir -p $(BINDIR)
	cp toolkit-source/awk-programs/* $(BINDIR)/


shell:
	mkdir -p $(BINDIR)
	cp toolkit-source/shell-scripts/* $(BINDIR)/


help:
	mkdir -p $(BINDIR)/helpscrn
	-cp toolkit-source/helpscrn/* $(BINDIR)/helpscrn/


support:
	mkdir -p $(BINDIR)
	-cp toolkit-source/support-files/* $(BINDIR)
	@chmod 0755 $(BINDIR)/ekern1.sed



###########################################################################
##
## Targets for adding/removing data repository 
##

data: checkgit
	git submodule add -f https://github.com/humdrum-tools/humdrum-data data
	git submodule update --init --recursive


remove-data: checkgit
ifneq ($(VALUE2),)
	-git submodule deinit -f data
	-git rm --cached data
	-rm -rf data
	-rm -rf .git/modules/data
	cat .gitmodules | sed '$(VALUE1),$(VALUE2)d' > .gitmodules-temp
	-mv .gitmodules-temp .gitmodules
endif
	-if [ -r .gitmodules ]; \
	 then \
            if [ `wc -l .gitmodules | sed 's/^ *//; s/ .*//'` == "0" ]; \
            then \
               rm .gitmodules; \
            fi; \
         fi



###########################################################################
##
## Targets for adding/removing Humdrum website documentation 
##

webdoc: checkgit
	git submodule add -f https://github.com/humdrum-tools/humdrum-tools.github.io webdoc
	git submodule update --init --recursive


remove-webdoc: checkgit
ifneq ($(VALUE4),)
	-git submodule deinit -f webdoc
	-git rm --cached webdoc
	-rm -rf webdoc
	-rm -rf .git/modules/webdoc
	cat .gitmodules | sed '$(VALUE3),$(VALUE4)d' > .gitmodules-temp
	-mv .gitmodules-temp .gitmodules
endif
	-if [ -r .gitmodules ]; \
	 then \
            if [ `wc -l .gitmodules | sed 's/^ *//; s/ .*//'` == "0" ]; \
            then \
               rm .gitmodules; \
            fi; \
         fi



###########################################################################
##
## Update repository and any submodules to their respective master versions:
##

pull: update
update: checkgit
	git pull
ifneq ($(wildcard .gitmodules),) 
	git submodule update --init --recursive
	git submodule foreach "(git checkout master; git pull origin master)"
endif



###########################################################################
##
## Run regression tests.  Run each regression test and repor the results
##     for each test.
##

regressions: regression
regression-tests: regression
tests: regression
test: regression
regression:
	(cd toolkit-source/regression-tests; $(MAKE) -s verbose)


## "make regression-quiet" will test install programs to see if they
## are working as expected, reporting only problem tests.
regression-quiet:
	(cd toolkit-source/regression-tests; $(MAKE) -s)



###########################################################################
##
## Installing target for setting up $PATH environmental variable.
##
## "make install" Will add the current humdrum/bin directory to the
## .profile file in the user's home directory.  If the super user
## is installing the Humdrum Toolkit, then they should instead manually
## add the installation bin directory into the /etc/profile file.

install:
ifeq (,$(HUMDRUM_PATH))
	echo "export PATH=`pwd`/bin:\$$PATH" >> ~/.profile
	source ~/.profile
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
	@echo "*** If so, then the Humdrum Toolkit is installed and ready to use!"
	@echo "*** You can also run regression tests to check command behaviors:"
	@echo "***     [0;31mmake regression[0;32m"
	@echo "[0m"
else ifneq ($(HUMDRUM_PATH),$(HUMDRUM_TARGET))
	echo "export PATH=`pwd`/bin:\$$PATH" >> ~/.profile
	source ~/.profile
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
	@echo "[0;32m"
	@echo "*** The humdrum/bin directory is registered in the PATH environment variable."
	@echo "*** Test that the Humdrum Toolkit programs are available by typing the command:"
	@echo "***     [0;31mwhich census[0;32m"
	@echo "*** The computer should reply to the above command with this string:"
	@echo "***     [0;31m`pwd`/bin/census[0;32m"
	@echo "*** If so, then the Humdrum Toolkit is installed and ready to use!"
	@echo "*** You can also run regression tests to check command behaviors:"
	@echo "***     [0;31mmake regression[0;32m"
	@echo "[0m"
endif



###########################################################################
##
## See of the command path is found in $PATH.
##

checkpath:
ifeq (,$(HUMDRUM_PATH))
	@echo "[0;31m"
	@echo "*** For a single-user installation, this is typically is done with the command:"
	@echo "***    [0;32mecho \"PATH=\$$PATH:`pwd`/humdrum/bin\" >> ~/.profile"
	@echo "*** or type 'make install' to have this Makefile do this for you."
	@echo "*** System-wide installation by a super-user should be done by adding the"
	@echo "*** above command to >> /etc/profile instead of >> ~/.profile."
	@echo "[0m"
else ifneq ($(HUMDRUM_PATH),$(HUMDRUM_TARGET))
	@echo "[0;31m"
	@echo "*** A different humdrum/bin directory already exists in the command search";
	@echo "*** path.  This installation will be shadowed by the one in:";
	@echo "***   [0;32m$(HUMDRUM_PATH)[0;31m"
	@echo "*** Either move this installation to that location or remove the other"
	@echo "*** installation from the command search path (typically by editing the"
	@echo "*** PATH variable in ~/.profile or in /etc/profile)."
	@echo "***"
	@echo "*** Typing '[0;32mmake install[0;31m' for a single-user installation will hide the"
	@echo "*** other installation in $(HUMDRUM_PATH) and use"
	@echo "*** this one instead."
	@echo "[0m"
else
	@echo "[0;32m"
	@echo "*** The humdrum command path is configured properly in the PATH environment"
	@echo "*** variable.  Type '[0;31mwhich mint[0;32m' to verify that you can see a program in the"
	@echo "*** humdrum/bin directory.  If the terminal replies with:"
	@echo "***    [0;31m$(HUMDRUM_PATH)/mint[0;32m"
	@echo "*** then the Humdrum Toolkit is set up properly and ready to use."
	@echo "*** You can also run regression tests to check command behaviors:"
	@echo "***     [0;31mmake regression[0;32m"
	@echo "[0m"
endif



###########################################################################
##
## When doing certain targets, git is presumed to be installed, and 
##   is presumed to be the method of downloading the repository.
##

checkgit:
ifeq ($(shell which git),)
	@echo "[0;31m"
	@echo "*** Error: to use the update target, you must have git command installed"
	@echo "[0m"
	exit 1
endif
ifeq ($(wildcard .git),)
	@echo "[0;31m"
	@echo "*** Error: to use the update target, you must have installed"
	@echo "*** the Humdrum Toolkit with git:"
	@echo "***    [0;32mgit clone https://github.com/humdrum-tools/humdrum[0;31m"
	@echo "[0m"
	exit 1
endif



