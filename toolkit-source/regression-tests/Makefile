# Makefile to run all command tests.

DIRS=$(subst /Test.script,,$(wildcard */Test.script))

all: 
	@for dir in $(DIRS); \
	do \
	   (cd $$dir; $(MAKE) -s)\
	done
	   

verbose: 
	@for dir in $(DIRS); \
	do \
	   (cd $$dir; $(MAKE) -s verbose)\
	done
	   

