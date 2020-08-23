class transaction;
  rand bit [127:0] account;
  rand bit [127:0] password; 
  rand bit [127:0] master_key; 
  rand bit  go; 
  rand bit [3:0] rand_account; 
  bit [127:0] password_enc;
  bit  boot_done_signal;
  bit  done;
  string a;
  string b;

 function void post_randomize();

  endfunction

  function transaction do_copy();
    transaction trans;
    trans = new();
    trans.account  = this.account;
    trans.password = this.password;
    trans.master_key = this.master_key;
    trans.go = this.go;
    trans.rand_account  = this.rand_account;
//    trans.a = string'(this.password);
  //  trans.b = string'(this.master_key);
    return trans;
  endfunction
  endclass