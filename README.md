Humdrum Toolkit for Music Research
==================================

This repository contains the "classical" Humdrum Toolkit.
To use along with the [Humdrum Extras](https://github.com/craigsapp/humextra) package, it is better to install the Humdrum Toolkit from either:
   http://github.com/humdrum-tools/humdrum-tools
or
   http://github.com/humdrum-tools/humdrum-tools-with-data


## Downloading Humdrum

To download the Humdrum Toolkit package go to the 
following page on the GitHub repository:
  http://github.com/humdrum-tools/humdrum
and click on the "Download ZIP" button.

If you are familiar with git, you may download the repository with the command:

```bash
    git clone https://github.com/humdrum-tools/humdrum
```


## Compiling and Installing

To compile the C programs and create the ```bin``` directory, type inside
of the humdrum directory:

```bash
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
this command:

```bash
   xcode-select --install
```

Humdrum is a unix command-line package.  To use in MS Windows, install a
unix emulator.  A comprehensive package for linux tools in windows can be
downloaded from http://www.cygwin.com.  The simplest method is to download
all cygwin packages when installing, but that will require a long installation
duration.


## Configuring

Put the following lines in your ~/.bashrc or ~/.profile (depends on the
computer), in the example installation location ```/usr/local/humdrum```:

    export AWK_VER=gawk		# optional if awk or gawk in command search path
    export TMPDIR=/tmp		# optional if /tmp is used
    export CON=/dev/tty		# optional if /dev/tty is used
    export HUMDRUM=/usr/local/humdrum/
    export PATH="/usr/local/humdrum/bin:$PATH"

OS X users should change ```gawk``` to ```awk```.  Verify your version of awk
by typing ```which awk``` and then set the AWK_VER environment variable to
whatever that reports.  Humdrum Tools also have an automatic locator for the
awk interpreter, so usually the AWK_VER variable can be ommited from the
setup.  Likewise, TMPDIR does not have to be set if the default location to
save temporary files is ```/tmp```, as well as CON if ```/dev/tty``` is the
default



Then restart the terminal to test if the installation is complete.  Try the command:

```bash
   which mint
```

which should reply with something like ```/usr/local/humdrum/bin/mint```.
  

