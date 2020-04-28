module PWM(
  input clk_pwm,
  input wire [5:0] rgb_pwm,
  output reg led_r,
  output reg led_g,
  output reg led_b
);
  reg [1:0] count;
  
  always @(posedge clk_pwm) begin
    if(count == 2'b10)
      count = 2'b00;
    else
      count = count + 1;
  end
  always @(*) begin
    if(rgb_pwm [5:4] > count)
      led_r = 1;
    else
      led_r = 0;
    if(rgb_pwm [3:2] > count)
      led_g = 1;
    else
      led_g = 0;
    if(rgb_pwm [1:0] > count)
      led_b = 1;
    else
      led_b = 0;      
  end   
endmodule