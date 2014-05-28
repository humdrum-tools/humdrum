Humdrum Toolkit for Music Research
==================================

This repository contains the "classical" Humdrum Toolkit.
To use along with the [Humdrum Extras](https://github.com/craigsapp/humextra) 
package, it is better to install the Humdrum Toolkit from either:
http://github.com/humdrum-tools/humdrum-tools
or
http://github.com/humdrum-tools/humdrum-tools-with-data.

Further documentation about the Humdrum Toolkit as well 
as installing and using it can be found at http://www.humdrum.org.

Downloading
===============================

To download the Humdrum Toolkit package, go to the 
following page on the GitHub repository:
  http://github.com/humdrum-tools/humdrum
and click on the "Download ZIP" button.

If you are familiar with git, you may download the Humdrum Toolkit 
repository with the command:

```bash
    git clone https://github.com/humdrum-tools/humdrum
```

To use alongside the Humdrum Extras package, instead type:

```bash
    git clone --recursive https://github.com/humdrum-tools/humdrum-tools
```

To use alongside the Humdrum Extras package, including data for 
musical scores, instead type:

```bash
    git clone --recursive https://github.com/humdrum-tools/humdrum-tools-with-data humdrum-tools
```

If you want to download sample Humdrum file data without the Humdrum Extras package, you can
do these commands:

```bash
    git clone https://github.com/humdrum-tools/humdrum
    cd humdrum
    git clone --recursive https://github.com/humdrum-tools/humdrum-data data
```


Compiling 
=========

To compile the C programs and create the ```bin``` directory for the
Humdrum Toolkit, type ```make``` inside of the humdrum directory:

```bash
    cd humdrum
    make
```

Note that the gcc program must be installed in order to compile the C programs.
Check to see if it is installed by typing this command:

````bash
   which gcc
```

The terminal should reply with something like ```/usr/bin/gcc```.
If gcc is not installed, then you will have to figure out how to install
it on your computer.  Linux/Unix computers typically have it pre-installed
with the operating system.  Apple OS X does not include it by default, and
you will have to install it.  If you are using OS X Mavericks, then type
this command to install gcc:

```bash
   xcode-select --install
```

The Humdrum Toolkit is a unix command-line package.  To use in MS Windows, install a
unix emulator.  A comprehensive package for linux tools in Windows can be
downloaded from http://www.cygwin.com.  The simplest method is to download
all cygwin packages when installing, but that will require a long installation
duration (such as overnight for some reason).


Installing and Configuring
==========================

Put the following lines in your ~/.profile  (The .profile file in your home
directory.  In the example installation below, ```/usr/local/humdrum```
is the path of the Humdrum Toolkit's installation location:

```bash
    export AWK_VER=gawk			# optional if awk/gawk in command search path
    export TMPDIR=/tmp			# optional if /tmp is used
    export CON=/dev/tty			# optional if /dev/tty is used
    export HUMDRUM=/usr/local/humdrum 	# optional in most cases
    export PATH="/usr/local/humdrum/bin:$PATH"
```

OS X users should change ```gawk``` to ```awk```.  Verify your version of awk
by typing ```which awk``` and then set the AWK_VER environment variable to
whatever that reports.  Humdrum Tools also have an automatic locator for the
awk interpreter, so usually the AWK_VER variable can be omitted from the
setup.  Likewise, TMPDIR does not have to be set if the default location to
save temporary files is ```/tmp```, as well as CON if ```/dev/tty``` is the
default.  If the Humdrum Tools bin directory is found in the command
search path, then it is also optional.

Then restart the terminal to test if the installation is complete.  Try the command:

```bash
   which mint
```

which should reply with something like ```/usr/local/humdrum/bin/mint```.
  
The only required setup variable is the PATH environmental variable, which
must include the location of the *bin* directory.  The PATH variable
is used by the terminal to list directories in which it can search
for commands.  The example Humdrum Toolkit bin directory
```/usr/local/humdrum/bin``` should be changed to the location that
you install the Humdrum Toolkit.  You can check on the current contents
of the PATH variable by typing this command:

```bash
   echo $PATH
```

To list each directory in the path list on a separate line for readability, try:

```bash
   echo $PATH | tr : '\n'
```

To check that .../humdrum/bin is in the search path all in one step:

```bash
   echo $PATH | tr : '\n' | grep 'humdrum/bin$'
```

If there are no lines of output from the above command, the
Humdrum Toolkit is not installed (you may need to restart the terminal
or type `source ~/.profile` to update the PATH variable).  If there
is more than one line of output from the above command, you apparently
have two installations of the Humdrum Toolkit (or one or more
non-existent installations).


