

/*
slv_reg0 <= 0;
slv_reg1 <= 4;
slv_reg2 <= 8;
slv_reg3 <= C;
slv_reg4 <= 10;
slv_reg5 <= 14;
slv_reg6 <= 18;
slv_reg7 <= 1C;
slv_reg8 <= 20;
slv_reg9 <= 24;
slv_reg10 <= 28;
slv_reg11 <= 2C;
slv_reg12 <= 30;
slv_reg13 <= 34;
slv_reg14 <= 38;
slv_reg15 <= 3C;
slv_reg16 <= 40;
slv_reg17 <= 44;
slv_reg18 <= 48;
slv_reg19 <= 4C;
slv_reg20 <= 50;
slv_reg21 <= 54;
*/









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
#include "Pass_keeper_final.h"
#include "stdio.h"
#include "xil_io.h"
uint32_t  *baseaddr_p = (uint32_t  *)XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR;

int main()
{


	  PASS_KEEPER_FINAL_mWriteReg (baseaddr_p, PASS_KEEPER_FINAL_S00_AXI_SLV_REG1_OFFSET,0x00000000);
	  //PASS_KEEPER_FINAL_mReadReg
/*

	    //PASS_KEEPER_FINAL_Reg_SelfTest(baseaddr_p);
	    uint32_t  *rst = (baseaddr_p +0);
		uint32_t  *go = (uint32_t  *)(XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR + PASS_KEEPER_FINAL_S00_AXI_SLV_REG1_OFFSET);
		uint32_t  *max_address = (uint32_t  *)(XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR + PASS_KEEPER_FINAL_S00_AXI_SLV_REG2_OFFSET);
		uint32_t  *master1 = (uint32_t  *)(XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR + PASS_KEEPER_FINAL_S00_AXI_SLV_REG3_OFFSET);
		uint32_t  *master2 = (uint32_t  *)(XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR + PASS_KEEPER_FINAL_S00_AXI_SLV_REG4_OFFSET);
		uint32_t  *master3 = (uint32_t  *)(XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR + PASS_KEEPER_FINAL_S00_AXI_SLV_REG5_OFFSET);
		uint32_t  *master4 = (uint32_t  *)(XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR + PASS_KEEPER_FINAL_S00_AXI_SLV_REG6_OFFSET);
		uint32_t  *acc1 = (uint32_t  *)(XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR + PASS_KEEPER_FINAL_S00_AXI_SLV_REG7_OFFSET);
		uint32_t  *acc2 = (uint32_t  *)(XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR + PASS_KEEPER_FINAL_S00_AXI_SLV_REG8_OFFSET);
		uint32_t  *acc3 = (uint32_t  *)(XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR + PASS_KEEPER_FINAL_S00_AXI_SLV_REG9_OFFSET);
		uint32_t  *acc4 = (uint32_t  *)(XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR + PASS_KEEPER_FINAL_S00_AXI_SLV_REG10_OFFSET);
		uint32_t  *pass1 = (uint32_t  *)(XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR + PASS_KEEPER_FINAL_S00_AXI_SLV_REG11_OFFSET);
		uint32_t  *pass2 = (uint32_t  *)(XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR + PASS_KEEPER_FINAL_S00_AXI_SLV_REG12_OFFSET);
		uint32_t  *pass3 = (uint32_t  *)(XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR + PASS_KEEPER_FINAL_S00_AXI_SLV_REG13_OFFSET);
		uint32_t  *pass4 = (uint32_t  *)(XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR + PASS_KEEPER_FINAL_S00_AXI_SLV_REG14_OFFSET);
		uint32_t  *state = (uint32_t  *)(XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR + PASS_KEEPER_FINAL_S00_AXI_SLV_REG15_OFFSET);
		uint32_t  *o1 = (uint32_t  *)(XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR + PASS_KEEPER_FINAL_S00_AXI_SLV_REG16_OFFSET);
		uint32_t  *o2 = (uint32_t  *)(XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR + PASS_KEEPER_FINAL_S00_AXI_SLV_REG17_OFFSET);
		uint32_t  *o3 = (uint32_t  *)(XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR + PASS_KEEPER_FINAL_S00_AXI_SLV_REG18_OFFSET);
		uint32_t  *o4 = (uint32_t  *)(XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR + PASS_KEEPER_FINAL_S00_AXI_SLV_REG19_OFFSET);
		uint32_t  *done = (uint32_t  *)(XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR + PASS_KEEPER_FINAL_S00_AXI_SLV_REG20_OFFSET);
		uint32_t  *boot = (uint32_t  *)(XPAR_PASS_KEEPER_FINAL_0_S00_AXI_BASEADDR + PASS_KEEPER_FINAL_S00_AXI_SLV_REG21_OFFSET);

    init_platform();

    xil_printf("Start Pass Keeper Test\n\r");
    xil_printf("#################################################################\n\r");

     //xil_printf("boot: 0x%08x \n\r", *boot);

    *go = 0x00000000;
    *max_address = 0x00000000;
    xil_printf("Wrote in go: 0x%08x \n\r", *go);
    xil_printf("Wrote in max_address: 0x%08x \n\r", *max_address);
    *master1 = 0x00000000;
    *master2 = 0x00000000;
    *master3 = 0x00000000;
    *master4 = 0x00000000;
    xil_printf("Wrote in master: 0x%08x %08x %08x %08x \n\r", *master1,*master2,*master3,*master4);
    xil_printf("State: 0x%08x \n\r", *state);


    *acc1 = 0x00000000;
    *acc2 = 0x00000000;
    *acc3 = 0x00000000;
    *acc4 = 0x00000000;
    xil_printf("Wrote in Account: 0x%08x %08x %08x %08x \n\r", *acc1,*acc2,*acc3,*acc4);


    *pass1 = 0x00000000;
    *pass2 = 0x00000000;
    *pass3 = 0x00000000;
    *pass4 = 0x00000000;
    xil_printf("Wrote in Password: 0x%08x %08x %08x %08x \n\r", *pass1,*pass2,*pass3,*pass4);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);

    xil_printf("boot: 0x%08x \n\r", *boot);


    xil_printf("State: 0x%08x \n\r", *state);

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
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("State: 0x%08x \n\r", *state);
    int i = 0;
    while(i++<500);

    *go = 0x00000001;
    xil_printf("Wrote in go: 0x%08x \n\r", *go);
    xil_printf("State: 0x%08x \n\r", *state);
    xil_printf("boot: 0x%08x \n\r", *boot);

    *go = 0x00000000;
    xil_printf("Wrote in go: 0x%08x \n\r", *go);
    xil_printf("State: 0x%08x \n\r", *state);

     xil_printf("Wrote in go: 0x%08x \n\r", *go);
     xil_printf("State: 0x%08x \n\r", *state);
     xil_printf("State: 0x%08x \n\r", *state);
     xil_printf("State: 0x%08x \n\r", *state);
     xil_printf("State: 0x%08x \n\r", *state);
    while(!*done);

    xil_printf("Read :0x%08x %08x %08x %08x \n\r", *o1,*o2,*o3,*o4);

    print("Hello World\n\n\n\r");
*/
    cleanup_platform();
    return 0;
}
