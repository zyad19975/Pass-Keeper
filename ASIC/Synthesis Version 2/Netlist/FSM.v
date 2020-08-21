
module FSM ( clk, rst, match, go, enc_done, dec_done, max_add, cam_start, 
        start_dec, start_enc, boot_load_reg, cam_write_en, flash_write_en, 
        flash_or_acc_sel, flash_or_acc_reg, pass_enc_reg, new_old_pass_sel, 
        plain_reg, out_reg, flash_acc_reg, flash_pass_reg, local_master_sel, 
        local_master_reg, done, address_out, boot_done_signal );
  input [3:0] max_add;
  output [3:0] address_out;
  input clk, rst, match, go, enc_done, dec_done;
  output cam_start, start_dec, start_enc, boot_load_reg, cam_write_en,
         flash_write_en, flash_or_acc_sel, flash_or_acc_reg, pass_enc_reg,
         new_old_pass_sel, plain_reg, out_reg, flash_acc_reg, flash_pass_reg,
         local_master_sel, local_master_reg, done, boot_done_signal;
  wire   n115, N130, N131, N132, N133, N134, N136, N137, N138, N139, N140,
         N141, N142, N143, N144, n23, n24, n25, n26, n27, n29, n30, n31, n32,
         n34, n35, n37, n38, n39, n41, n42, n43, n44, n45, n46, n47, n48, n49,
         n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63,
         n64, n65, n66, n67, n68, n69, n71, n72, n73, n74, n75, n76, n77, n78,
         n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n1, n2,
         n3, n4, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18,
         n19, n20, n21, n22, n28, n33, n36, n70, n91, n92, n93, n94, n95, n98,
         n99, n101, n102, n103, n104, n105, n106, n108, n109, n110, n112,
         flash_acc_reg;
  wire   [4:0] currentstate;
  wire   [4:0] nextstate;
  assign flash_pass_reg = flash_acc_reg;

  LATCHX1_HVT \address_out_reg[0]  ( .CLK(N130), .D(N131), .Q(address_out[0]), 
        .QN(n32) );
  LATCHX1_HVT \address_out_reg[1]  ( .CLK(N130), .D(N132), .Q(address_out[1]), 
        .QN(n31) );
  LATCHX1_HVT \nextstate_reg[1]  ( .CLK(N139), .D(N141), .Q(nextstate[1]) );
  DFFARX1_HVT \currentstate_reg[1]  ( .D(nextstate[1]), .CLK(clk), .RSTB(n98), 
        .Q(n22), .QN(n26) );
  LATCHX1_HVT \nextstate_reg[4]  ( .CLK(N139), .D(N144), .Q(nextstate[4]) );
  DFFARX1_HVT \currentstate_reg[4]  ( .D(nextstate[4]), .CLK(clk), .RSTB(n98), 
        .Q(currentstate[4]), .QN(n23) );
  LATCHX1_HVT \address_out_reg[2]  ( .CLK(N130), .D(N133), .Q(address_out[2]), 
        .QN(n30) );
  LATCHX1_HVT \address_out_reg[3]  ( .CLK(N130), .D(N134), .Q(address_out[3]), 
        .QN(n29) );
  LATCHX1_HVT \nextstate_reg[0]  ( .CLK(N139), .D(N140), .Q(nextstate[0]) );
  DFFARX1_HVT \currentstate_reg[0]  ( .D(nextstate[0]), .CLK(clk), .RSTB(n98), 
        .Q(currentstate[0]), .QN(n27) );
  LATCHX1_HVT \nextstate_reg[3]  ( .CLK(N139), .D(N143), .Q(nextstate[3]) );
  DFFARX1_HVT \currentstate_reg[3]  ( .D(nextstate[3]), .CLK(clk), .RSTB(n98), 
        .Q(currentstate[3]), .QN(n24) );
  LATCHX1_HVT \nextstate_reg[2]  ( .CLK(N139), .D(N142), .Q(nextstate[2]) );
  DFFARX1_HVT \currentstate_reg[2]  ( .D(nextstate[2]), .CLK(clk), .RSTB(n98), 
        .Q(currentstate[2]), .QN(n25) );
  LATCHX1_HVT boot_done_signal_reg ( .CLK(N138), .D(n106), .Q(boot_done_signal) );
  LATCHX1_HVT cam_start_reg ( .CLK(N136), .D(n103), .Q(cam_start) );
  LATCHX1_HVT done_reg ( .CLK(N137), .D(out_reg), .Q(done) );
  NAND2X0_HVT U27 ( .A1(n12), .A2(n34), .Y(new_old_pass_sel) );
  NAND2X0_HVT U28 ( .A1(n42), .A2(n38), .Y(local_master_reg) );
  NAND2X0_HVT U29 ( .A1(n4), .A2(n16), .Y(flash_or_acc_reg) );
  NAND4X0_HVT U30 ( .A1(n41), .A2(n112), .A3(n43), .A4(n44), .Y(N142) );
  OA221X1_HVT U31 ( .A1(match), .A2(n45), .A3(n46), .A4(n47), .A5(n48), .Y(n44) );
  NAND2X0_HVT U34 ( .A1(n53), .A2(n33), .Y(n115) );
  OA21X1_HVT U35 ( .A1(n99), .A2(n47), .A3(n43), .Y(n50) );
  AO22X1_HVT U36 ( .A1(max_add[3]), .A2(n29), .A3(n54), .A4(n55), .Y(n46) );
  OR2X1_HVT U37 ( .A1(n29), .A2(max_add[3]), .Y(n55) );
  AO22X1_HVT U38 ( .A1(n56), .A2(n30), .A3(max_add[2]), .A4(n57), .Y(n54) );
  OR2X1_HVT U39 ( .A1(n30), .A2(n56), .Y(n57) );
  AO22X1_HVT U40 ( .A1(max_add[1]), .A2(n31), .A3(n58), .A4(max_add[0]), .Y(
        n56) );
  OA21X1_HVT U41 ( .A1(max_add[1]), .A2(n31), .A3(n32), .Y(n58) );
  NAND4X0_HVT U42 ( .A1(n41), .A2(n35), .A3(n59), .A4(n60), .Y(N140) );
  AOI221X1_HVT U46 ( .A1(enc_done), .A2(n65), .A3(go), .A4(n109), .A5(n66), 
        .Y(n64) );
  NAND2X0_HVT U47 ( .A1(n94), .A2(n102), .Y(n66) );
  NAND2X0_HVT U48 ( .A1(n67), .A2(n91), .Y(n43) );
  NAND2X0_HVT U50 ( .A1(dec_done), .A2(n8), .Y(n63) );
  NAND4X0_HVT U51 ( .A1(n104), .A2(n105), .A3(n102), .A4(n69), .Y(N137) );
  AND2X1_HVT U52 ( .A1(n18), .A2(n35), .Y(n69) );
  NAND4X0_HVT U55 ( .A1(n72), .A2(n73), .A3(n41), .A4(n74), .Y(N138) );
  NAND2X0_HVT U56 ( .A1(n75), .A2(n67), .Y(n41) );
  NAND2X0_HVT U59 ( .A1(n61), .A2(n37), .Y(n65) );
  NAND2X0_HVT U60 ( .A1(n6), .A2(n79), .Y(n37) );
  NAND2X0_HVT U61 ( .A1(n75), .A2(n79), .Y(n61) );
  NAND2X0_HVT U62 ( .A1(n62), .A2(n108), .Y(N143) );
  NAND2X0_HVT U63 ( .A1(n42), .A2(n10), .Y(plain_reg) );
  NAND2X0_HVT U64 ( .A1(n71), .A2(n28), .Y(n34) );
  AND3X1_HVT U66 ( .A1(n49), .A2(n112), .A3(n80), .Y(n62) );
  NAND2X0_HVT U67 ( .A1(n38), .A2(n52), .Y(start_enc) );
  NAND2X0_HVT U68 ( .A1(n79), .A2(n14), .Y(n52) );
  NAND2X0_HVT U69 ( .A1(n6), .A2(n7), .Y(n38) );
  NAND4X0_HVT U70 ( .A1(n72), .A2(n80), .A3(n42), .A4(n74), .Y(N136) );
  NAND2X0_HVT U71 ( .A1(n79), .A2(n91), .Y(n42) );
  AND2X1_HVT U72 ( .A1(currentstate[3]), .A2(currentstate[2]), .Y(n79) );
  NAND2X0_HVT U74 ( .A1(n68), .A2(n76), .Y(n39) );
  NAND2X0_HVT U77 ( .A1(n91), .A2(n17), .Y(n47) );
  AND2X1_HVT U78 ( .A1(n82), .A2(n9), .Y(n68) );
  NAND2X0_HVT U79 ( .A1(n17), .A2(n14), .Y(n53) );
  NAND2X0_HVT U80 ( .A1(n75), .A2(n7), .Y(n45) );
  AND2X1_HVT U81 ( .A1(n92), .A2(n25), .Y(n76) );
  AND2X1_HVT U82 ( .A1(n83), .A2(n84), .Y(N134) );
  OR2X1_HVT U83 ( .A1(n86), .A2(n30), .Y(n85) );
  AND2X1_HVT U84 ( .A1(n87), .A2(n84), .Y(N133) );
  NAND2X0_HVT U85 ( .A1(address_out[0]), .A2(address_out[1]), .Y(n86) );
  AND2X1_HVT U86 ( .A1(n88), .A2(n84), .Y(N132) );
  AND2X1_HVT U87 ( .A1(n84), .A2(n32), .Y(N131) );
  NAND2X0_HVT U89 ( .A1(n73), .A2(n49), .Y(n84) );
  NAND2X0_HVT U90 ( .A1(n67), .A2(n14), .Y(n49) );
  AND2X1_HVT U91 ( .A1(n89), .A2(n11), .Y(n77) );
  AND2X1_HVT U92 ( .A1(currentstate[2]), .A2(n1), .Y(n67) );
  NAND2X0_HVT U93 ( .A1(n17), .A2(n6), .Y(n73) );
  AND2X1_HVT U94 ( .A1(n89), .A2(currentstate[0]), .Y(n78) );
  AND2X1_HVT U95 ( .A1(n22), .A2(n23), .Y(n89) );
  NAND2X0_HVT U96 ( .A1(n75), .A2(n17), .Y(n81) );
  AND2X1_HVT U97 ( .A1(n13), .A2(n11), .Y(n75) );
  AND2X1_HVT U98 ( .A1(n23), .A2(n26), .Y(n82) );
  NAND2X0_HVT U100 ( .A1(n21), .A2(n28), .Y(n90) );
  IBUFFX2_HVT U3 ( .A(n22), .Y(n70) );
  INVX1_HVT U4 ( .A(n9), .Y(n11) );
  INVX0_HVT U5 ( .A(n92), .Y(n1) );
  INVX1_HVT U6 ( .A(n24), .Y(n92) );
  NBUFFX2_HVT U7 ( .A(n78), .Y(n6) );
  INVX1_HVT U8 ( .A(n39), .Y(boot_load_reg) );
  INVX1_HVT U9 ( .A(n27), .Y(n9) );
  INVX0_HVT U10 ( .A(n19), .Y(n2) );
  AND3X1_HVT U11 ( .A1(n36), .A2(currentstate[4]), .A3(n11), .Y(n3) );
  IBUFFX2_HVT U12 ( .A(currentstate[4]), .Y(n19) );
  DELLN2X2_HVT U13 ( .A(n12), .Y(n94) );
  INVX0_HVT U14 ( .A(n95), .Y(pass_enc_reg) );
  AND3X1_HVT U15 ( .A1(n15), .A2(n81), .A3(n47), .Y(n72) );
  AO21X1_HVT U16 ( .A1(n17), .A2(n90), .A3(n19), .Y(n74) );
  AND4X1_HVT U17 ( .A1(n43), .A2(n45), .A3(n61), .A4(n15), .Y(n60) );
  NAND2X0_HVT U18 ( .A1(n67), .A2(n78), .Y(n4) );
  AND2X1_HVT U19 ( .A1(n67), .A2(n78), .Y(flash_or_acc_sel) );
  AND2X1_HVT U20 ( .A1(currentstate[3]), .A2(n25), .Y(n7) );
  AND2X1_HVT U21 ( .A1(n3), .A2(n28), .Y(n8) );
  INVX0_HVT U22 ( .A(n8), .Y(n10) );
  AND3X1_HVT U23 ( .A1(n36), .A2(currentstate[4]), .A3(n27), .Y(n71) );
  NAND2X0_HVT U24 ( .A1(n77), .A2(n7), .Y(n12) );
  AND2X1_HVT U25 ( .A1(n70), .A2(n19), .Y(n13) );
  AND2X1_HVT U26 ( .A1(n89), .A2(n11), .Y(n14) );
  DELLN2X2_HVT U32 ( .A(n53), .Y(n15) );
  INVX0_HVT U33 ( .A(n115), .Y(n16) );
  NBUFFX2_HVT U43 ( .A(n36), .Y(n17) );
  NAND2X0_HVT U44 ( .A1(n3), .A2(n70), .Y(n18) );
  INVX1_HVT U45 ( .A(n16), .Y(cam_write_en) );
  AND4X4_HVT U49 ( .A1(n94), .A2(n52), .A3(n16), .A4(n108), .Y(n51) );
  INVX1_HVT U53 ( .A(n38), .Y(local_master_sel) );
  INVX1_HVT U54 ( .A(n94), .Y(n20) );
  INVX0_HVT U57 ( .A(n93), .Y(start_dec) );
  INVX1_HVT U58 ( .A(n11), .Y(n21) );
  INVX1_HVT U65 ( .A(n70), .Y(n28) );
  NAND2X0_HVT U73 ( .A1(n3), .A2(n70), .Y(n33) );
  AND2X1_HVT U75 ( .A1(n25), .A2(n24), .Y(n36) );
  AND2X1_HVT U76 ( .A1(n71), .A2(n70), .Y(flash_write_en) );
  AND2X1_HVT U88 ( .A1(n21), .A2(n13), .Y(n91) );
  AND3X2_HVT U99 ( .A1(n35), .A2(n42), .A3(n18), .Y(n48) );
  NAND2X0_HVT U101 ( .A1(n77), .A2(n7), .Y(n93) );
  AND3X2_HVT U102 ( .A1(n52), .A2(n101), .A3(n10), .Y(n59) );
  NAND2X0_HVT U103 ( .A1(n91), .A2(n7), .Y(n95) );
  AND3X2_HVT U104 ( .A1(n4), .A2(n95), .A3(n45), .Y(n80) );
  NAND4X1_HVT U105 ( .A1(n49), .A2(n95), .A3(n50), .A4(n51), .Y(N141) );
  NAND4X1_HVT U106 ( .A1(n2), .A2(n17), .A3(n21), .A4(n70), .Y(n35) );
  NAND3X1_HVT U107 ( .A1(n74), .A2(n81), .A3(n110), .Y(N130) );
  INVX1_HVT U108 ( .A(n84), .Y(n110) );
  NAND4X1_HVT U109 ( .A1(n62), .A2(n63), .A3(n48), .A4(n64), .Y(N139) );
  OR2X1_HVT U110 ( .A1(n65), .A2(n20), .Y(N144) );
  INVX1_HVT U111 ( .A(rst), .Y(n98) );
  XNOR2X1_HVT U112 ( .A1(address_out[3]), .A2(n85), .Y(n83) );
  XNOR2X1_HVT U113 ( .A1(address_out[2]), .A2(n86), .Y(n87) );
  XNOR2X1_HVT U114 ( .A1(n31), .A2(address_out[0]), .Y(n88) );
  INVX0_HVT U115 ( .A(n46), .Y(n99) );
  INVX0_HVT U116 ( .A(n35), .Y(out_reg) );
  INVX0_HVT U117 ( .A(N130), .Y(n101) );
  INVX0_HVT U118 ( .A(N138), .Y(n102) );
  INVX0_HVT U119 ( .A(n45), .Y(n103) );
  INVX0_HVT U120 ( .A(N143), .Y(n104) );
  INVX0_HVT U121 ( .A(N144), .Y(n105) );
  INVX0_HVT U122 ( .A(n41), .Y(n106) );
  INVX0_HVT U123 ( .A(plain_reg), .Y(n108) );
  INVX0_HVT U124 ( .A(n43), .Y(n109) );
  INVX0_HVT U125 ( .A(start_enc), .Y(n112) );
  INVX0_HVT U126 ( .A(n37), .Y(flash_acc_reg) );
endmodule

