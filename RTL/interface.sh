#!/bin/bash

echo ""
#go =0
devmem2 0x43C00000 w 0x0

acc1=$(echo $1 | cut -c1-8)
acc2=$(echo $1 | cut -c9-16)
acc3=$(echo $1 | cut -c17-24)
acc4=$(echo $1 | cut -c25-)

pass1=$(echo $3 | cut -c1-8)
pass2=$(echo $3 | cut -c9-16)
pass3=$(echo $3 | cut -c17-24)
pass4=$(echo $3 | cut -c25-)

mas1=$(echo $2 | cut -c1-8)
mas2=$(echo $2 | cut -c9-16)
mas3=$(echo $2 | cut -c17-24)
mas4=$(echo $2 | cut -c25-)

echo "##################################"
echo "Account is Divided into"
echo "##################################"
echo "0x$acc1"
echo "0x$acc2"
echo "0x$acc3"
echo "0x$acc4"

devmem2 0x43C00014 w 0x$acc1
devmem2 0x43C00018 w 0x$acc2
devmem2 0x43C0001C w 0x$acc3
devmem2 0x43C00020 w 0x$acc4

echo ""


echo "##################################"
echo "Master Key is Divided into"
echo "##################################"
echo "0x$mas1"
echo "0x$mas2"
echo "0x$mas3"
echo "0x$mas4"
devmem2 0x43C00004 w 0x$mas1
devmem2 0x43C00008 w 0x$mas2
devmem2 0x43C0000C w 0x$mas3
devmem2 0x43C00010 w 0x$mas4

if [ "$3" != "" ]; then
echo ""
echo "##################################"
echo "Password is Divided into"
echo "##################################"
echo "0x$pass1"
echo "0x$pass2"
echo "0x$pass3"
echo "0x$pass4"

devmem2 0x43C00024 w 0x$pass1
devmem2 0x43C00028 w 0x$pass2
devmem2 0x43C0002C w 0x$pass3
devmem2 0x43C00030 w 0x$pass4

else
devmem2 0x43C00024 w 0x00
devmem2 0x43C00028 w 0x00
devmem2 0x43C0002C w 0x00
devmem2 0x43C00030 w 0x00
fi


devmem2 0x43C00000 w 0x01
echo "Starting......"
devmem2 0x43C00000 w 0x0
