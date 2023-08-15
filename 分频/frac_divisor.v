module frac_divisor
  #(
   parameter            SOURCE_NUM = 76 , //cycles in source clock
   parameter            DEST_NUM   = 10  //cycles in destination clock
   )
   (
    input               rstn ,
    input               clk,
    output              clk_frac
    );

   parameter            SOURCE_DIV = SOURCE_NUM/DEST_NUM ; //7-divisor
   parameter            DEST_DIV   = SOURCE_DIV + 1; //8-divisor
   parameter            DIFF_ACC   = SOURCE_NUM - SOURCE_DIV*DEST_NUM ;


   //main counter
   reg [3:0]            cnt_end_r ;
   reg [3:0]            main_cnt ;
   reg                  clk_frac_r ;
   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
         main_cnt    <= 'b0 ;
         clk_frac_r  <= 1'b0 ;
      end
      else if (main_cnt == cnt_end_r) begin
         main_cnt    <= 'b0 ;
         clk_frac_r  <= 1'b1 ;
      end
      else begin
         main_cnt    <= main_cnt + 1'b1 ;
         clk_frac_r  <= 1'b0 ;
      end
   end
   assign       clk_frac        = clk_frac_r ;
   wire         diff_cnt_en     = main_cnt == cnt_end_r ;

   //difference counter
   reg [4:0]            diff_cnt_r ;
   wire [4:0]           diff_cnt = diff_cnt_r >= DEST_NUM ?
                                   diff_cnt_r -10 + DIFF_ACC
                                   : diff_cnt_r + DIFF_ACC ;
   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
         diff_cnt_r <= 0 ;
      end
      else if (diff_cnt_en) begin
         diff_cnt_r <= diff_cnt ;
      end
   end

   //counter cnt_end
   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
         cnt_end_r      <= SOURCE_DIV-1 ;
      end
      else if (diff_cnt >= 10) begin
         cnt_end_r      <= DEST_DIV-1 ;
      end
      else begin
         cnt_end_r      <= SOURCE_DIV-1 ;
      end
   end


endmodule
