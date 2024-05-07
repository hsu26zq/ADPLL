//--------------------------------//
//- Advanced Digital IC Design    //
//                                //
//- Exercise: Frequency Divider   //
//--------------------------------//

timescale 1ns/1ps
module FREQ_DIV(reset, clk, MO ,M1, M2, out_clk);

input
input
input
output

reg [2:0] counter = 2'd0;
reg out_clk = 1'b0;
reg [2:0] M = 0;
always@* begin M = {MO, M1, M2}; end

always@(posedge clk) begin
if(!reset) begin
if(counter == 3'd0) begin
out_clk <= 1;
counter <= M - 1;

else if(counter == M - 1) begin
out_clk <= 0;
counter <= counter - 1;

else begin
counter <= counter - 1;

reset;|
clk;
MO, M1, M2;
out_clk;

end

end

end

end

else begin
out_clk <= 0;
counter <= 0;

end

end

always@(posedge clk or negedge clk) begin
if(M == 3'd1 && !reset) out_clk <= clk;

end

endmodule