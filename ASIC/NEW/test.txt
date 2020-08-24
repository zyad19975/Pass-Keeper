module test();
reg [128:0] plain,key;
reg clk,rs,start;
wire [128:0] cipher;
wire ready;
inv_aes aes_test(plain , key, clk,rs, start,cipher,ready);
initial
begin
clk =0;
rs=1;
#100
rs=0;
#100
plain=0;
key=0;
start=1;
wait(ready==1);
$display("%h",cipher);
#100;
plain=128'hffffffff00000000;
key=0;
start=1;
wait(ready==1)
$display("%h",cipher);

end
always
begin
#20clk = ~clk;
end

 

`ifdef TRACE_VPD
initial begin : vpd_trace
`define TRACE_NAME "passkeep.vpd"
$vcdplusfile(`TRACE_NAME);
$vcdplusmemon;// (0, `TRACE_NAME);

$vcdpluson();


end
`endif


endmodule
