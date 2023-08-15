`timescale 1ns / 1ps

module pluse_sync(
          input src_clk,
          input src_rst_n,
          input s_pluse,
          input des_clk,
          input des_rst_n,
          output des_pluse
);
                                    

reg 	src_pluse;

always @ (posedge src_clk or negedge src_rst_n)
    if(!src_rst_n)
        src_pluse <= 1'b0;
    else if(s_pluse)
        //在检测到脉冲时候将脉冲转换成另外一个信号的电平
        src_pluse <= ~src_pluse;
    else 
        //防止latch
        src_pluse <= src_pluse;
        
reg		 d_reg1,d_reg2;

always @ (posedge des_clk or negedge des_rst_n)
    if(!des_rst_n)
        {d_reg1,d_reg2} <= 2'b00;
    else
        {d_reg1,d_reg2} <= {src_pluse,d_reg1};


// assign des_pluse = (d_reg1 != d_reg2) ? 1'b1:1'b0;
assign des_pluse = d_reg1 ^ d_reg2 ;
// assign des_pluse = d_reg1 & ~d_reg2 ;

endmodule
