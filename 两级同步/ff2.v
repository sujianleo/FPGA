`timescale 1ns/1ps

module ff2 (
    input clk,
    input rst_n,
    input a,
    output a_posedge,
    output a_negedge,
    output a_bothedge

);

reg a_f,a_ff;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        {a_f,a_ff} <= 2'b0;
    end
    else
        {a_f,a_ff} <= {a,a_f};
end

assign a_posedge = (~a_f) && (a_ff);
assign a_negedge = (a_f) && (~a_ff);
assign a_bothedge = a_f ^ a_ff;



endmodule