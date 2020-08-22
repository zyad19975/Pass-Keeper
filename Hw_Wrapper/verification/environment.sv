  
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"

class environment ;
  generator gen;
  generator gen2;
  driver    driv;
  

  mailbox gen2driv;
  
  event gen_ended;
    event gen2_ended;
  
   virtual wrapper_intf wrapper_intf;
  
  function new(virtual wrapper_intf wrapper_intf);
    
    //creating the mailbox (Same handle will be shared across generator and driver)
    this.wrapper_intf = wrapper_intf;
    gen2driv = new();

  
    
    //creating generator and driver
    gen  = new(gen2driv,gen_ended);
    gen2  = new(gen2driv,gen2_ended);
    driv = new(wrapper_intf,gen2driv);
  endfunction
  
/*   task pre_test();
    driv.reset();
  endtask
  */
    task pre_test();
    driv.reset();
  endtask
  
  
   task test();
     //$display("pre_fork " );
   begin
      // $display("post_fork " );
    gen.main();
    driv.main();
       //$display("test " );
  
   end
     
  endtask
  
  task post_test();
    //$display("post_test1 " );
    wait(gen_ended.triggered);
     wait(gen.repeat_count == driv.no_transactions);
    //$display("post_test2 " );
  endtask 
  
   task test2();
     begin
    gen2.main();
    driv.main2();
      // $display("test2 " );
     end
     
  endtask
  
  task post_test2();
   // $display("post_test3 " );
    wait(gen2_ended.triggered);
    wait(gen2.repeat_count == driv.no_reads);
    //$display("post_test4 " );
  endtask  
  
  //run task
  task run;
   pre_test();
   test();
   //post_test();
 
 // $stop;
  endtask
  task run2;
    test2();
    //post_test2();
   $finish;
  endtask
endclass
