/*==================================================
             FSM-TIMER-DEMO
====================================================
Description: 
 A four-state FSM-based timer module with an asynchronous
 override input that forces an immediate transition to S3.
 
Design Engineer:
 Caberoy, Adrian Miko A.
 Vigilar, Franz Louis G.
 
Date:
 10 May 2026
-------------------------------------------------------*/
module timer_demo (out, clk, rst, ovr, timer, state);
 //ports
 input clk;
 input rst;
 input ovr;
 output reg out;
 output reg [3:0] state;
 output [3:0] timer;

 
 //state assignment
  localparam  [3:0] S0 = 4'b0000;
  localparam  [3:0] S1 = 4'b0001;
  localparam  [3:0] S2 = 4'b0010;
  localparam  [3:0] S3 = 4'b0011;
  reg [3:0] nxt;
  reg [3:0] pre;
  reg [3:0] t;
  
  
 //input block
  always @(t,ovr,pre) begin
   if (ovr) 
    nxt = S3;
   else
    case(pre)
        S0: nxt = (t == 2)? S1:S0;  
        S1: nxt = (t == 3)? S2:S1;  
        S2: nxt = (t == 2)? S0:S2;
	S3: nxt = S0;
        default: nxt = S0;
    endcase
  end
 
 //sequential block
 always@(posedge clk, negedge rst) begin
     if (!rst) begin
         pre <= S0;
         t <= 4'b0;
     end
     else begin
         pre <= nxt;
          if(nxt==S3) begin
            t <= 0;
          end
          else
           if(pre==S0) begin
             if(t==2) begin
                t <= 0;
             end
            else t <= t+1;
           end
          else 
           if(pre==S1) begin
            if(t==3) begin 
                t <= 0;
            end
            else t <= t+1;
           end
          else 
           if(pre==S2) begin
            if(t==2) begin
                t <= 0;
            end
            else t <= t+1;
 	   end
     end
end
 

 

 //output block
  always @(pre) begin
    case(pre)
        S0: begin 
                out = 0;
                state = S0;
            end
        S1: begin 
                out = 1;
                state = S1;
            end    
        S2: begin 
                out = 0;                     
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
  
 assign timer = t ;
 
endmodule