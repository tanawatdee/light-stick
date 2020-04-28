`include "CLK.v"
`include "ACC.v"
`include "TO7.v"
`include "PWM.v"
`include "ROM.v"
`include "PLAY.v"

module TOP(
	input wire t_clock,
	input wire t_next,
	input wire t_prev,
	input wire t_shake,
	output wire[6:0] t_seven_seg,
	output wire t_led_r,
	output wire t_led_g,
	output wire t_led_b,
	output wire[3:0] t_an
);
	wire clock_pwm;
	wire clock_play;
	wire restart;
	wire[5:0] data;
	wire[5:0] rgb_signal;
	wire[3:0] song_no;
	wire[7:0] rand_num;
	wire[15:0] address;

	assign t_an = 4'b1110;

	CLK C1(t_clock, clock_play, clock_pwm, rand_num);
	ACC A1(t_next, t_prev, t_shake, clock_play, restart, song_no);
	TO7 T1(song_no, t_seven_seg);
	PWM P1(clock_pwm, rgb_signal, t_led_r, t_led_g, t_led_b);
	ROM R1(address, data);
	PLAY P2(clock_play, restart, song_no, rand_num, data, rgb_signal, address);
	
endmodule