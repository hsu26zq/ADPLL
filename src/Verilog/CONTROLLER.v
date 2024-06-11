//-------------------------------//
//- Advanced Digital IC Design   //
//                               //
//- Exercise: PLL Controller     //
//-------------------------------//

timescale 1ns/1ps
module CONTROLLER(reset, phase_clk, p_up, p_down,
freq_lock, polarity, INO, IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, IN9, IN10, IN11, IN12, IN13, IN14, IN15,
IN16, IN17, IN18, IN19, IN20, IN21, IN22, IN23, IN24, IN25, IN26, IN27, IN28, IN29, IN30, IN31,
IN32, IN33, IN34, IN35, IN36, IN37, IN38, IN39, IN40, IN41, IN42, IN43, IN44, IN45, IN46, IN47,
IN48, IN49, IN50, IN51, IN52, IN53, IN54, IN55, IN56, IN57, IN58, IN59, IN60, IN61, IN62, IN63,
IN64, IN65, IN66, IN67, IN68, IN69, IN70, IN71, IN72, IN73, IN74, IN75, IN76, IN77, IN78, IN79,
IN80, IN81, IN82, IN83, IN84, IN85, IN86, IN87, IN88, IN89, IN90, IN91, IN92, IN93, IN94, IN95,
IN96, IN97, IN98, IN99, IN100, IN101, IN102, IN103, IN104, IN105, IN106, IN107, IN108, IN109, IN110, IN111,
IN112, IN113, IN114, IN115, IN116, IN117, IN118, IN119, IN120, IN121, IN122, IN123, IN124, IN125, IN126, IN127);

input	reset, phase_clk;
input	p_up, p_down;
output	freq_lock;
output	polarity;
output reg INO, IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, IN9, IN10, IN11, IN12, IN13, IN14, IN15,
IN16, IN17, IN18, IN19, IN20, IN21, IN22, IN23, IN24, IN25, IN26, IN27, IN28, IN29, IN30, IN31,
IN32, IN33, IN34, IN35, IN36, IN37, IN38, IN39, IN40, IN41, IN42, IN43, IN44, IN45, IN46, IN47,
IN48, IN49, IN50, IN51, IN52, IN53, IN54, IN55, IN56, IN57, IN58, IN59, IN60, IN61, IN62, IN63,
IN64, IN65, IN66, IN67, IN68, IN69, IN70, IN71, IN72, IN73, IN74, IN75, IN76, IN77, IN78, IN79,
IN80, IN81, IN82, IN83, IN84, IN85, IN86, IN87, IN88, IN89, IN90, IN91, IN92, IN93, IN94, IN95,
IN96, IN97, IN98, IN99, IN100, IN101, IN102, IN103, IN104, IN105, IN106, IN107, IN108, IN109, IN110, IN111,
IN112, IN113, IN114, IN115, IN116, IN117, IN118, IN119, IN120, IN121, IN122, IN123, IN124, IN125, IN126, IN127;

reg [6:0] code = 7'd64;
reg [6:0] step = 7'd16;
reg flag_up = 0;
reg flag_down = 0;
reg polarity = 0;
reg freq_lock = 0;

reg [6:0] anchor = 7'd0;

reg [127:0] dco_code = 128'hFFFFFFFFFFFFFFFF0000000000000000;

always@(negedge phase_clk) begin
if(!reset) begin
if(!p_up) begin
if (code + step > code) code <= code + step;
flag_up = 1;
end if(!p_down) begin
if(code - step < code) code <= code - step;
flag_down = 1;
end if(flag_up && flag_down) begin
polarity <= 1;
flag_down <= 0;
flag_up <= 0;
end if(polarity) begin
if(step != 1) step <= step / 2;
polarity <= 0;
end if(step == 7'd1) freq_lock <= 1;
end else begin
code <= 7'd64;
step <= 7'd16;
flag_up <= 0;
flag_down <= 0;
polarity <= 0;
freq_lock <= 0;
anchor <= 0;
dco_code <= 128'hFFFFFFFFFFFFFFFF0000000000000000;

end

end
//filter
always@(posedge freq_lock) anchor <= code;
always@(negedge phase_clk) begin
if(!reset && freq_lock && polarity) code <= anchor;
if(!reset && code == anchor + 4) anchor <= anchor + 1;
else if(!reset && code == anchor - 4) anchor <= anchor - 1;

//control code to dco code
always@(code) begin
case (code)
7'd127: dco code <= 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
7'd126: dco code <= 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE;
7'd125: dco code <= 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC;
7'd124: dco code <= 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8;
7'd123: dco_code <= 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFO;
7'd122: dco code <= 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEO;
7'd121: dco code <= 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCO;
7'd120: dco code <= 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF80;
7'd119: dco code <= 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0O;
7'd118: dco code <= 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0O;
7'd117: dco code <= 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCOO;
7'd116: dco code <= 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFF800;
...
7'd020: dco code <= 128'hFFFFF800000000000000000000000000;
7'd019: dco code <= 128'hFFFFF000000000000000000000000000;
7'd018: dco code <= 128'hFFFFE000000000000000000000000000;
7'd017: dco code <= 128'hFFFFC000000000000000000000000000;
7'd016: dco code <= 128'hFFFF8000000000000000000000000000;
7'd015: dco code <= 128'hFFFF0000000000000000000000000000;
7'd014: dco code <= 128'hFFFE0000000000000000000000000000;
7'd013: dco code <= 128'hFFFC0000000000000000000000000000;
7'd012: dco code <= 128'hFFF80000000000000000000000000000;
7'd011: dco code <= 128'hFFF00000000000000000000000000000;
7'd010: dco code <= 128'hFFE00000000000000000000000000000;
7'd009: dco code <= 128'hFFC00000000000000000000000000000;
7'd008: dco code <= 128'hFF800000000000000000000000000000;
7'd007: dco code <= 128'hFF000000000000000000000000000000;
7'd006: dco code <= 128'hFE000000000000000000000000000000;
7'd005: dco code <= 128'hFC000000000000000000000000000000;
7'd004: dco code <= 128'hF8000000000000000000000000000000;
7'd003: dco code <= 128'hF0000000000000000000000000000000;
7'd002: dco code <= 128'hE0000000000000000000000000000000;
7'd001: dco code <= 128'hE0000000000000000000000000000000;
7'd000: dco code <= 128'hE0000000000000000000000000000000;
endcase
end

always@* begin
IN127 = dco_code[127];
IN126 = dco_code[126];
IN125 = dco code[125];
IN124 = dco_code[124];
IN123 = dco_code[123];
IN122 = dco_code[122];
IN121 = dco code[121];
IN120 = dco_code[120];
IN119 = dco_code[119];
IN118 = dco_code[118];
IN117 = dco_code[117];
IN116 = dco code[116];
IN115 = dco_code[115];
IN114 = dco_code[114];
IN113 = dco code[113];
IN112 = dco code[112];
IN111 = dco_code[111];
IN110 = dco_code[110];
IN109 = dco_code[109];
IN108 = dco_code[108];
IN107 = dco code[107];
IN44 = dco_code[44];
IN43 = dco_code[43];
IN42 = dco code[42];
IN41 = dco code[41];
IN40 = dco code[40];
IN39 = dco code[39];
IN38 = dco code[38];
IN37 = dco code[37];
IN36 = dco code[36];
IN35 = dco code[35];
IN34 = dco code[34];
IN33 = dco code[33];
IN32 = dco_code[32];
IN31 = dco code[31];
IN30 = dco_code[30];
IN29 = dco code[29];
IN28 = dco code[28];
IN27 = dco code[27];
IN26 = dco_code[26];
IN25 = dco code[25];
IN24 = dco_code[24];
IN23 = dco code[23];
IN22 = dco code[22];
IN21 = dco code[21];
IN20 = dco code[20];
IN19 = dco_code[19];
IN18 = dco code[18];
IN17 = dco code[17];
IN16 = dco code[16];
IN15 = dco code[15];
IN14 = dco code[14];
IN13 = dco_code[13];
IN12 = dco code[12];
IN11 = dco code[11];
IN10 = dco code[10];
IN9 = dco code[9];
IN8 = dco_code[8];
IN7 = dco_code[7];
IN6 = dco code[6];
IN5 = dco code[5];
IN4 = dco_code[4];
IN3 = dco code[3];
IN2 = dco_code[2];
IN1 = dco code[1];
INO = dco _code[0];
end
endmodule
