
`include "environment.sv"

program test(wrapper_intf intf);
   driver    driv;
  //declaring environment instance
  environment env;
  bit y ;
  covergroup CG1 @ (posedge intf.clk);
     P1: coverpoint intf.account;
    P2: coverpoint intf.password;
    P3: coverpoint intf.go;

 				
			endgroup
CG1 cg1_inst;
  initial begin
    //creating environment
    env = new(intf);
      cg1_inst = new();
    //determines how many inputs i want to generate.
    env.gen.repeat_count = 16;
    env.gen2.repeat_count = 5;
    
    //calling run of env, it interns calls generator and driver main tasks.
    env.run();
     y = 1;
    #10
    y=0;
    //$display ("intffff = %d", y);
    #20
    y = 1;
    #20
    $display ("CG1 Coverage = %.2f%%", cg1_inst.get_coverage());
    env.run2();
    // $display ("CG1 Coverage = %.2f%%", cg1_inst.get_coverage());
  end
endprogram