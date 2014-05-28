Humdrum Toolkit for Music Research
==================================

This repository contains the "classical" Humdrum Toolkit.

## Downloading Humdrum

To download the Humdrum Toolkit distribution go to the 
following page on the GitHub repository:
  http://github.com/humdrum-tools/humdrum
and click on the "Download ZIP" button.

If you are familiar with git, you may download the repository with the command:

```bash
    git clone https://github.com/humdrum-tools/humdrum
```

To use along with the [Humdrum Extras](https://github.com/craigsapp/humextra) package, it is better to install the Humdrum Toolkit from either:
   http://github.com/humdrum-tools/humdrum-tools
or
   http://github.com/humdrum-tools/humdrum-tools-with-data


## Compiling and Installing

To compile the C programs and create the ```bin``` directory, type inside
of the humdrum directory:

```bash
    make
```

## Configuring

Put the following lines in your ~/.bashrc or ~/.profile (depends on the
computer), in the example installation location ```/usr/local/humdrum```:

    export TMPDIR=/tmp
    export AWK_VER=gawk
    export CON=/dev/tty
    export HUMDRUM=/usr/local/humdrum/
    export PATH="/usr/local/humdrum/bin:$PATH"

Then restart the terminal to test if the installation is complete.  Try the command:

```bash
   which mint
```

which should reply with something like ```/usr/local/humdrum/bin/mint```.
  

