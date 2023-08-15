module odo_div_or
  #(parameter DIV_CLK = 9)
   (
    input               rstn ,
    input               clk,
    output              clk_div9
    );

   //capture at negedge
   reg [3:0]            cnt ;
   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
         cnt    <= 'b0 ;
      end
      else if (cnt == DIV_CLK-1) begin
         cnt    <= 'b0 ;
      end
      else begin
         cnt    <= cnt + 1'b1 ;
      end
   end

   reg                  clkp_div9_r ;
   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
         clkp_div9_r <= 1'b0 ;
      end
      else if (cnt == (DIV_CLK>>1)-1 ) begin //when 3, low-lever at 4-8
        clkp_div9_r <= 0 ;
      end
      else if (cnt == DIV_CLK-1) begin //when 8 , high-level at 0-3
        clkp_div9_r <= 1 ;
      end
   end

   reg                  clkn_div9_r ;
   always @(negedge clk or negedge rstn) begin
      if (!rstn) begin
         clkn_div9_r <= 1'b0 ;
      end
      else if (cnt == (DIV_CLK>>1)-1 ) begin //when 3, low-lever at 4-8
        clkn_div9_r <= 0 ;
      end
      else if (cnt == DIV_CLK-1) begin //when 8 , high-level at 0-3
        clkn_div9_r <= 1 ;
      end
   end

   assign clk_div9 = clkp_div9_r | clkn_div9_r ;

endmodule
