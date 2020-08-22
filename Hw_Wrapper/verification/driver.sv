
`define DRIV_IF wrapper_intf.DRIVER
import "DPI-C" function string encrypt1( string a , string b);
import "DPI-C" function string gethex( string c );
class driver;
   string enc_password_str;
  string key_str;
  string pass_str;
    string tmp;
  string tmp1;
 /* 
  string outFinal;
  int flag;
  bit[127:0] plaintest;
  bit[127:0] keytest;
  bit[127:0] plaintest;
  bit keytest;
    string tmp;
  string tmp1;
 */
  logic [127:0] account_arr[15:0];
  logic [127:0] password_arr[15:0];

  //used to count the number of transactions
  int no_transactions;
  int no_reads;
  
  //creating virtual interface handle
  virtual wrapper_intf wrapper_intf;
  
  //creating mailbox handle
  mailbox gen2driv;
 
   covergroup CG1 ;
 				 P1: coverpoint  `DRIV_IF.account;
 				 P2: coverpoint  `DRIV_IF.password;
			endgroup

  //constructor
  function new(virtual wrapper_intf wrapper_intf,mailbox gen2driv);
    //getting the interface
    this.wrapper_intf = wrapper_intf;
    //getting the mailbox handles from  environment 
    this.gen2driv = gen2driv;
  endfunction
 
    task reset;
     // $display("[ DRIVER ] ----- 111111111-----");
      wait(wrapper_intf.rst);
    $display("[ DRIVER ] ----- Reset Started -----");
    `DRIV_IF.account <= 0;
    `DRIV_IF.password <= 0;
    `DRIV_IF.master_key <= 0;
    `DRIV_IF.go <= 0;
      wait(!wrapper_intf.rst);
    $display("[ DRIVER ] ----- Reset Ended   -----");
  endtask
  

  
  
  task drive;
  
      transaction trans;
      gen2driv.get(trans);
  
     
      wait (`DRIV_IF.boot_done_signal == 1) 
    	//@(posedge wrapper_intf.clk);

           $display("--------- [DRIVER-TRANSFER: %0d] ---------",no_transactions);
     		`DRIV_IF.go <= 0;
          #20
            `DRIV_IF.account <= trans.account;
      		account_arr[no_transactions] = trans.account;
            `DRIV_IF.password <= trans.password;
    password_arr[no_transactions] = trans.password;
            `DRIV_IF.master_key <= 0;
      
            `DRIV_IF.go <= 1;
        #100
        
          $display("\account = %h \password = %h \master_key = %h \go = %h ", `DRIV_IF.account,trans.password,`DRIV_IF.master_key ,trans.go);   
      

        //$display("pre_done");   
      wait (`DRIV_IF.done == 1);
       // $display("post_done");    
      wait (`DRIV_IF.done == 0);
         
    
      
      $display("-----------------------------------------");
      no_transactions++;
      
   
  endtask
  
  
  task read_enc;
    
      transaction trans;
      gen2driv.get(trans);
   	@(posedge wrapper_intf.clk);

           $display("--------- [DRIVER-TRANSFER: %0d] ---------",no_reads);
     		`DRIV_IF.go <= 1;
       `DRIV_IF.account <= account_arr[trans.rand_account];
            `DRIV_IF.master_key <= trans.master_key;
    #10
     `DRIV_IF.go <= 1;
    $display("account = %h \master_key = %h ",account_arr[trans.rand_account], trans.master_key );   
      #5
           

      wait (`DRIV_IF.done == 1);

      wait (`DRIV_IF.done == 0);
        wait (`DRIV_IF.done == 1);

      wait (`DRIV_IF.done == 0);
          trans.password_enc = `DRIV_IF.password_enc;
      #10
          $display("\password_enc = %h ",`DRIV_IF.password_enc );
    
   // $display("\password_NORMAL = %h ",password_arr[trans.rand_account] );
      pass_str= string'(password_arr[trans.rand_account]);
      key_str = string'(trans.master_key);
      //enc_password_str = decrypt1(key_str , pass_str);
    
    enc_password_str =  encrypt1(pass_str,key_str);


    tmp = string'(`DRIV_IF.password_enc);

    tmp1 = gethex(tmp);
    
    assert(enc_password_str == tmp1) $display("Equal"); else $display("Error, Not Equal");
    
      no_reads++;
    
    
  endtask
    
  //
  task main;
  
    $display("main started " );
       
          while(no_transactions < 16)
            begin

            drive();

              end
              
  // $display ("CG1 Coverage = %.2f%%", cg1_inst.get_coverage());
  


 // $display ("CG1 Coverage = %.2f%%", cg1_inst.get_coverage());

       
        //  $display("main ended " );

  endtask
   task main2;

     while(no_reads < 5)
            read_enc();
       
    

  endtask
        
        
endclass