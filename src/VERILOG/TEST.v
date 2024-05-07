timescale 1ns/1ps
module TEST(REF_CLOCK, MO, M1, M2, RESET, INV_RESET, OUT_CLK, LOCK);
output REF_CLOCK, RESET, INV_RESET;
output MO, M1, M2;
input OUT_CLK;
input LOCK;

reg REF_CLOCK, RESET, INV_RESET;
reg MO, M1, M2;
real frequency;

//TOP TOP(.REF_CLOCK(REF_CLOCK), .M(M), .RESET(RESET), .OUT_CLK(OUT_CLK), .LOCK(LOCK)) ;

// control code = 127, period = 0.3728ns, freq = 2.68 GHz
// control code = 64, period = 0.5827ns, freq = 1.71 GHz
// control code = 0,
always@(RESET) INV_RESET = ~RESET;

always #(((1/frequency)*1000000000)/2) REF_CLOCK =~ REF_CLOCK;

initial begin
// WaveDump all signals
$dumpfile("FINAL.vcd");
$dumpvars;

RESET = 1;
REF_CLOCK = 0;

frequency = 1.75*1000000000;
MO =0;
M1= 0;
M2 = 1;
#10 RESET = 0;
#1000 RESET = 1;

frequency = 400*1000000;
MO = 0;
M1 = 1;
M2 = 1;
#10 RESET = 0;
#1000 RESET = 1;
$finish;

endmodule

period = 26.698ns, freq = 37.5 MHz

end