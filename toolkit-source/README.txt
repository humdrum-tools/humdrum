Humdrum Toolkit source code, version 2.3.1
Tue May 27 23:06:36 PDT 2014
===========================================================================

Subdirectories in toolkit-source directory:

shell-programs    == Mostly sh shell interfaces to programs in awk-programs 
                     and c-programs that handle command-line option processing 
                     for the main awk and c programs.

awk-programs      == AWK programs that are interfaced through the shell 
                     scripts in shell-programs.

c-programs        == C program which need to be compiled and are interfaced
		     with shell scripts in shell-programs.

helpscrn          == Help screens (accessed with -h option in programs) which
		     are to be placed within $HUMDRUM/bin/helpscrn directory.

regression-tests  == Regression tests for Humdrum Toolkit programs. Type 
                     "make" or "make verbose" within the regression-tests 
                     directory to check programs for new errors.



