#!/bin/zsh
master=$1
account=$2
password=$3

baseaddr_p="0x43C00000"
rst=$(([##16] $baseaddr_p + 0))
go=$(([##16] $baseaddr_p + 1))
max_address=$(([##16] $baseaddr_p + 2))
master1=$(([##16] $baseaddr_p + 3))
master2=$(([##16] $baseaddr_p + 4))
master3=$(([##16] $baseaddr_p + 5))
master4=$(([##16] $baseaddr_p + 6))
acc1=$(([##16] $baseaddr_p + 7))
acc2=$(([##16] $baseaddr_p + 8))
acc3=$(([##16] $baseaddr_p + 9))
acc4=$(([##16] $baseaddr_p + 10))
pass1=$(([##16] $baseaddr_p + 11))
pass2=$(([##16] $baseaddr_p + 12))
pass3=$(([##16] $baseaddr_p + 13))
pass4=$(([##16] $baseaddr_p + 14))
null=$(([##16] $baseaddr_p + 15))
o1=$(([##16] $baseaddr_p + 16))
o2=$(([##16] $baseaddr_p + 17))
o3=$(([##16] $baseaddr_p + 18))
o4=$(([##16] $baseaddr_p + 19))
done=$(([##16] $baseaddr_p + 20))

#TODO: convert inputs to hex
#TODO: write to or retrieve from memory based on given inputs
#devmem2 0x$acc1 value
#devmem2 0x$done
