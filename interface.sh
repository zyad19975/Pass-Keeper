#!/bin/bash

echo ""
#go =0
devmem 0x43C00000 32 0x00

acc1=$(echo $1 | cut -c1-12)
acc2=$(echo $1 | cut -c13-20)
acc3=$(echo $1 | cut -c21-28)
acc4=$(echo $1 | cut -c29-)

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

devmem 0x43C00014 32 0x00 0x$acc1
devmem 0x43C00018 32 0x00 0x$acc2
devmem 0x43C0001C 32 0x00 0x$acc3
devmem 0x43C00020 32 0x00 0x$acc4

echo ""


echo "##################################"
echo "Master Key is Divided into"
echo "##################################"
echo "0x$mas1"
echo "0x$mas2"
echo "0x$mas3"
echo "0x$mas4"
devmem 0x43C00004 32 0x00 0x$mas1
devmem 0x43C00008 32 0x00 0x$mas2
devmem 0x43C0000C 32 0x00 0x$mas3
devmem 0x43C00010 32 0x00 0x$mas4

if [ "$3" != "" ]; then
echo ""
echo "##################################"
echo "Password is Divided into"
echo "##################################"
echo "0x$pass1"
echo "0x$pass2"
echo "0x$pass3"
echo "0x$pass4"

devmem 0x43C00024 32 0x00 0x$pass1
devmem 0x43C00028 32 0x00 0x$pass2
devmem 0x43C0002C 32 0x00 0x$pass3
devmem 0x43C00030 32 0x00 0x$pass4

else
devmem 0x43C00024 32 0x00 0x00
devmem 0x43C00028 32 0x00 0x00
devmem 0x43C0002C 32 0x00 0x00
devmem 0x43C00030 32 0x00 0x00
fi


devmem 0x43C00000 32 0x01
echo "Starting......"
devmem 0x43C00000 32 0x00
