# Embedded Linux on FPGA Zybo-Zynq7000 

## Git required files

we will use [Yocto](https://www.yoctoproject.org/docs/2.0/yocto-project-qs/yocto-project-qs.html) project as an open-source project to build our Linux image.

### First we will start by installing the required tools.

```bash

# Ubuntu and Debian

$ sudo apt-get install gawk wget git-core diffstat unzip texinfo gcc-multilib \
  build-essential chrpath socat libsdl1.2-dev xterm```

# Fedora
$ sudo dnf install gawk make wget tar bzip2 gzip python unzip perl patch \
  diffutils diffstat git cpp gcc gcc-c++ glibc-devel texinfo chrpath \
  ccache perl-Data-Dumper perl-Text-ParseWords perl-Thread-Queue socat \
  findutils which SDL-devel xterm

# OpenSUSE

$ sudo zypper install python gcc gcc-c++ git chrpath make wget python-xml \
  diffstat makeinfo python-curses patch socat libSDL-devel xterm

# CentOS

$ sudo yum install gawk make wget tar bzip2 gzip python unzip perl patch \
  diffutils diffstat git cpp gcc gcc-c++ glibc-devel texinfo chrpath socat \
  perl-Data-Dumper perl-Text-ParseWords perl-Thread-Queue SDL-devel xterm

```

### Second get the right project files
First clone Yocto project files using:
```bash
$ git clone git://git.yoctoproject.org/poky
```

navigate to the Yocto directory
```bash
$ cd poky
```
then From [meta-xilinx](https://github.com/Xilinx/meta-xilinx) project on GitHub, you can find the best branch for your FPGA, then you have to clone this branch as well as [openembedded](https://github.com/openembedded/openembedded) same branch 

```bash
$ git clone -b branch_name https://github.com/Xilinx/meta-xilinx.git
$ git clone -b branch_name https://github.com/openembedded/openembedded.git
```
Just make sure that you are in the right branch 
```bash
$ git checkout branch_name
```
## Star configure your image

```bash
$ source oe-init-build-env
```
this command will move you to build directory
then you have to edit these two files 

conf/local.conf
conf/bblayers.conf

in local.conf find the line that specifies the machine time and comment it and replace it with our machine name

#### MACHINE ?= "zybo-zynq7" 

in bblayers.conf add these two lines below the existing ones

### /home/eepraxis/poky/meta-xilinx-bsp \
### /home/eepraxis/poky/meta-openembedded/meta-oe \

after that you are now can run bitbake command

```bash
$ bitbake core-image-minimal
```
## wait for the building to finish 
this will take a few hours depending on your computer and internet connection

after that, all the image files needed will be created 
