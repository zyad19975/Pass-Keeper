
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
         n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17,
         n18, n19, n20, n21, n22, n28, n33, n34, n35, n36, n37, n38, n39, n40,
         n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54,
         n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68,
         n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82,
         n83, n84, n87, n88, boot_load_reg, flash_acc_reg, n94;
  wire   [4:0] nextstate;
  assign pass_enc_reg = boot_load_reg;
  assign flash_pass_reg = flash_acc_reg;

  LATCHX1_HVT \address_out_reg[0]  ( .CLK(N130), .D(N131), .Q(address_out[0]), 
        .QN(n32) );
  LATCHX1_HVT \address_out_reg[1]  ( .CLK(N130), .D(N132), .Q(address_out[1]), 
        .QN(n31) );
  LATCHX1_HVT \nextstate_reg[1]  ( .CLK(N139), .D(N141), .Q(nextstate[1]) );
  DFFARX1_HVT \currentstate_reg[1]  ( .D(nextstate[1]), .CLK(clk), .RSTB(n94), 
        .Q(n3), .QN(n26) );
  LATCHX1_HVT \nextstate_reg[4]  ( .CLK(N139), .D(N144), .Q(nextstate[4]) );
  DFFARX1_HVT \currentstate_reg[4]  ( .D(nextstate[4]), .CLK(clk), .RSTB(n94), 
        .Q(n4), .QN(n23) );
  LATCHX1_HVT \address_out_reg[2]  ( .CLK(N130), .D(N133), .Q(address_out[2]), 
        .QN(n30) );
  LATCHX1_HVT \address_out_reg[3]  ( .CLK(N130), .D(N134), .Q(address_out[3]), 
        .QN(n29) );
  LATCHX1_HVT \nextstate_reg[0]  ( .CLK(N139), .D(N140), .Q(nextstate[0]) );
  DFFARX1_HVT \currentstate_reg[0]  ( .D(nextstate[0]), .CLK(clk), .RSTB(n94), 
        .Q(n1), .QN(n27) );
  LATCHX1_HVT \nextstate_reg[3]  ( .CLK(N139), .D(N143), .Q(nextstate[3]) );
  DFFARX1_HVT \currentstate_reg[3]  ( .D(nextstate[3]), .CLK(clk), .RSTB(n94), 
        .Q(n2), .QN(n24) );
  LATCHX1_HVT \nextstate_reg[2]  ( .CLK(N139), .D(N142), .Q(nextstate[2]) );
  DFFARX1_HVT \currentstate_reg[2]  ( .D(nextstate[2]), .CLK(clk), .RSTB(n94), 
        .Q(n5), .QN(n25) );
  LATCHX1_HVT boot_done_signal_reg ( .CLK(N138), .D(n88), .Q(boot_done_signal)
         );
  LATCHX1_HVT cam_start_reg ( .CLK(N136), .D(n87), .Q(cam_start) );
  LATCHX1_HVT done_reg ( .CLK(N137), .D(out_reg), .Q(done) );
  NAND4X1_HVT U3 ( .A1(n49), .A2(n50), .A3(n28), .A4(n51), .Y(N139) );
  NAND2X0_HVT U4 ( .A1(n6), .A2(n7), .Y(new_old_pass_sel) );
  INVX0_HVT U5 ( .A(n8), .Y(out_reg) );
  INVX0_HVT U6 ( .A(n9), .Y(flash_write_en) );
  INVX0_HVT U7 ( .A(n10), .Y(n87) );
  INVX0_HVT U8 ( .A(n11), .Y(n88) );
  INVX0_HVT U9 ( .A(n12), .Y(boot_load_reg) );
  INVX0_HVT U10 ( .A(n13), .Y(flash_or_acc_sel) );
  INVX0_HVT U11 ( .A(n14), .Y(local_master_sel) );
  INVX0_HVT U12 ( .A(n15), .Y(flash_acc_reg) );
  INVX0_HVT U13 ( .A(rst), .Y(n94) );
  NAND2X0_HVT U14 ( .A1(n14), .A2(n16), .Y(local_master_reg) );
  NAND2X0_HVT U15 ( .A1(n13), .A2(n17), .Y(flash_or_acc_reg) );
  NAND4X0_HVT U16 ( .A1(n11), .A2(n18), .A3(n19), .A4(n20), .Y(N142) );
  OA221X1_HVT U17 ( .A1(match), .A2(n10), .A3(n21), .A4(n22), .A5(n28), .Y(n20) );
  NAND4X0_HVT U18 ( .A1(n33), .A2(n12), .A3(n34), .A4(n35), .Y(N141) );
  AND4X1_HVT U19 ( .A1(n7), .A2(n36), .A3(n17), .A4(n37), .Y(n35) );
  INVX0_HVT U20 ( .A(cam_write_en), .Y(n17) );
  NAND2X0_HVT U21 ( .A1(n38), .A2(n9), .Y(cam_write_en) );
  OA21X1_HVT U22 ( .A1(n39), .A2(n22), .A3(n19), .Y(n34) );
  INVX0_HVT U23 ( .A(n21), .Y(n39) );
  AO22X1_HVT U24 ( .A1(n29), .A2(max_add[3]), .A3(n40), .A4(n41), .Y(n21) );
  OR2X1_HVT U25 ( .A1(n29), .A2(max_add[3]), .Y(n41) );
  AO22X1_HVT U26 ( .A1(max_add[2]), .A2(n42), .A3(n30), .A4(n43), .Y(n40) );
  OR2X1_HVT U27 ( .A1(n42), .A2(max_add[2]), .Y(n43) );
  AO22X1_HVT U28 ( .A1(n31), .A2(max_add[1]), .A3(n44), .A4(n32), .Y(n42) );
  OA21X1_HVT U29 ( .A1(max_add[1]), .A2(n31), .A3(max_add[0]), .Y(n44) );
  NAND4X0_HVT U30 ( .A1(n8), .A2(n6), .A3(n45), .A4(n46), .Y(N140) );
  AND4X1_HVT U31 ( .A1(n19), .A2(n38), .A3(n11), .A4(n10), .Y(n46) );
  AND3X1_HVT U32 ( .A1(n36), .A2(n47), .A3(n48), .Y(n45) );
  INVX0_HVT U33 ( .A(N130), .Y(n47) );
  AOI221X1_HVT U34 ( .A1(go), .A2(n52), .A3(enc_done), .A4(n53), .A5(n54), .Y(
        n51) );
  NAND2X0_HVT U35 ( .A1(n7), .A2(n55), .Y(n54) );
  INVX0_HVT U36 ( .A(n19), .Y(n52) );
  NAND2X0_HVT U37 ( .A1(n56), .A2(n57), .Y(n19) );
  AND3X1_HVT U38 ( .A1(n8), .A2(n16), .A3(n9), .Y(n28) );
  NAND2X0_HVT U39 ( .A1(dec_done), .A2(n58), .Y(n50) );
  INVX0_HVT U40 ( .A(n6), .Y(n58) );
  NAND4X0_HVT U41 ( .A1(n59), .A2(n60), .A3(n55), .A4(n61), .Y(N137) );
  AND2X1_HVT U42 ( .A1(n9), .A2(n8), .Y(n61) );
  NAND3X0_HVT U43 ( .A1(n62), .A2(n1), .A3(n26), .Y(n8) );
  NAND3X0_HVT U44 ( .A1(n62), .A2(n27), .A3(n26), .Y(n9) );
  INVX0_HVT U45 ( .A(N138), .Y(n55) );
  NAND3X0_HVT U46 ( .A1(n63), .A2(n11), .A3(n64), .Y(N138) );
  NAND2X0_HVT U47 ( .A1(n56), .A2(n65), .Y(n11) );
  NAND2X0_HVT U48 ( .A1(n66), .A2(n67), .Y(n63) );
  INVX0_HVT U49 ( .A(N144), .Y(n60) );
  OR2X1_HVT U50 ( .A1(n53), .A2(start_dec), .Y(N144) );
  INVX0_HVT U51 ( .A(n7), .Y(start_dec) );
  NAND2X0_HVT U52 ( .A1(n68), .A2(n69), .Y(n7) );
  NAND2X0_HVT U53 ( .A1(n15), .A2(n48), .Y(n53) );
  NAND2X0_HVT U54 ( .A1(n65), .A2(n70), .Y(n48) );
  NAND2X0_HVT U55 ( .A1(n67), .A2(n70), .Y(n15) );
  INVX0_HVT U56 ( .A(N143), .Y(n59) );
  NAND2X0_HVT U57 ( .A1(n49), .A2(n37), .Y(N143) );
  INVX0_HVT U58 ( .A(plain_reg), .Y(n37) );
  NAND2X0_HVT U59 ( .A1(n16), .A2(n6), .Y(plain_reg) );
  NAND3X0_HVT U60 ( .A1(n27), .A2(n3), .A3(n62), .Y(n6) );
  AND2X1_HVT U61 ( .A1(n66), .A2(n4), .Y(n62) );
  AND3X1_HVT U62 ( .A1(n33), .A2(n18), .A3(n71), .Y(n49) );
  INVX0_HVT U63 ( .A(start_enc), .Y(n18) );
  NAND2X0_HVT U64 ( .A1(n14), .A2(n36), .Y(start_enc) );
  NAND2X0_HVT U65 ( .A1(n69), .A2(n70), .Y(n36) );
  NAND2X0_HVT U66 ( .A1(n67), .A2(n68), .Y(n14) );
  NAND3X0_HVT U67 ( .A1(n71), .A2(n16), .A3(n64), .Y(N136) );
  AND3X1_HVT U68 ( .A1(n38), .A2(n22), .A3(n72), .Y(n64) );
  NAND2X0_HVT U69 ( .A1(n57), .A2(n66), .Y(n22) );
  NAND2X0_HVT U70 ( .A1(n66), .A2(n69), .Y(n38) );
  NAND2X0_HVT U71 ( .A1(n57), .A2(n70), .Y(n16) );
  AND2X1_HVT U72 ( .A1(n2), .A2(n5), .Y(n70) );
  AND3X1_HVT U73 ( .A1(n12), .A2(n10), .A3(n13), .Y(n71) );
  NAND2X0_HVT U74 ( .A1(n56), .A2(n67), .Y(n13) );
  INVX0_HVT U75 ( .A(n73), .Y(n67) );
  NAND2X0_HVT U76 ( .A1(n65), .A2(n68), .Y(n10) );
  NAND2X0_HVT U77 ( .A1(n57), .A2(n68), .Y(n12) );
  AND2X1_HVT U78 ( .A1(n25), .A2(n2), .Y(n68) );
  AND3X1_HVT U79 ( .A1(n23), .A2(n1), .A3(n26), .Y(n57) );
  MUX21X1_HVT U80 ( .A1(n74), .A2(n75), .S0(n29), .Y(N134) );
  AND3X1_HVT U81 ( .A1(n76), .A2(n77), .A3(n78), .Y(n75) );
  INVX0_HVT U82 ( .A(n30), .Y(n76) );
  AO21X1_HVT U83 ( .A1(n30), .A2(n79), .A3(n80), .Y(n74) );
  MUX21X1_HVT U84 ( .A1(n80), .A2(n81), .S0(n30), .Y(N133) );
  AND2X1_HVT U85 ( .A1(n78), .A2(n77), .Y(n81) );
  INVX0_HVT U86 ( .A(n31), .Y(n77) );
  AO21X1_HVT U87 ( .A1(n31), .A2(n79), .A3(N131), .Y(n80) );
  MUX21X1_HVT U88 ( .A1(N131), .A2(n78), .S0(n31), .Y(N132) );
  NOR2X0_HVT U89 ( .A1(n82), .A2(n32), .Y(n78) );
  AND2X1_HVT U90 ( .A1(n32), .A2(n79), .Y(N131) );
  INVX0_HVT U91 ( .A(n82), .Y(n79) );
  NAND2X0_HVT U92 ( .A1(n82), .A2(n72), .Y(N130) );
  AOI22X1_HVT U93 ( .A1(n65), .A2(n66), .A3(n83), .A4(n4), .Y(n72) );
  AO21X1_HVT U94 ( .A1(n3), .A2(n1), .A3(n84), .Y(n83) );
  INVX0_HVT U95 ( .A(n84), .Y(n66) );
  AND3X1_HVT U96 ( .A1(n27), .A2(n23), .A3(n26), .Y(n65) );
  OA21X1_HVT U97 ( .A1(n84), .A2(n73), .A3(n33), .Y(n82) );
  NAND2X0_HVT U98 ( .A1(n56), .A2(n69), .Y(n33) );
  AND3X1_HVT U99 ( .A1(n23), .A2(n3), .A3(n27), .Y(n69) );
  AND2X1_HVT U100 ( .A1(n24), .A2(n5), .Y(n56) );
  NAND3X0_HVT U101 ( .A1(n3), .A2(n1), .A3(n23), .Y(n73) );
  NAND2X0_HVT U102 ( .A1(n24), .A2(n25), .Y(n84) );
endmodule

