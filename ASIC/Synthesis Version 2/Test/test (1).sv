`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


/*module Test( Hard_interface.test te);

	
initial      
    begin
	   
       #10
       te.rst = 1;
       te.go  = 1;
       
	   #10 //rest = 1 , so the account wont be saved
       te.account    = 128'h 34B756E672046755468617473206D792;
       te.password   = 128'h 6F204F6E65204E6547796E652054776F;
       te.master_key = 128'h 2054776F6E65204E54776F204F696E65;
	   
       #10 //rest = 1 , so the account wont be saved
       te.go  = 0;
       te.account    = 128'h 34B756E672046755468617473206D792;
       te.password   = 128'h 6F204F6E65204E6547796E652054776F;
       te.master_key = 128'h 2054776F6E65204E54776F204F696E65;
               
       
       #10 // the start signal isn't ready (go = 0) , so the account wont be saved 
       te.go  = 0; 
	   #3
       te.rst = 0 ;
	 //  wait(te.boot_done ==1);	 
	   
	   
       te.account    = 128'h 34B756E672046755468617473206D792;
       te.password   = 128'h 6F204F6E65204E6547796E652054776F;
       te.master_key = 128'h 2054776F6E65204E54776F204F696E65;
             
       #10  // store the first account
       te.go = 1;
       te.account    = 128'h 5468617473206D79204B756E67204675;
       te.password   = 128'h 65686689abc365204E696E652054776F;
       te.master_key = 128'h 54776F204F696E652054776F6E65204E;
      
       wait(te.done == 1 ); // store the second account
	   
	  
	   wait(te.done == 0 );	
	   te.go = 0;	// tell  govanii 
	   
	 
       te.account    = 128'h 732792047204B54686106D6774756E65;
       te.password   = 128'h 4F645E65200E54776F220696E654776F;
       te.master_key = 128'h E775254776F204F66F6E69604E652054;
       te.go = 1;      
       wait(te.done == 1 );// store the third account 
	   
	   wait(te.done == 0 );	
	   te.go = 0;	// tell  govanii  
	   #100
	   te.go = 1;	
       te.account    = 128'h 52792047204B4686106D677374756E65;
       te.password   = 128'h 96E65200E5544F645E67764776F2206F;
       te.master_key = 128'h 7752547E76F204E65205404F66F6E696;
       
       wait(te.done == 1 ); // store the fourth account with the same password of third account	   
	   
	   wait(te.done == 0 );
	   te.go = 0;	
	   #50	
       te.account    = 128'h 6861567920475273747204B406D67E65;
       te.password   = 128'h 96E65200E5544F645E67764776F2206F;
       te.master_key = 128'h 7752547E76F204E65205404F66F6E696;
        te.go = 1;      
       wait(te.done == 1 ); //get the password of the first account  
	   	
	   wait(te.done == 0 );	 
	   
	   te.go = 0;	
	   #500
	   
       te.account    = 128'h 5468617473206D79204B756E67204675;
       te.master_key = 128'h 54776F204F696E652054776F6E65204E;
	 	te.go = 1;
       
       wait(te.done == 1 ); //get the password of the third account  
	   wait(te.done == 0 );
	   te.go = 0;
	   #50
       te.account    = 128'h 52792047204B4686106D677374756E65;
       te.master_key = 128'h 7752547E76F204E65205404F66F6E696;
       te.go = 1;
	  wait(te.done == 1 ); //get the password of the second account	
	 
	  wait(te.done == 0 );

	  te.go = 0;	
	  #50
	  	
       te.account    = 128'h 732792047204B54686106D6774756E65;
       te.master_key = 128'h E775254776F204F66F6E69604E652054;
       te.go = 1;  
      
       wait(te.done == 1 ); //  the second account with differance password	
	   
	   wait(te.done == 0 );
	   te.go = 0;	 
	   	#50
	   	
       te.account    = 128'h 6861567920475273747204B406D67E65;
       te.master_key = 128'h 7752547E76F204E65205404F66F6E696;	
	   te.go = 1;
	   wait(te.done == 1 ); //get the password of the second account
	   wait(te.done == 0 );
	   te.go = 0;	
	 
	   #250
       te.account    = 128'h 732792047204B54686106D6774756E65;
       te.master_key = 128'h E775254776F204F66F6E69604E652054;
	   te.go=1;
	   	wait(te.done == 1 ); //get the password of the second account
	   wait(te.done == 0 );
	   #25
	   te.go=0;
	   ////////////////////////////////////
	   
	   ////////////////////////////////////
    end

endmodule



module monitor(Hard_interface.monit mo);
       logic [127:0] acount_arr[15:0][2] ;
       int fd;
       logic [127:0] ch;
	   logic se;
       

       reg [0:3] max;
       string cppS , HWS ;
	   
       initial
       begin        
           max   = 0;  
		   se=0;
       end 
      
		   
       always @( mo.go , mo.rst)
		   begin  
			      
				  if((!mo.done &&!mo.go) | mo.rst)
					  begin
					   $display("sorry ,the system isn't ready");
				       if(!mo.go)
					   	  $display("(go = 0)\n");
				       if(mo.rst)
					   	  $display("(rest = 1) \n");
					  end
					  
                   else if( mo.go && !mo.rst )
                   begin					   
                       ch = found_pass(mo.account);
					   $display("account = %h", mo.account);
                  
                       if(ch != -1 )
                          begin		 
							  cppS  = check(mo.master_key , ch); 
							    $display("Master_Key=%h",mo.master_key);
							   wait(mo.done==1);	
							   wait(mo.done==0);
							   $display("password = %h \n", ch); 
                               HWS   =  $sformatf("%h",mo.password_enc);
                              
							   $display("cppS = %s" ,cppS);
							   $display("HWS  = %s" , HWS);
                               if(cppS == HWS)
                                  $display("Old account , Successfully fetched \n");
                               else
                                  $display("Old account , There is something wrong \n");
                           end
                       
                       else
                         begin
						 $display("password = %h \n", mo.password);
                         acount_arr [max][0] =  mo.account ;
                         acount_arr [max][1] =  mo.password ;
                         max = max +1 ;
                         $display("New account \n ");
                         end
                  end 
				  
				 
               end 
			   
       
       function string check(input logic [127:0] Key,plain);
             string s,line,Key_str,Plain_str;	
             int fd,sy;  
             Key_str=$sformatf("%h",Key);	   // convert hex logic to string 
             Plain_str= $sformatf("%h",plain);
             s = {"C:/Users/Emad/source/repos/Project5/Debug/Project5.exe ",Key_str," ",Plain_str};	
             sy = $system(s); // run consule application 
             fd = $fopen ("example.txt", "r");   // open file  
             sy=$fgets(line, fd); 	// read line from file 
             $fclose(fd);		  // closed file 
             return line;	 // return encryption result 
	   endfunction  	  
	 
	   function logic[127:0] found_pass (input logic [127:0] acount) ;
             foreach(acount_arr[i])
                begin 
                    if (acount == acount_arr[i][0])
                        begin 
                            return acount_arr[i][1];
                        end	
			    end	
			return -1;
	   endfunction
	 



endmodule


module top(); 
	
    bit clk ;
	logic go , rst;
    
    always
        begin
         #5 clk = ~clk ; 
        end
        
    Hard_interface  Hw_Int(clk) ; 
    
    Hw_wrapper HWER( 
                        .clk(Hw_Int.clk),
                        .go(Hw_Int.go),
                        .rst(Hw_Int.rst),
                        .master_key(Hw_Int.master_key),
                        .account(Hw_Int.account),
                        .password(Hw_Int.password),
                        .done(Hw_Int.done),
                        .password_enc(Hw_Int.password_enc),
						.boot_done_signal(Hw_Int.boot_done)
                    ); 
                               
    Test tes(Hw_Int);
   monitor mon(Hw_Int);
	
endmodule*/
			
 

module test_bench(); 



	    reg clk;
    reg go;
    reg rst;
    reg [127:0] master_key;
    reg [127:0] account;
    reg [127:0] password;
    wire[127:0] password_enc;
    wire done;
    

    Hw_wrapper hw(
    .clk(clk),
    .go(go),
    .rst(rst),
    .master_key(master_key),
    .account(account),
    .password(password),
    .done(done),
    .password_enc(password_enc)
    );


    always 
    begin
       #5 
       clk = ~clk; 
	   
    end
    
   initial
     begin
       
	   clk=0;  
	   
	   #10
       rst = 1;
       go  = 1;	
	   
       	
	   #10 //rest = 1 , so the account wont be saved
       account    = 128'h 34B756E672046755468617473206D792;
       password   = 128'h 6F204F6E65204E6547796E652054776F;
       master_key = 128'h 2054776F6E65204E54776F204F696E65;
	   
       #10 //rest = 1 , so the account wont be saved
       go  = 0;
       account    = 128'h 34B756E672046755468617473206D792;
       password   = 128'h 6F204F6E65204E6547796E652054776F;
       master_key = 128'h 2054776F6E65204E54776F204F696E65;
               
       
       #10 // the start signal isn't ready (go = 0) , so the account wont be saved 
       go  = 0;
       rst = 0;
       account    = 128'h 34B756E672046755468617473206D792;
       password   = 128'h 6F204F6E65204E6547796E652054776F;
       master_key = 128'h 2054776F6E65204E54776F204F696E65;
             
       #10  // store the first account
       go = 1;
       account    = 128'h 5468617473206D79204B756E67204675;
       password   = 128'h 65686689abc365204E696E652054776F;
       master_key = 128'h 54776F204F696E652054776F6E65204E;	   
	   
       wait(done == 1 ); // store the second account
	   wait(done == 0 ); 
	   go  = 0;
	   go  = 1;
       account    = 128'h 732792047204B54686106D6774756E65;
       password   = 128'h 4F645E65200E54776F220696E654776F;
       master_key = 128'h E775254776F204F66F6E69604E652054;
    
	   
       wait(done == 1 );// store the third account 
	   wait(done == 0 );  
	   go  = 0;
	   go  = 1;
       account    = 128'h 52792047204B4686106D677374756E65;
       password   = 128'h 96E65200E5544F645E67764776F2206F;
       master_key = 128'h 7752547E76F204E65205404F66F6E696;

	   
       wait(done == 1 ); // store the fourth account with the same password of third account	
	   wait(done == 0 );  
	   go  = 0;
	   go  = 1;
       account    = 128'h 6861567920475273747204B406D67E65;
       password   = 128'h 96E65200E5544F645E67764776F2206F;
       master_key = 128'h 7752547E76F204E65205404F66F6E696;
   
	   
       wait(done == 1 ); //get the password of the first account 
	   wait(done == 0 ); 
	   go  = 0;
	   go  = 1;
       account    = 128'h 5468617473206D79204B756E67204675;
       master_key = 128'h 54776F204F696E652054776F6E65204E;
	   
       
       wait(done == 1 ); //get the password of the third account  
	   wait(done == 0 );   
	   $display("account=%h",account);
	   $display("master_key=%h",master_key);
	   $display("expected pass_en = 4ce628501a2eefd808ce6f568b4ffe6f \n");
	   $display("HWS  = %h" , password_enc);
	   go  = 0;
	   go  = 1;	 
	   
       account    = 128'h 52792047204B4686106D677374756E65;
       master_key = 128'h 7752547E76F204E65205404F66F6E696;	 
	   wait(done == 1 ); //get the password of the third account  
	   wait(done == 0 );  
	   
       $display("account=%h",account);
	   $display("master_key=%h",master_key);
	   $display("expected pass_en = 1972f0b02b2017c8a568fab814f45c12 ");
	   $display("HWS  = %h" , password_enc);
	   go  = 0;
	   #150	// there is an error 
	   go  = 1;
       account    = 128'h 732792047204B54686106D6774756E65;
       master_key = 128'h E775254776F204F66F6E69604E652054;
	   wait(done == 1 ); //get the password of the third account  
	   wait(done == 0 );
       $display("account=%h",account);
	   $display("master_key=%h",master_key);
	   $display("expected pass_en = 83733e0f54b101fe4ece96b042d190bf \n");
	   $display("HWS  = %h" , password_enc);
       go  = 0;
              
     end




endmodule