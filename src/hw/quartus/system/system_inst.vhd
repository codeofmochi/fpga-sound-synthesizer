	component system is
		port (
			clk_clk                         : in    std_logic                     := 'X';             -- clk
			i2c_slave_0_debug_debug_sclk    : out   std_logic;                                        -- debug_sclk
			i2c_slave_0_debug_debug_sdat    : out   std_logic;                                        -- debug_sdat
			i2c_slave_0_i2c_i2c_sclk        : out   std_logic;                                        -- i2c_sclk
			i2c_slave_0_i2c_i2c_sdat        : inout std_logic                     := 'X';             -- i2c_sdat
			pll_0_clk12_clk                 : out   std_logic;                                        -- clk
			pll_0_sdram_clk                 : out   std_logic;                                        -- clk
			reset_reset_n                   : in    std_logic                     := 'X';             -- reset_n
			sdram_controller_0_wire_addr    : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_controller_0_wire_ba      : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_controller_0_wire_cas_n   : out   std_logic;                                        -- cas_n
			sdram_controller_0_wire_cke     : out   std_logic;                                        -- cke
			sdram_controller_0_wire_cs_n    : out   std_logic;                                        -- cs_n
			sdram_controller_0_wire_dq      : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_controller_0_wire_dqm     : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_controller_0_wire_ras_n   : out   std_logic;                                        -- ras_n
			sdram_controller_0_wire_we_n    : out   std_logic;                                        -- we_n
			sound_gen_0_audio_aud_clk12     : in    std_logic                     := 'X';             -- aud_clk12
			sound_gen_0_audio_aud_daclrck   : out   std_logic;                                        -- aud_daclrck
			sound_gen_0_audio_aud_dacdat    : out   std_logic;                                        -- aud_dacdat
			sound_gen_0_debug_debug_daclrck : out   std_logic;                                        -- debug_daclrck
			sound_gen_0_debug_debug_dacdat  : out   std_logic                                         -- debug_dacdat
		);
	end component system;

	u0 : component system
		port map (
			clk_clk                         => CONNECTED_TO_clk_clk,                         --                     clk.clk
			i2c_slave_0_debug_debug_sclk    => CONNECTED_TO_i2c_slave_0_debug_debug_sclk,    --       i2c_slave_0_debug.debug_sclk
			i2c_slave_0_debug_debug_sdat    => CONNECTED_TO_i2c_slave_0_debug_debug_sdat,    --                        .debug_sdat
			i2c_slave_0_i2c_i2c_sclk        => CONNECTED_TO_i2c_slave_0_i2c_i2c_sclk,        --         i2c_slave_0_i2c.i2c_sclk
			i2c_slave_0_i2c_i2c_sdat        => CONNECTED_TO_i2c_slave_0_i2c_i2c_sdat,        --                        .i2c_sdat
			pll_0_clk12_clk                 => CONNECTED_TO_pll_0_clk12_clk,                 --             pll_0_clk12.clk
			pll_0_sdram_clk                 => CONNECTED_TO_pll_0_sdram_clk,                 --             pll_0_sdram.clk
			reset_reset_n                   => CONNECTED_TO_reset_reset_n,                   --                   reset.reset_n
			sdram_controller_0_wire_addr    => CONNECTED_TO_sdram_controller_0_wire_addr,    -- sdram_controller_0_wire.addr
			sdram_controller_0_wire_ba      => CONNECTED_TO_sdram_controller_0_wire_ba,      --                        .ba
			sdram_controller_0_wire_cas_n   => CONNECTED_TO_sdram_controller_0_wire_cas_n,   --                        .cas_n
			sdram_controller_0_wire_cke     => CONNECTED_TO_sdram_controller_0_wire_cke,     --                        .cke
			sdram_controller_0_wire_cs_n    => CONNECTED_TO_sdram_controller_0_wire_cs_n,    --                        .cs_n
			sdram_controller_0_wire_dq      => CONNECTED_TO_sdram_controller_0_wire_dq,      --                        .dq
			sdram_controller_0_wire_dqm     => CONNECTED_TO_sdram_controller_0_wire_dqm,     --                        .dqm
			sdram_controller_0_wire_ras_n   => CONNECTED_TO_sdram_controller_0_wire_ras_n,   --                        .ras_n
			sdram_controller_0_wire_we_n    => CONNECTED_TO_sdram_controller_0_wire_we_n,    --                        .we_n
			sound_gen_0_audio_aud_clk12     => CONNECTED_TO_sound_gen_0_audio_aud_clk12,     --       sound_gen_0_audio.aud_clk12
			sound_gen_0_audio_aud_daclrck   => CONNECTED_TO_sound_gen_0_audio_aud_daclrck,   --                        .aud_daclrck
			sound_gen_0_audio_aud_dacdat    => CONNECTED_TO_sound_gen_0_audio_aud_dacdat,    --                        .aud_dacdat
			sound_gen_0_debug_debug_daclrck => CONNECTED_TO_sound_gen_0_debug_debug_daclrck, --       sound_gen_0_debug.debug_daclrck
			sound_gen_0_debug_debug_dacdat  => CONNECTED_TO_sound_gen_0_debug_debug_dacdat   --                        .debug_dacdat
		);

