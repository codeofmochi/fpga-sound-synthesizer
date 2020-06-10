--
-- Sound synthesizer master generator
-- Computes final audio samples to be sent to the WM8731 audio codec
--
-- DO NOT CHANGE THIS FILE DIRECTLY, INSTEAD CHANGE sound_gen.py!
--
-- file:                sound_gen.vhd
-- auto-generated from: sound_gen.py
-- last generated:      2020-06-10
-- author:              Alexandre CHAU & Loïc DROZ
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sound_gen is
    port (
        clk     : in std_logic;
        reset_n : in std_logic;

        -- Avalon
        as_address   : in std_logic_vector(1 downto 0);
        as_write     : in std_logic;
        as_writedata : in std_logic_vector(31 downto 0);

        -- WM8731 audio codec
        aud_clk12   : in std_logic; -- This clock MUST be at 12 MHz to ensure 48 KHz sample rate
        aud_daclrck : out std_logic;
        aud_dacdat  : out std_logic;

        -- Debug
        debug_daclrck : out std_logic;
        debug_dacdat  : out std_logic
    );
end entity sound_gen;

architecture rtl of sound_gen is
    -- register map
    constant REG_START_OFFSET    : std_logic_vector(as_address'length - 1 downto 0) := "00";
    constant REG_STOP_OFFSET     : std_logic_vector(as_address'length - 1 downto 0) := "01";
    constant REG_MIDI_MSG_OFFSET : std_logic_vector(as_address'length - 1 downto 0) := "10";

    -- internal register
    signal reg_on : std_logic;

    -- slow clock at 48 KHz
    signal sclk_counter : integer range 0 to 255;
    signal sclk_en      : std_logic;

    -- sound transfer fsm
    type state_type is (Q_IDLE, Q_SEND);
    signal state               : state_type;
    signal sample_bits_counter : integer range 0 to 31;

    -- final audio sample (sample is mono, audio is stereo)
    signal audio  : std_logic_vector(31 downto 0);
    signal sample : signed(15 downto 0);

    -- linear diff lookup table
    signal linear_diff_result : unsigned(15 downto 0);
    component linear_diff
        port (
            midi_note_code   : in std_logic_vector(7 downto 0);
            note_linear_diff : out unsigned(15 downto 0)
        );
    end component linear_diff;

    -- oscillator component
    component osc
        port (
            aud_clk12 : in std_logic;
            sclk_en   : in std_logic;
            reset_n   : in std_logic;
            reg_on    : in std_logic;
            note_step : in unsigned(15 downto 0);
            osc_out   : out signed(15 downto 0)
        );
    end component osc;

    -- registers for oscillator instance osc0
    signal osc0_note_step : unsigned(15 downto 0);
    signal osc0_note      : std_logic_vector(31 downto 0);
    signal osc0_out       : signed(15 downto 0);
begin
    -- instantiate linear diff computation
    linear_diff0 : linear_diff port map(
        midi_note_code   => as_writedata(15 downto 8),
        note_linear_diff => linear_diff_result
    );

    -- writes to the status registers on Avalon writes
    as_write_process : process (clk, reset_n)
    begin
        if reset_n = '0' then
            reg_on         <= '0';
            osc0_note      <= (others => '0');
            osc0_note_step <= to_unsigned(0, osc0_note_step'length);

        elsif rising_edge(clk) then
            if as_write = '1' then
                case as_address is
                    when REG_START_OFFSET =>
                        reg_on <= '1';
                    when REG_STOP_OFFSET =>
                        reg_on <= '0';
                    when REG_MIDI_MSG_OFFSET =>
                        -- save note_step if MIDI event is note on (0x90)
                        -- TODO: implement OSC selection
                        if to_integer(unsigned(as_writedata(23 downto 16))) = 16#90# then
                            -- select osc0
                            osc0_note      <= as_writedata;
                            osc0_note_step <= linear_diff_result;
                        end if;
                    when others =>
                        null;
                end case;
            end if;
        end if;
    end process as_write_process;

    -- generates the 48 KHz pulse slow "clock"
    sclk_gen : process (aud_clk12, reset_n)
    begin
        if reset_n = '0' then
            sclk_counter  <= 0;
            sclk_en       <= '0';
            aud_daclrck   <= '0';
            debug_daclrck <= '0';

        elsif falling_edge(aud_clk12) then
            aud_daclrck   <= sclk_en and reg_on;
            debug_daclrck <= sclk_en and reg_on;

            if (sclk_counter < 250) then
                sclk_counter <= sclk_counter + 1;
                sclk_en      <= '0';
            else
                sclk_counter <= 0;
                sclk_en      <= '1';
            end if;
        end if;
    end process sclk_gen;

    -- transfer sound to audio output through DAC
    transfer_fsm : process (aud_clk12, reset_n)
    begin
        if reset_n = '0' then
            aud_dacdat          <= '0';
            debug_dacdat        <= '0';
            sample_bits_counter <= 0;
            state               <= Q_IDLE;

        elsif falling_edge(aud_clk12) then
            case state is
                when Q_IDLE =>
                    if reg_on = '1' and sclk_en = '1' then
                        sample_bits_counter <= 31;
                        state               <= Q_SEND;
                    end if;

                when Q_SEND =>
                    if sample_bits_counter > 0 then
                        sample_bits_counter <= sample_bits_counter - 1;
                    elsif sample_bits_counter = 0 then
                        state <= Q_IDLE;
                    end if;
                    aud_dacdat   <= audio(sample_bits_counter);
                    debug_dacdat <= audio(sample_bits_counter);

                when others =>
                    null;
            end case;
        end if;
    end process transfer_fsm;

    -- oscillator osc0 instance
    osc0 : osc port map(
        aud_clk12 => aud_clk12,
        sclk_en   => sclk_en,
        reset_n   => reset_n,
        reg_on    => reg_on,
        note_step => osc0_note_step,
        osc_out   => osc0_out
    );

    -- mixes sound from generators into the final audio sample
    mixer : process (aud_clk12, reset_n)
    begin
        if reset_n = '0' then
            audio  <= (others => '0');
            sample <= to_signed(0, sample'length);

        elsif falling_edge(aud_clk12) then
            if reg_on = '1' and sclk_en = '1' then
                sample <= osc0_out;

                -- mix samples in mono: left and right channels get assigned the sample
                audio(31 downto 16) <= std_logic_vector(sample);
                audio(15 downto 0)  <= std_logic_vector(sample);
            end if;
        end if;
    end process mixer;

end architecture rtl;

-- DO NOT CHANGE THIS FILE DIRECTLY, INSTEAD CHANGE sound_gen.py!