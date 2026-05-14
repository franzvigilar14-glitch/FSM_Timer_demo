//testbench for top_timer_demo

module testbench;
 //tb signals
 reg             ovr;
 reg         clk_in;
 reg          rst;
 wire           out;
 wire [0:6]  leds_timer;
 wire [0:6]  leds_state;
 wire       clk_led;
 
 // instantiate top_timer_demo
 top_timer_demo dut (
 .out(out),
 .leds_timer(leds_timer),
 .leds_state(leds_state),
 .clk_led(clk_led),
 .ovr(ovr),
 .clk_in(clk_in),
 .rst(rst)
 
 );
 
 //apply stimuli
 initial clk_in = 1'b0;
 always #1 clk_in = ~clk_in;
 
 initial begin
 	rst = 0; ovr = 0; #2;
	rst = 1; ovr = 0; #6;
        rst = 1; ovr = 0; #40; 
        rst = 1; ovr = 1; #20;  
	rst = 1; ovr = 0; #40;   
	rst = 0; ovr = 0; #4;    
        rst = 1; ovr = 0; #40;  
	
 end
 
endmodule
