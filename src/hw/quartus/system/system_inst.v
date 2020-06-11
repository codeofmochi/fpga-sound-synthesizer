	system u0 (
		.clk_clk                              (<connected-to-clk_clk>),                              //                          clk.clk
		.i2c_slave_0_debug_debug_sclk         (<connected-to-i2c_slave_0_debug_debug_sclk>),         //            i2c_slave_0_debug.debug_sclk
		.i2c_slave_0_debug_debug_sdat         (<connected-to-i2c_slave_0_debug_debug_sdat>),         //                             .debug_sdat
		.i2c_slave_0_i2c_i2c_sclk             (<connected-to-i2c_slave_0_i2c_i2c_sclk>),             //              i2c_slave_0_i2c.i2c_sclk
		.i2c_slave_0_i2c_i2c_sdat             (<connected-to-i2c_slave_0_i2c_i2c_sdat>),             //                             .i2c_sdat
		.pll_0_clk12_clk                      (<connected-to-pll_0_clk12_clk>),                      //                  pll_0_clk12.clk
		.pll_0_sdram_clk                      (<connected-to-pll_0_sdram_clk>),                      //                  pll_0_sdram.clk
		.reset_reset_n                        (<connected-to-reset_reset_n>),                        //                        reset.reset_n
		.sdram_controller_0_wire_addr         (<connected-to-sdram_controller_0_wire_addr>),         //      sdram_controller_0_wire.addr
		.sdram_controller_0_wire_ba           (<connected-to-sdram_controller_0_wire_ba>),           //                             .ba
		.sdram_controller_0_wire_cas_n        (<connected-to-sdram_controller_0_wire_cas_n>),        //                             .cas_n
		.sdram_controller_0_wire_cke          (<connected-to-sdram_controller_0_wire_cke>),          //                             .cke
		.sdram_controller_0_wire_cs_n         (<connected-to-sdram_controller_0_wire_cs_n>),         //                             .cs_n
		.sdram_controller_0_wire_dq           (<connected-to-sdram_controller_0_wire_dq>),           //                             .dq
		.sdram_controller_0_wire_dqm          (<connected-to-sdram_controller_0_wire_dqm>),          //                             .dqm
		.sdram_controller_0_wire_ras_n        (<connected-to-sdram_controller_0_wire_ras_n>),        //                             .ras_n
		.sdram_controller_0_wire_we_n         (<connected-to-sdram_controller_0_wire_we_n>),         //                             .we_n
		.sound_gen_0_audio_aud_clk12          (<connected-to-sound_gen_0_audio_aud_clk12>),          //            sound_gen_0_audio.aud_clk12
		.sound_gen_0_audio_aud_daclrck        (<connected-to-sound_gen_0_audio_aud_daclrck>),        //                             .aud_daclrck
		.sound_gen_0_audio_aud_dacdat         (<connected-to-sound_gen_0_audio_aud_dacdat>),         //                             .aud_dacdat
		.sound_gen_0_debug_debug_daclrck      (<connected-to-sound_gen_0_debug_debug_daclrck>),      //            sound_gen_0_debug.debug_daclrck
		.sound_gen_0_debug_debug_dacdat       (<connected-to-sound_gen_0_debug_debug_dacdat>),       //                             .debug_dacdat
		.buttons_controller_0_conduit_switch  (<connected-to-buttons_controller_0_conduit_switch>),  // buttons_controller_0_conduit.switch
		.buttons_controller_0_conduit_buttons (<connected-to-buttons_controller_0_conduit_buttons>)  //                             .buttons
	);

