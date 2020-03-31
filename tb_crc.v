`timescale 1ns/1ps
module tb_crc();
reg clk, reset, init, d_in, en_com, nen_shift;

wire[23:0] crc_out;

crc24 crc(
    .clk(clk),
    .reset(reset),
    .init(init),
    .en_com(en_com),
    .d_in(d_in),

    .nen_shift(nen_shift),

    .crc_out(crc_out)
);

wire[1031:0] input_vector = 1031'b111101101000101011110011101101111011011111000001000100011111111100000001000110000111101011111110000110001111011101001110000110001101010011001100111100010010100011100001110011001010101100001101100000000000001010010010001111111111000100001011110000011100010001001011010000010111001101011010010101101100011111100011101101100001000110101000101001000101111111100110000100001000111000111111010111101101110110111010111100001010110011111111100100010001010000001000001000010000101111001001010011101101101001110001110010000001101101000100101100100111101011100011110000100001011001010110111000111000100110011011111000111001110010011110011000000110010011001001010111000000001101000110010010101111010101011110011110110111110010011100010010111111000100000101110100010100100110010110110101010010010010010000000100101011101100110101011110001001001000000001000001110101001010110101111000100101110011111011100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;

integer iterations = 1032, i, k;

//Clock Generator
initial clk=1'b0;
always #5 clk=~clk;

//Power-on Reset
initial
begin
		reset = 1'b1;
#20 	reset = 1'b0;
end


initial
begin	
#30
init=1'b1;
d_in=1'bx;
en_com = 1'b1;
nen_shift = 1'b1;
#15 init = 1'b0;
en_com = 1'b0;
d_in=1'b0;
#10;
en_com = 1'b1;
i = 0;
while (i < iterations)
begin		
	d_in = input_vector[i];		
	i = i + 1;
	#10;
end
d_in = 1'b0;
en_com = 1'b0;
end
endmodule