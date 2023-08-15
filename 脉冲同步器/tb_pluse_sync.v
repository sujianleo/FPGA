//~ `New testbench
`timescale  1ns / 1ps

module tb_pluse_sync;

// pluse_sync Parameters
parameter PERIOD_src  = 5;
parameter PERIOD_des  = 20;


// pluse_sync Inputs
reg   src_clk                              = 0 ;
reg   src_rst_n                            = 0 ;
reg   s_pluse                              = 0 ;
reg   des_clk                              = 0 ;
reg   des_rst_n                            = 0 ;

// pluse_sync Outputs
wire  des_pluse                            ;


initial
begin
    forever #(PERIOD_src/2)  src_clk=~src_clk;
end

initial
begin
    forever #(PERIOD_des/2)  des_clk=~des_clk;
end

initial
begin
    #(PERIOD_src*20) src_rst_n  =  1;
end

initial
begin
    #(PERIOD_des*2) des_rst_n  =  1;
end

pluse_sync  u_pluse_sync (
    .src_clk                 ( src_clk     ),
    .src_rst_n               ( src_rst_n   ),
    .s_pluse                 ( s_pluse     ),
    .des_clk                 ( des_clk     ),
    .des_rst_n               ( des_rst_n   ),

    .des_pluse               ( des_pluse   )
);

initial
begin
    #(PERIOD_src*20) ;
    s_pluse = 1;
    #(PERIOD_src*1) ;
    s_pluse = 0;
    #(PERIOD_src*16) ;
    s_pluse = 1;
    #(PERIOD_src*1) ;
    s_pluse = 0;

    
end

endmodule