`timescale  1ns / 1ps

module tb_ff2;

// ff2 Parameters
parameter PERIOD  = 10;


// ff2 Inputs
reg   clk                                  = 0 ;
reg   rst_n                                = 0 ;
reg   a                                    = 0 ;

// ff2 Outputs
wire  a_posedge                            ;
wire  a_negedge                            ;
wire  a_bothedge                           ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

ff2  u_ff2 (
    .clk                     ( clk          ),
    .rst_n                   ( rst_n        ),
    .a                       ( a            ),

    .a_posedge               ( a_posedge    ),
    .a_negedge               ( a_negedge    ),
    .a_bothedge              ( a_bothedge   )
);

initial
begin
    #(PERIOD*2);
    a = 1;
    #(PERIOD*2);
    a = 0;
end

endmodule