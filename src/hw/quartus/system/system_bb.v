
module system (
	clk_clk,
	i2c_slave_0_debug_debug_sclk,
	i2c_slave_0_debug_debug_sdat,
	i2c_slave_0_i2c_i2c_sclk,
	i2c_slave_0_i2c_i2c_sdat,
	pll_0_clk12_clk,
	pll_0_sdram_clk,
	reset_reset_n,
	sdram_controller_0_wire_addr,
	sdram_controller_0_wire_ba,
	sdram_controller_0_wire_cas_n,
	sdram_controller_0_wire_cke,
	sdram_controller_0_wire_cs_n,
	sdram_controller_0_wire_dq,
	sdram_controller_0_wire_dqm,
	sdram_controller_0_wire_ras_n,
	sdram_controller_0_wire_we_n,
	sound_gen_0_audio_aud_clk12,
	sound_gen_0_audio_aud_daclrck,
	sound_gen_0_audio_aud_dacdat,
	sound_gen_0_debug_debug_daclrck,
	sound_gen_0_debug_debug_dacdat,
	buttons_controller_0_conduit_switch,
	buttons_controller_0_conduit_buttons);	

	input		clk_clk;
	output		i2c_slave_0_debug_debug_sclk;
	output		i2c_slave_0_debug_debug_sdat;
	output		i2c_slave_0_i2c_i2c_sclk;
	inout		i2c_slave_0_i2c_i2c_sdat;
	output		pll_0_clk12_clk;
	output		pll_0_sdram_clk;
	input		reset_reset_n;
	output	[12:0]	sdram_controller_0_wire_addr;
	output	[1:0]	sdram_controller_0_wire_ba;
	output		sdram_controller_0_wire_cas_n;
	output		sdram_controller_0_wire_cke;
	output		sdram_controller_0_wire_cs_n;
	inout	[15:0]	sdram_controller_0_wire_dq;
	output	[1:0]	sdram_controller_0_wire_dqm;
	output		sdram_controller_0_wire_ras_n;
	output		sdram_controller_0_wire_we_n;
	input		sound_gen_0_audio_aud_clk12;
	output		sound_gen_0_audio_aud_daclrck;
	output		sound_gen_0_audio_aud_dacdat;
	output		sound_gen_0_debug_debug_daclrck;
	output		sound_gen_0_debug_debug_dacdat;
	input	[9:0]	buttons_controller_0_conduit_switch;
	input	[2:0]	buttons_controller_0_conduit_buttons;
endmodule
