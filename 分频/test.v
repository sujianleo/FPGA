`timescale 1ns/1ps

module test ;
   reg          clk_100mhz ;
   reg          rstn ;

   initial begin
      clk_100mhz  = 0 ;
      rstn        = 0 ;
      #11 rstn    = 1 ;
   end
   always #(5)  clk_100mhz  = ~clk_100mhz ;

   wire         clk_div2, clk_div4, clk_div10;
   even_divisor u_even_divisor(
    .rstn               (rstn),
    .clk                (clk_100mhz),
    .clk_div2           (clk_div2),
    .clk_div4           (clk_div4),
    .clk_div10          (clk_div10)
    );

   wire         clk_div9_or;
   odo_div_or u_odo_or(
    .rstn               (rstn),
    .clk                (clk_100mhz),
    .clk_div9           (clk_div9_or)
    );

   wire         clk_div9_and;
   odo_div_and u_odo_and(
    .rstn               (rstn),
    .clk                (clk_100mhz),
    .clk_div9           (clk_div9_and)
    );

   wire         clk_div3p5;
   half_divisor u_clk_half(
    .rstn               (rstn),
    .clk                (clk_100mhz),
    .clk_div3p5         (clk_div3p5)
    );

   wire         clk_frac;
   frac_divisor u_clk_frac(
    .rstn               (rstn),
    .clk                (clk_100mhz),
    .clk_frac           (clk_frac)
    );

   initial begin
      forever begin
         #100;
         if ($time >= 10000)  $finish ;
      end
   end

endmodule
