## Installation of Linux
As a Linux distribution is used on the FPGA for simplicity and to provide the necessary software for communications between the FPGA and the connected computer, interfacing between the software and hardware of the FPGA inside the Linux system is necessary so that the FPGA can use the custom-built hardware through the Linux system.

This section explains how PetaLinux was used with the Zybo ZYNQ Z7-20 FPGA board to compile the necessary boot files with the custom logic as well as install the OS distribution.

### Prerequisites
Before proceeding, the following prerequisites should be present:
1. Bitstream file (.bit)
2. Hardware Description File (.hdf)
3. PetaLinux v2017.4 for Linux  (https://www.xilinx.com/member/forms/download/xef.html?filename=petalinux-v2017.4-final-installer.run)
4. A Ubuntu Desktop 16.04 machine
5. A desktop environment. If not available, use VNC server.
6. SD card, and make sure that you know the device name/path of the SD card.

### Installing PetaLinux
On your Ubuntu Desktop 16.04 machine, download the PetaLinux v2017.4 for Linux and then execute the following as root assuming the downloaded file name is `petalinux-v2017.4-final-installer.run`:

```
# useradd -m xlnxuser
# mkdir -p /opt/pkg/petalinux
# mv petalinux-v2017.4-final-installer.run /home/xlnxuser/
# chown xlnxuser:xlnxuser /home/xlnxuser/petalinux-v2017.4-final-installer.run
# chown -R xlnxuser:xlnxuser /opt/pkt/petalinux
# apt-get install tofrodos gawk xvfb git libncurses5-dev tftpd zlib1g-dev zlib1g-dev:i386 libssl-dev flex bison chrpath socat autoconf libtool texinfo gcc-multilib libsdl1.2-dev libglib2.0-dev screen pax xterm build-essential
# su xlnxuser
$ cd ~
$ chmod +x petalinux-v2017.4-final-installer.run
$ ./petalinux-v2017.4-final-installer.run /opt/pkt/petalinux
$ mkdir ~/petalinux_projects
$ mkdir -p ~/.swt/lib/linux/x86_64/
$ apt-get install libswt-gtk-3-jni libswt-gtk-3-java
$ ln -s /usr/lib/jni/libswt-* ~/.swt/lib/linux/x86_64/
$ cd ~/petalinux_projects
$ mkdir PassKeeper
$ source /opt/pkg/petalinux/settings.sh
$ #make sure that you are connected via a graphical desktop environment or an X server for the next steps
$ petalinux-create --type project --template zynq --name PassKeeper
$ cd PassKeeper
$ mkdir hw_platform
$ cp /path/to/bitstream.bit hw_platform/
$ cp /path/to/hdf.hdf hw_platform/
$ petalinux-config --oldconfig --get-hw-description=./hw_platform
$ petalinux-config
Image Packaging Configuration -> Root filesystem type -> SDCard -> Exit -> Exit
$ petalinux-build
$ petalinux-package --boot --force --fsbl images/linux/zynq_fsbl.elf --fpga images/linux/system_wrapper.bit --u-boot # replace system_wrapper.bit with the actual bitstream name depending on your design
```

After executing the above, insert the SD card that will be connected to the FPGA. If you do not know your device path, execute the following command and look for your device name (by size, partition or other distinguishable attributes):

```
fdisk -l

We will assume that the device path is /dev/sdc during this guide. Execute the following to delete all partitions on the device (execute ‘d’ as many times as there are partitions):

# fdisk /dev/sdc
> d
...
> w
```

Partition the device by executing the following:

```
# fdisk /dev/sdc
> n
> p
> [Press Enter to start at the specified cylinder]
> +255M
> n
> p
> [Press Enter to start at the specified cylinder]
> [Press Enter to use the remaining space]
> w
```

Execute the following to create a FAT file system (required for booting):

```
# mkfs.vfat /dev/sdc1
```

Execute the following to copy the boot files to the FAT partition:

```
# mount /dev/sdc1 /mnt
# cp /home/xlnxuser/petalinux_projects/PassKeeper/images/linux/BOOT.bin  /home/xlnxuser/petalinux_projects/PassKeeper/images/linux/uImage /mnt/
# dd if=/home/xlnxuser/petalinux_projects/PassKeeper/images/linux/rootfs.ext4 /dev/sdc2 bs=4M status=progress
```

After completing the above, disconnect the SD card and insert it into the FPGA. The FPGA should now be ready to boot with your custom hardware.

## Using Ubuntu
Because PetaLinux is mainly the Linux kernel, which is not sufficient to provide all the necessary software for communications between the FPGA and Chromium, we replace the rootfs with a pre-built image of Ubuntu for simplicity and easier accessibility.
### Prerequisites
Before proceeding, make sure that you have the following prerequisites:
1. Ubuntu pre-installed image for ARM HF (https://wiki.ubuntu.com/ARM/RaspberryPi)
2. BOOT.BIN and uImage files generated in 4.1.2 Installing PetaLinux.
3. SD card, and make sure that you know the device name/path of the SD card.

### Installing Ubuntu
After getting the pre-installed Ubuntu image, from your Ubuntu 16.04 machine, execute the following assuming that the Ubuntu image is `ubuntu-18.04-preinstalled-server-armhf.img` and your SD card is located at /dev/sdc:

```
# dd if=ubuntu-18.04-preinstalled-server-armhf.img of=/dev/sdc bs=4M status=progress
```

After the operation is complete, your SD card should have 2 partitions; a BOOT partition (which is 255M when using the image used in this guide) and an EXT4 partition containing the root file system as explained previously in Chapter 3.

Copy the BOOT.BIN and uImage files to your boot partition by executing the following:

```
# mount /dev/sdc2 /mnt
# cp /path/to/BOOT.BIN /path/to/uImage /mnt/
# umount /mnt #unmount the partition
```

After the operation is complete, disconnect the SD card and connect it to your FPGA. Your FPGA should now be able to boot with the new Ubuntu system running on the compiled PetaLinux kernel.
