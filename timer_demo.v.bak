module timer_demo (state, timer, out, t, ovr, clk_50, rst, leds);
 //ports
 input t;
 input ovr;
 input clk_50;
 input rst;
 output reg state [3:0];
 output reg timer [3:0];
 output out;
 output leds [0:6];
 
 //nets
 wire clk_w;
 wire [2:0] state_w;
 
 //state assignment
  localparam  [3:0] S0 = 4'b0000;
  localparam  [3:0] S1 = 4'b0001;
  localparam  [3:0] S2 = 4'b0010;
  localparam  [3:0] S3 = 4'b0011;
  reg [3:0] nxt;
  reg [3:0] pre;
  
 //input block
  always @(t,ovr,pre) begin
 	case(pre)
 		S0: nxt = (t == 2)? S0:S1;
 		S1: nxt = (t == 3)? S1:S2;
 		S2: nxt = (t == 2)? S2:S3;
 		S3: nxt = ovr? S3:S0;
 		default: nxt = S0;
 	endcase
  
 end
 
 //sequential block
 always@(posedge clk, negedge rst) begin
 nxt <= pre;
  if (!rst)
     pre = S0;
     else pre <= nxt;
 end
 
 //check timer + state
 always@(posedge clk, negedge rst)begin
 case(pre)
 	if (pre==S0) begin
 	if (t == 2) t=0;	  
 	else t <= t + 1;	 
 	end
 	
 	if (pre==S1) begin
 	if (t == 3) t = 0;	  
 	else t <= t + 1;
 	end
 	  
 	  
 	if (pre==S2) begin
 	if (t == 2) t = 0;
 	else t = t + 1;
 	end
 	  
  endcase 	
 end
 
 assign timer = t;
 
 //output block
  always @(pre) begin
 	case(pre)
 		S0: begin 
 				out = 0;
 				state = S0;
 		    end
 		S1: begin 
 				out = 0;
 				state = S1;
 		    end	
 		S2: begin 
 				out = 1;
 				state = S2;
 		    end	
 
 		S3: begin 
 				out = 1;
 				state = S3;
 		    end
 		
 
 		default: begin 
				out = 0;
				state = S0;
 		end	
 
 	endcase
  end
  
  // 7-segment instance
   bcd_7seg f2d(
        .leds(leds),
        .bcd(state_w)
    );
    
    // clock divider instance
     clk_div #(.PERIOD_OUT(3)) clk_div_ins(
     	.clk_in(clk_in),
     	.clk_out(clk_w),
     	.clk_led(clk_led)
 );
  

endmodule
