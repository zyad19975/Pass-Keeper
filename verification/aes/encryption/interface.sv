interface aes_intf();
  logic [127:0] plaintext;
  logic [127:0] key;
  logic [127:0] cipher_text;
  logic [127:0] keyout;
  



    modport  DRIVER (
    output plaintext,
    output key,
    input cipher_text,
    input  keyout
  );
    
endinterface