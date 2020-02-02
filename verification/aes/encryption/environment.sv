  
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"

class environment ;
  generator gen;
  driver    driv;
  

  mailbox gen2driv;
  
  event gen_ended;
  
   virtual aes_intf aes_vif;
  
  function new(virtual aes_intf aes_vif);
    
    //creating the mailbox (Same handle will be shared across generator and driver)
    this.aes_vif = aes_vif;
    gen2driv = new();

  
    
    //creating generator and driver
    gen  = new(gen2driv,gen_ended);
    driv = new(aes_vif,gen2driv);
  endfunction
  
/*   task pre_test();
    driv.reset();
  endtask
  */
  
   task test();
     fork
    
    gen.main();
    driv.main();
     join_any
     
  endtask
  
  task post_test();
    wait(gen_ended.triggered);
     wait(gen.repeat_count == driv.no_transactions);
  endtask  
  
  //run task
  task run;
   // pre_test();
    test();
    post_test();
    $finish;
  endtask
  
endclass
