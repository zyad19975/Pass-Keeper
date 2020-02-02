`define DRIV_IF aes_vif.DRIVER
import "DPI-C" function string encrypt1( string a , string b);
import "DPI-C" function string gethex( string c );
class driver;
string outFinal;
  int flag;
  bit[127:0] plaintest;
  bit[127:0] keytest;


  string tmp;
  string tmp1;
  //used to count the number of transactions
  int no_transactions;
  
  //creating virtual interface handle
  virtual aes_intf aes_vif;
  
  //creating mailbox handle
  mailbox gen2driv;
  
  //constructor
  function new(virtual aes_intf aes_vif,mailbox gen2driv);
    //getting the interface
    this.aes_vif = aes_vif;
    //getting the mailbox handles from  environment 
    this.gen2driv = gen2driv;
  endfunction
 
  task drive;
      transaction trans;
      gen2driv.get(trans);
  
     

    
      flag = 0;
    
    plaintest = trans.plaintext;
    for(int i = 0 ; i < 16 ; i++)begin

      if(plaintest & 8'b11111111) begin
      end
      else begin
        flag = 1;
      end
      plaintest >>= 8 ;
      
    end
   
     keytest = trans.key;
    for(int i = 0 ; i < 16 ; i++)begin

      if(keytest & 8'b11111111) begin
      end
      else begin
        flag = 1;
      end
      keytest >>= 8 ;
      
    end
    if ( flag == 1)begin

      end
        else begin
           $display("--------- [DRIVER-TRANSFER: %0d] ---------",no_transactions);
            `DRIV_IF.plaintext <= trans.plaintext;
            `DRIV_IF.key <= trans.key;
    $display("\plaintext = %h \key = %h",trans.plaintext,trans.key);

#100

  
            trans.cipher_text = `DRIV_IF.cipher_text;
            trans.keyout <= `DRIV_IF.keyout;
    
          $display("\ciphertext = %h \keyout = %h",`DRIV_IF.cipher_text,`DRIV_IF.keyout);
    #100

 outFinal =  encrypt1(trans.a,trans.b);


    tmp = string'(trans.cipher_text);

    tmp1 = gethex(tmp);


    if(outFinal == tmp1)begin
      
      $display("equal");
    end
      else begin
        $display("notequal");
      end

    
      
      $display("-----------------------------------------");
      no_transactions++;
        end
  endtask
  
    
  //
  task main;
    forever begin
      
        begin
          forever
            drive();
        end
    
    end
  endtask
        
        
endclass