
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
  wire   N130, N131, N132, N133, N134, N136, N137, N138, N139, N140, N141,
         N142, N143, N144, n23, n24, n25, n26, n27, n29, n30, n31, n32, n1, n2,
         n3, n4, n5, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18,
         n19, n20, n21, n22, n28, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55,
         n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69,
         n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83,
         n84, n85, n86, n88, n89, boot_load_reg, flash_acc_reg, n95;
  wire   [4:0] nextstate;
  assign pass_enc_reg = boot_load_reg;
  assign flash_pass_reg = flash_acc_reg;

  LATCHX1_HVT \address_out_reg[0]  ( .CLK(N130), .D(N131), .Q(address_out[0]), 
        .QN(n32) );
  LATCHX1_HVT \address_out_reg[1]  ( .CLK(N130), .D(N132), .Q(address_out[1]), 
        .QN(n31) );
  LATCHX1_HVT \nextstate_reg[1]  ( .CLK(N139), .D(N141), .Q(nextstate[1]) );
  DFFARX1_HVT \currentstate_reg[1]  ( .D(nextstate[1]), .CLK(clk), .RSTB(n95), 
        .Q(n3), .QN(n26) );
  LATCHX1_HVT \nextstate_reg[4]  ( .CLK(N139), .D(N144), .Q(nextstate[4]) );
  DFFARX1_HVT \currentstate_reg[4]  ( .D(nextstate[4]), .CLK(clk), .RSTB(n95), 
        .Q(n4), .QN(n23) );
  LATCHX1_HVT \address_out_reg[2]  ( .CLK(N130), .D(N133), .Q(address_out[2]), 
        .QN(n30) );
  LATCHX1_HVT \address_out_reg[3]  ( .CLK(N130), .D(N134), .Q(address_out[3]), 
        .QN(n29) );
  LATCHX1_HVT \nextstate_reg[0]  ( .CLK(N139), .D(N140), .Q(nextstate[0]) );
  DFFARX1_HVT \currentstate_reg[0]  ( .D(nextstate[0]), .CLK(clk), .RSTB(n95), 
        .Q(n1), .QN(n27) );
  LATCHX1_HVT \nextstate_reg[3]  ( .CLK(N139), .D(N143), .Q(nextstate[3]) );
  DFFARX1_HVT \currentstate_reg[3]  ( .D(nextstate[3]), .CLK(clk), .RSTB(n95), 
        .Q(n2), .QN(n24) );
  LATCHX1_HVT \nextstate_reg[2]  ( .CLK(N139), .D(N142), .Q(nextstate[2]) );
  DFFARX1_HVT \currentstate_reg[2]  ( .D(nextstate[2]), .CLK(clk), .RSTB(n95), 
        .Q(n5), .QN(n25) );
  LATCHX1_HVT boot_done_signal_reg ( .CLK(N138), .D(n89), .Q(boot_done_signal)
         );
  LATCHX1_HVT cam_start_reg ( .CLK(N136), .D(n88), .Q(cam_start) );
  LATCHX1_HVT done_reg ( .CLK(N137), .D(out_reg), .Q(done) );
  NAND2X1_HVT U3 ( .A1(n50), .A2(n38), .Y(N143) );
  NAND4X1_HVT U4 ( .A1(n50), .A2(n51), .A3(n33), .A4(n52), .Y(N139) );
  NBUFFX8_HVT U5 ( .A(n86), .Y(out_reg) );
  NAND2X0_HVT U6 ( .A1(n7), .A2(n8), .Y(new_old_pass_sel) );
  INVX0_HVT U7 ( .A(n9), .Y(n86) );
  INVX0_HVT U8 ( .A(n10), .Y(flash_write_en) );
  INVX0_HVT U9 ( .A(n11), .Y(n88) );
  INVX0_HVT U10 ( .A(n12), .Y(n89) );
  INVX0_HVT U11 ( .A(n13), .Y(boot_load_reg) );
  INVX0_HVT U12 ( .A(n14), .Y(flash_or_acc_sel) );
  INVX0_HVT U13 ( .A(n15), .Y(local_master_sel) );
  INVX0_HVT U14 ( .A(n16), .Y(flash_acc_reg) );
  INVX0_HVT U15 ( .A(rst), .Y(n95) );
  NAND2X0_HVT U16 ( .A1(n15), .A2(n17), .Y(local_master_reg) );
  NAND2X0_HVT U17 ( .A1(n14), .A2(n18), .Y(flash_or_acc_reg) );
  NAND4X0_HVT U18 ( .A1(n12), .A2(n19), .A3(n20), .A4(n21), .Y(N142) );
  OA221X1_HVT U19 ( .A1(match), .A2(n11), .A3(n22), .A4(n28), .A5(n33), .Y(n21) );
  NAND4X0_HVT U20 ( .A1(n34), .A2(n13), .A3(n35), .A4(n36), .Y(N141) );
  AND4X1_HVT U21 ( .A1(n8), .A2(n37), .A3(n18), .A4(n38), .Y(n36) );
  INVX0_HVT U22 ( .A(cam_write_en), .Y(n18) );
  NAND2X0_HVT U23 ( .A1(n39), .A2(n10), .Y(cam_write_en) );
  OA21X1_HVT U24 ( .A1(n40), .A2(n28), .A3(n20), .Y(n35) );
  INVX0_HVT U25 ( .A(n22), .Y(n40) );
  AO22X1_HVT U26 ( .A1(n29), .A2(max_add[3]), .A3(n41), .A4(n42), .Y(n22) );
  OR2X1_HVT U27 ( .A1(n29), .A2(max_add[3]), .Y(n42) );
  AO22X1_HVT U28 ( .A1(max_add[2]), .A2(n43), .A3(n30), .A4(n44), .Y(n41) );
  OR2X1_HVT U29 ( .A1(n43), .A2(max_add[2]), .Y(n44) );
  AO22X1_HVT U30 ( .A1(n31), .A2(max_add[1]), .A3(n45), .A4(n32), .Y(n43) );
  OA21X1_HVT U31 ( .A1(max_add[1]), .A2(n31), .A3(max_add[0]), .Y(n45) );
  NAND4X0_HVT U32 ( .A1(n9), .A2(n7), .A3(n46), .A4(n47), .Y(N140) );
  AND4X1_HVT U33 ( .A1(n20), .A2(n39), .A3(n12), .A4(n11), .Y(n47) );
  AND3X1_HVT U34 ( .A1(n37), .A2(n48), .A3(n49), .Y(n46) );
  INVX0_HVT U35 ( .A(N130), .Y(n48) );
  AOI221X1_HVT U36 ( .A1(go), .A2(n53), .A3(enc_done), .A4(n54), .A5(n55), .Y(
        n52) );
  NAND2X0_HVT U37 ( .A1(n8), .A2(n56), .Y(n55) );
  INVX0_HVT U38 ( .A(n20), .Y(n53) );
  NAND2X0_HVT U39 ( .A1(n57), .A2(n58), .Y(n20) );
  AND3X1_HVT U40 ( .A1(n9), .A2(n17), .A3(n10), .Y(n33) );
  NAND2X0_HVT U41 ( .A1(dec_done), .A2(n59), .Y(n51) );
  INVX0_HVT U42 ( .A(n7), .Y(n59) );
  NAND4X0_HVT U43 ( .A1(n60), .A2(n61), .A3(n56), .A4(n62), .Y(N137) );
  AND2X1_HVT U44 ( .A1(n10), .A2(n9), .Y(n62) );
  NAND3X0_HVT U45 ( .A1(n63), .A2(n1), .A3(n26), .Y(n9) );
  NAND3X0_HVT U46 ( .A1(n63), .A2(n27), .A3(n26), .Y(n10) );
  INVX0_HVT U47 ( .A(N138), .Y(n56) );
  NAND3X0_HVT U48 ( .A1(n64), .A2(n12), .A3(n65), .Y(N138) );
  NAND2X0_HVT U49 ( .A1(n57), .A2(n66), .Y(n12) );
  NAND2X0_HVT U50 ( .A1(n67), .A2(n68), .Y(n64) );
  INVX0_HVT U51 ( .A(N144), .Y(n61) );
  OR2X1_HVT U52 ( .A1(n54), .A2(start_dec), .Y(N144) );
  INVX0_HVT U53 ( .A(n8), .Y(start_dec) );
  NAND2X0_HVT U54 ( .A1(n69), .A2(n70), .Y(n8) );
  NAND2X0_HVT U55 ( .A1(n16), .A2(n49), .Y(n54) );
  NAND2X0_HVT U56 ( .A1(n66), .A2(n71), .Y(n49) );
  NAND2X0_HVT U57 ( .A1(n68), .A2(n71), .Y(n16) );
  INVX0_HVT U58 ( .A(N143), .Y(n60) );
  INVX0_HVT U59 ( .A(plain_reg), .Y(n38) );
  NAND2X0_HVT U60 ( .A1(n17), .A2(n7), .Y(plain_reg) );
  NAND3X0_HVT U61 ( .A1(n27), .A2(n3), .A3(n63), .Y(n7) );
  AND2X1_HVT U62 ( .A1(n67), .A2(n4), .Y(n63) );
  AND3X1_HVT U63 ( .A1(n34), .A2(n19), .A3(n72), .Y(n50) );
  INVX0_HVT U64 ( .A(start_enc), .Y(n19) );
  NAND2X0_HVT U65 ( .A1(n15), .A2(n37), .Y(start_enc) );
  NAND2X0_HVT U66 ( .A1(n70), .A2(n71), .Y(n37) );
  NAND2X0_HVT U67 ( .A1(n68), .A2(n69), .Y(n15) );
  NAND3X0_HVT U68 ( .A1(n72), .A2(n17), .A3(n65), .Y(N136) );
  AND3X1_HVT U69 ( .A1(n39), .A2(n28), .A3(n73), .Y(n65) );
  NAND2X0_HVT U70 ( .A1(n58), .A2(n67), .Y(n28) );
  NAND2X0_HVT U71 ( .A1(n67), .A2(n70), .Y(n39) );
  NAND2X0_HVT U72 ( .A1(n58), .A2(n71), .Y(n17) );
  AND2X1_HVT U73 ( .A1(n2), .A2(n5), .Y(n71) );
  AND3X1_HVT U74 ( .A1(n13), .A2(n11), .A3(n14), .Y(n72) );
  NAND2X0_HVT U75 ( .A1(n57), .A2(n68), .Y(n14) );
  INVX0_HVT U76 ( .A(n74), .Y(n68) );
  NAND2X0_HVT U77 ( .A1(n66), .A2(n69), .Y(n11) );
  NAND2X0_HVT U78 ( .A1(n58), .A2(n69), .Y(n13) );
  AND2X1_HVT U79 ( .A1(n25), .A2(n2), .Y(n69) );
  AND3X1_HVT U80 ( .A1(n23), .A2(n1), .A3(n26), .Y(n58) );
  MUX21X1_HVT U81 ( .A1(n75), .A2(n76), .S0(n29), .Y(N134) );
  AND3X1_HVT U82 ( .A1(n77), .A2(n78), .A3(n79), .Y(n76) );
  INVX0_HVT U83 ( .A(n30), .Y(n77) );
  AO21X1_HVT U84 ( .A1(n30), .A2(n80), .A3(n81), .Y(n75) );
  MUX21X1_HVT U85 ( .A1(n81), .A2(n82), .S0(n30), .Y(N133) );
  AND2X1_HVT U86 ( .A1(n79), .A2(n78), .Y(n82) );
  INVX0_HVT U87 ( .A(n31), .Y(n78) );
  AO21X1_HVT U88 ( .A1(n31), .A2(n80), .A3(N131), .Y(n81) );
  MUX21X1_HVT U89 ( .A1(N131), .A2(n79), .S0(n31), .Y(N132) );
  NOR2X0_HVT U90 ( .A1(n83), .A2(n32), .Y(n79) );
  AND2X1_HVT U91 ( .A1(n32), .A2(n80), .Y(N131) );
  INVX0_HVT U92 ( .A(n83), .Y(n80) );
  NAND2X0_HVT U93 ( .A1(n83), .A2(n73), .Y(N130) );
  AOI22X1_HVT U94 ( .A1(n66), .A2(n67), .A3(n84), .A4(n4), .Y(n73) );
  AO21X1_HVT U95 ( .A1(n3), .A2(n1), .A3(n85), .Y(n84) );
  INVX0_HVT U96 ( .A(n85), .Y(n67) );
  AND3X1_HVT U97 ( .A1(n27), .A2(n23), .A3(n26), .Y(n66) );
  OA21X1_HVT U98 ( .A1(n85), .A2(n74), .A3(n34), .Y(n83) );
  NAND2X0_HVT U99 ( .A1(n57), .A2(n70), .Y(n34) );
  AND3X1_HVT U100 ( .A1(n23), .A2(n3), .A3(n27), .Y(n70) );
  AND2X1_HVT U101 ( .A1(n24), .A2(n5), .Y(n57) );
  NAND3X0_HVT U102 ( .A1(n3), .A2(n1), .A3(n23), .Y(n74) );
  NAND2X0_HVT U103 ( .A1(n24), .A2(n25), .Y(n85) );
endmodule

