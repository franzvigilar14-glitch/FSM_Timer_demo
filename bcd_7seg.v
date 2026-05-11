/*==================================================
             BCD to 7-SEGMENT DECODER
====================================================
Description: 
 This is a Binary Coded Decimal (BCD) to 7 Segment Decoder with active-high outputs for driving common-cathode LEDs.
 
Design Engineer:
 Caberoy, Adrian Miko A.
 Vigilar, Franz Louis G.
 
Date:
 15 Jan 2026
-------------------------------------------------------*/
module bcd_7seg (leds,bcd);
 //ports and nets
 input [3:0] bcd;
 output reg [0:6] leds;
 
 //BCD Decoder
 always @(bcd) begin
  case(bcd)       //abcdefg
    4'd0: leds = 7'b1111110;
    4'd1: leds = 7'b0110000;
    4'd2: leds = 7'b1101101;
    4'd3: leds = 7'b1111001;
    4'd4: leds = 7'b0110011;
    4'd5: leds = 7'b1011011;
    4'd6: leds = 7'b0011111;
    4'd7: leds = 7'b1110000;
    4'd8: leds = 7'b1111111;
    4'd9: leds = 7'b1110011;
    default: leds = 7'b0000001;
  endcase
 end
endmodule