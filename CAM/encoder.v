
`timescale 1ns / 1ps

module encoder #
(
    parameter WIDTH = 4

)
(
    input clk,
    input  wire [WIDTH-1:0]         input_unencoded,
//    input  wire                     start,
    output wire                     output_valid,
    output reg [$clog2(WIDTH)-1:0] output_encoded
);
wire  [(WIDTH/2)-1:0] encoded;
wire  [(WIDTH/2)-1:0] out;


generate
genvar enc_slice; // i moved this here
for (enc_slice = 0; enc_slice < WIDTH; enc_slice = enc_slice + 2) begin : slice
        
        encoder_2_1 enc_inst
        (
            .input_unencoded(input_unencoded[(enc_slice+1):enc_slice]),
            .output_valid(encoded[enc_slice/2]),
            .output_encoded(out[enc_slice/2])
        );
end
endgenerate
integer i;
assign output_valid =|encoded;

always@(posedge clk) begin
for (i =0 ; i < (WIDTH/2)  ;i = i+1 ) begin
    if (encoded[i] == 1) begin
        if (out[i] == 1) begin
             output_encoded <= (i*2)+1;
        end else begin
             output_encoded <= (i*2);
        end
    end
end
end
endmodule
