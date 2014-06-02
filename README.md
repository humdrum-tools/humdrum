Humdrum Toolkit for Music Research
==================================

This repository contains the "classical" Humdrum Toolkit.
To use along with the [Humdrum Extras](https://github.com/craigsapp/humextra) 
package, it is better to install the Humdrum Toolkit from either:
   https://github.com/humdrum-tools/humdrum-tools 
or
   https://github.com/humdrum-tools/humdrum-tools-with-data.

Further documentation about the Humdrum Toolkit as well 
as installing and using it can be found at http://www.humdrum.org.

Downloading
===============================

To download the Humdrum Toolkit package, go to the following page 
on the GitHub website:
  https://github.com/humdrum-tools/humdrum
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

If you want to download sample Humdrum musical scores without the 
Humdrum Extras package, you can do these commands:
```bash
    git clone https://github.com/humdrum-tools/humdrum
    cd humdrum
    git submodule add -f https://github.com/humdrum-tools/humdrum-data data
    git submodule update --init --recursive
```

Or to use the humdrum-data repository outside of the humdrum directory, type
in the installation directory:
```bash
    git clone --recursive https://github.com/humdrum-tools/humdrum-data
```


Compiling 
=========

To compile the C programs and create the ```bin``` directory for the
Humdrum Toolkit, type ```make bin``` inside of the humdrum directory:

```bash
    cd humdrum
    make bin
```

Note that the gcc program must be installed in order to compile the C programs.
Check to see if it is installed by typing this command:

````bash
   which gcc
```

The terminal should reply with something like ```/usr/bin/gcc```.
If gcc is not installed, then you will have to figure out how to install
it on your computer first.  Linux/Unix computers typically have it preinstalled
with the operating system; if not, then typing ```yum install gcc``` 
or ```apt-get install gcc``` will typically install it.  Apple OS X does 
not include it by default, and you will have to install it.  If you are 
using OS X Mavericks or later, then type ```xcode-select --install``` to
install the Xcode command line tools.

The Humdrum Toolkit is a unix command-line package.  To use in MS Windows, 
install a unix emulator.  A comprehensive package for linux tools in Windows 
can be downloaded from http://www.cygwin.com.  The simplest method is to 
download all cygwin packages when installing, but that will require a long 
installation duration (such as overnight for some reason).


Installing
==========

To use the Humdrum Toolkit commands in any directory, you must add the
humdrum/bin directory to the PATH environmental variable.  This can be
done temporarily for the current session by typing:
```bash
    export PATH="/usr/local/humdrum/bin:$PATH"
```
Assuming that the Humdrum Toolkit was installed in ```/usr/local```.  If you
type:
```bash
   echo $PATH
```
The computer will list the directories within the search path, each 
separated by a colon (:).  If the humdrum/bin directory is in the command
search path, then the ```which``` command should see the commands, such as
```bash
   which humdrum
```
which should report the path to the humdrum command, such as
```/usr/local/humdrum/bin/humdrum```.  If the computer replies with an
empty string after running the ```which``` command, then that means the
humdrum/bin directory is not in the PATH variable, or the bin directory
has not been created with ```make bin``` discussed above, or the Humdrum 
Toolkit is not installed in a location which matches to the path added
to the PATH variable.

To install the Humdrum Toolkit more permanently, the humdrum/bin
directory can be added to the path each time you log in by adding this
line to the ~/.profile file (~/ means your home directory, type ```cd```
to go to your home directory):
```bash
    export PATH="/usr/local/humdrum/bin:$PATH"
```
Superusers can add that line for all people on the computer system by placing
it instead in /etc/profile, or in a shell script file in /etc/profile.d.

The above line can be placed in ~/.profile by editing the file in a text
editor, or you can append the line from the terminal with this command:
```bash
    echo 'export PATH="/usr/local/humdrum/bin:$PATH"' >> ~/.profile
```
To have the computer read the ~/.profile file after the line has been added type:
```bash
   source ~/.profile
```
or log off an on again to have the computer automatically read ~/.profile
when you login..  


Verifying
=========

Once the Humdrum Toolkit has been installed, check that the humdrum/bin
directory has been added correctly to the PATH environmental variable by typing:
```bash
   echo $PATH | tr : '\n' | grep humdrum
```
which will list all command directories containing the string "humdrum" 
(there should at least one; otherwise, see the previous section about adding
humdrum/bin to the PATH variable).  You can further check that the commands
are visible by running the ```which``` command:
```bash
	which mint
```
This should reply with the location of the mint command, 
such as ```/usr/local/humdrum/bin/mint```.

Further testing can be done to ensure that the Humdrum Toolkit
commands are performing as expected on your particular computer
system.  Within the main Humdrum Toolkit directory (such as
/usr/local/humdrum), type ```make regression```.   This will run
all of the Humdrum Toolkit programs with various inputs and compare
to expected outputs.  The start of the test sequence should look
something like this:

```bash
   (cd toolkit-source/regression-tests; make -s verbose)
   TEST 01 for accent: OK
   TEST 01 for assemble: OK
   TEST 01 for barks: OK
   TEST 01 for cbr: OK
   TEST 01 for census: OK
   TEST 01 for cents: OK
   TEST 01 for cleave: OK
   TEST 01 for cocho: OK
   TEST 01 for context: OK
   TEST 01 for correl: OK
   TEST 01 for deg: OK
   TEST 01 for degree: OK
   TEST 01 for ditto: OK
```


Updating
========

To periodically update the humdrum package if you downloaded 
using <em>git</em>, type this command in the installation directory 
for humdrum:
```bash
   make update
   make bin
```



