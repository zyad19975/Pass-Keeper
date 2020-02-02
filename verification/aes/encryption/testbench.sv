`include "interface.sv"
`include "randomization.sv"
module automatic test_top;
   

  aes_intf intf();
  
  //Testcase instance
  test t1(intf);
  
  //DUT instance
 aes DUT (
    
   .plaintext(intf.plaintext),
   .key(intf.key),
   .cipher_text(intf.cipher_text),
   .keyout(intf.keyout)
   );
 
   initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end

      
    endmodule