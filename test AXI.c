
/*xsdb% connect
tcfchan#0
xsdb% target 2
xsdb% mwr -force 0x43C00000 1
xsdb% mwr -force 0x43C00004 0
xsdb% mwr -force 0x43C00008 0
xsdb% mwr -force 0x43C0000C 0
xsdb% mwr -force 0x43C00010 0
xsdb% mwr -force 0x43C00014 0
xsdb% mwr -force 0x43C00018 0
xsdb% mwr -force 0x43C0001C 0
xsdb% mwr -force 0x43C00020 0
xsdb% mwr -force 0x43C00024 0
xsdb% mwr -force 0x43C00028 0
xsdb% mwr -force 0x43C0002C 0
xsdb% mwr -force 0x43C00030 0
xsdb% mwr -force 0x43C00034 0
xsdb% mwr -force 0x43C00038 0
xsdb% mwr -force 0x43C00000 0
xsdb% mwr -force 0x43C0000C 0x54686174
xsdb% mwr -force 0x43C00010 0x73206D79
xsdb% mwr -force 0x43C00014 0x204B756E
xsdb% mwr -force 0x43C00018 0x67204675
xsdb% mwr -force 0x43C00004 1
xsdb% mwr -force 0x43C00004 1
xsdb% mwr -force 0x43C00004 0
xsdb% mrd -force 0X43C00040  
43C00040:   00000000                                                                                                                         
*/


/*Start Pass Keeper Test
Wrote in go: 0x00000000
Wrote in max_address: 0x00000000
Wrote in rst: 0x00000001
State: 0x00000000
Wrote in rst: 0x00000000
Wrote in master: 0x00000000 00000000 00000000 00000000
State: 0x00000007
Wrote in Account: 0x00000000 00000000 00000000 00000000
Wrote in Password: 0x00000000 00000000 00000000 43C00038
State: 0x00000009
Wrote in master: 0x54686174 73206D79 204B756E 67204675
Wrote in Password: 0x54776F20 4F6E6520 4E696E65 2054776F
State: 0x00000002
State: 0x0000000C
State: 0x00000002
State: 0x0000000C
State: 0x00000002
Wrote in go: 0x00000001
State: 0x00000002
Wrote in go: 0x00000000
State: 0x00000002
Read :0x29C3505F 571420F6 59D4E2E8 CD39DFCE
Hello World
*/






#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xbasic_types.h"


Xuint32 *baseaddr_p = (Xuint32 *)0x43C00000;

int main()
{
	Xuint32 *rst = (baseaddr_p +0);
	Xuint32 *go = (baseaddr_p +1);
	Xuint32 *max_address = (baseaddr_p +2);
	Xuint32 *master1 = (baseaddr_p +3);
	Xuint32 *master2 = (baseaddr_p +4);
	Xuint32 *master3 = (baseaddr_p +5);
	Xuint32 *master4 = (baseaddr_p +6);
	Xuint32 *acc1 = (baseaddr_p +7);
	Xuint32 *acc2 = (baseaddr_p +8);
	Xuint32 *acc3 = (baseaddr_p +9);
	Xuint32 *acc4 = (baseaddr_p +10);
	Xuint32 *pass1 = (baseaddr_p +11);
	Xuint32 *pass2 = (baseaddr_p +12);
	Xuint32 *pass3 = (baseaddr_p +13);
	Xuint32 *pass4 = (baseaddr_p +14);
	Xuint32 *null = (baseaddr_p +15);
	Xuint32 *o1 = (baseaddr_p +16);
	Xuint32 *o2 = (baseaddr_p +17);
	Xuint32 *o3 = (baseaddr_p +18);
	Xuint32 *o4 = (baseaddr_p +19);
	Xuint32 *done = (baseaddr_p +20);

    init_platform();

    xil_printf("Start Pass Keeper Test\n\r");

    *rst = 0x00000001;
    xil_printf("Wrote in rst: 0x%08x \n\r", *rst);

    *go = 0x00000000;
    *max_address = 0x00000000;
    xil_printf("Wrote in go: 0x%08x \n\r", *go);
    xil_printf("Wrote in max_address: 0x%08x \n\r", *max_address);

    *master1 = 0x00000000;
    *master2 = 0x00000000;
    *master3 = 0x00000000;
    *master4 = 0x00000000;
    xil_printf("Wrote in master: 0x%08x %08x %08x %08x \n\r", *master1,*master2,*master3,*master4);


    *acc1 = 0x00000000;
    *acc2 = 0x00000000;
    *acc3 = 0x00000000;
    *acc4 = 0x00000000;
    xil_printf("Wrote in Account: 0x%08x %08x %08x %08x \n\r", *acc1,*acc2,*acc3,*acc4);


    *pass1 = 0x00000000;
    *pass2 = 0x00000000;
    *pass3 = 0x00000000;
    *pass4 = 0x00000000;
    xil_printf("Wrote in Password: 0x%08x %08x %08x %08x \n\r", *pass1,*pass2,*pass3,pass4);


    *rst = 0x00000000;
    xil_printf("Wrote in rst: 0x%08x \n\r", *rst);

    *master1 = 0x54686174;
    *master2 = 0x73206D79;
    *master3 = 0x204B756E;
    *master4 = 0x67204675;
    xil_printf("Wrote in master: 0x%08x %08x %08x %08x \n\r", *master1,*master2,*master3,*master4);

    *pass1 = 0x54776F20;
    *pass2 = 0x4F6E6520;
    *pass3 = 0x4E696E65;
    *pass4 = 0x2054776F;
    xil_printf("Wrote in Password: 0x%08x %08x %08x %08x \n\r", *pass1,*pass2,*pass3,*pass4);

    int i = 0;
    while(i++<500);

    *go = 0x00000001;
    xil_printf("Wrote in go: 0x%08x \n\r", *go);

    i = 0;
    while(i++<50);

    *go = 0x00000000;
    xil_printf("Wrote in go: 0x%08x \n\r", *go);

    while(!*done);

    xil_printf("Read :0x%08x %08x %08x %08x \n\r", *o1,*o2,*o3,*o4);


    print("Hello World\n\r");

    cleanup_platform();
    return 0;
}
