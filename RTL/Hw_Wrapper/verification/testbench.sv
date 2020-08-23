`include "interface2.sv"
`include "randomization.sv"
module automatic test_top;
  bit clk;
  bit rst;
 
  //clock generation
  always #5 clk = ~clk;
  
  //reset Generation
  initial begin
    rst = 1;
    #40 rst =0;
  end
    wrapper_intf intf(clk , rst);
   Hw_wrapper DUT (
    
   .clk(intf.clk),
   .go(intf.go),
   .rst(intf.rst),
   .master_key(intf.master_key),
   .account(intf.account),
   .password(intf.password),
   .done(intf.done),
   .password_enc(intf.password_enc),
   .boot_done_signal(intf.boot_done_signal)
   );


  
  //Testcase instance
  test t1(intf);
  
  //DUT instance

 
   initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end

      
    endmodule