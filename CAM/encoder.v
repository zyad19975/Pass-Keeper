
`timescale 1ns / 1ps

/*
 * Priority encoder module the parameter LSB_PRIORITY is used to identfy the priority of the least signifcal bit 
   so for example if LSB_PRIORITY is low as the default value and input is "1001" the output will be = "1000" and "11"
 */
module encoder #
(
    parameter WIDTH = 4,
    // LSB priority: "LOW", "HIGH"
    parameter LSB_PRIORITY = "LOW"
)
(
    input  wire [WIDTH-1:0]         input_unencoded,
//    input  wire                     start,
    output wire                     output_valid,
    output wire [$clog2(WIDTH)-1:0] output_encoded
);

// power-of-two width
localparam W1 = 2**$clog2(WIDTH);
localparam W2 = W1/2;

//wire [$clog2(WIDTH)-1:0] out;
/*
this part is recursive part 
*/

generate

    if (WIDTH == 1) begin
        // one input
        assign output_valid = input_unencoded;
        assign output_encoded = 0;
    end else if (WIDTH == 2) begin
        // two inputs - just an OR gate
        assign output_valid = |input_unencoded;
        if (LSB_PRIORITY == "LOW") begin
            assign output_encoded = input_unencoded[1];
        end else begin
            assign output_encoded = ~input_unencoded[0];
        end
    end else begin
        // more than two inputs - split into two parts and recurse
        // also pad input to correct power-of-two width
        wire [$clog2(W2)-1:0] out1, out2;
        wire valid1, valid2;
        encoder #(
            .WIDTH(W2),
            .LSB_PRIORITY(LSB_PRIORITY)
        )
        encoder_inst1 (
            .input_unencoded(input_unencoded[W2-1:0]),
            .output_valid(valid1),
            .output_encoded(out1)
        );
        encoder #(
            .WIDTH(W2),
            .LSB_PRIORITY(LSB_PRIORITY)
        )
        encoder_inst2 (
            .input_unencoded({{W1-WIDTH{1'b0}}, input_unencoded[WIDTH-1:W2]}),
            .output_valid(valid2),
            .output_encoded(out2)
        );
        // multiplexer to select part
        assign output_valid = valid1 | valid2;
        if (LSB_PRIORITY == "LOW") begin
            assign output_encoded = valid2 ? {1'b1, out2} : {1'b0, out1};
        end else begin
            assign output_encoded = valid1 ? {1'b0, out1} : {1'b1, out2};
        end
    end
endgenerate
//assign output_encoded = out;
endmodule