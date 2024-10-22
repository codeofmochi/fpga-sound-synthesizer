--
-- Sound synthesizer master generator
-- Computes final audio samples to be sent to the WM8731 audio codec
--
-- DO NOT CHANGE THIS FILE DIRECTLY, INSTEAD CHANGE sound_gen.py!
--
-- file:                sound_gen.vhd
-- auto-generated from: sound_gen.py
-- last generated:      2020-06-14
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
        aud_clk12   : in std_logic; -- This clock MUST be at 12 MHz to ensure 96000 Hz sample rate
        aud_daclrck : out std_logic;
        aud_dacdat  : out std_logic;

        -- Debug
        debug_daclrck : out std_logic;
        debug_dacdat  : out std_logic;

        -- VU meter
        vu_meter : out std_logic_vector(9 downto 0)
    );
end entity sound_gen;

architecture rtl of sound_gen is
    -- register map
    constant REG_START_OFFSET    : std_logic_vector(as_address'length - 1 downto 0) := "00";
    constant REG_STOP_OFFSET     : std_logic_vector(as_address'length - 1 downto 0) := "01";
    constant REG_MIDI_MSG_OFFSET : std_logic_vector(as_address'length - 1 downto 0) := "10";
    constant REG_OSC_MODE_OFFSET : std_logic_vector(as_address'length - 1 downto 0) := "11";

    -- internal register
    signal reg_on       : std_logic;
    signal reg_osc_mode : unsigned(31 downto 0);

    -- slow clock at 96000 Hz
    signal sclk_counter : integer range 0 to 127;
    signal sclk_en      : std_logic;

    -- sound transfer fsm
    type state_type is (Q_IDLE, Q_SEND);
    signal state               : state_type;
    signal sample_bits_counter : integer range 0 to 63;

    -- final audio sample (sample is mono, audio is stereo)
    signal audio  : std_logic_vector(63 downto 0);
    signal sample : signed(31 downto 0);

    -- VU meter signals
    signal vu_meter_value : signed(vu_meter'length - 1 downto 0);

    -- linear diff lookup table
    signal linear_diff_result    : unsigned(31 downto 0);
    signal period_samples_result : unsigned(31 downto 0);
    component linear_diff
        port (
            midi_note_code      : in std_logic_vector(7 downto 0);
            note_linear_diff    : out unsigned(31 downto 0);
            note_period_samples : out unsigned(31 downto 0)
        );
    end component linear_diff;

    -- oscillator component
    component osc
        port (
            aud_clk12   : in std_logic;
            sclk_en     : in std_logic;
            reset_n     : in std_logic;
            reg_on      : in std_logic;
            osc_mode    : in unsigned(31 downto 0);
            note        : in std_logic_vector(31 downto 0);
            note_step   : in unsigned(31 downto 0);
            note_period : in unsigned(31 downto 0);
            osc_out     : out signed(31 downto 0)
        );
    end component osc;

    -- registers for oscillator instance osc0
    signal osc0_note_step   : unsigned(31 downto 0);
    signal osc0_note_period : unsigned(31 downto 0);
    signal osc0_note        : std_logic_vector(31 downto 0);
    signal osc0_out         : signed(31 downto 0);
    -- registers for oscillator instance osc1
    signal osc1_note_step   : unsigned(31 downto 0);
    signal osc1_note_period : unsigned(31 downto 0);
    signal osc1_note        : std_logic_vector(31 downto 0);
    signal osc1_out         : signed(31 downto 0);
    -- registers for oscillator instance osc2
    signal osc2_note_step   : unsigned(31 downto 0);
    signal osc2_note_period : unsigned(31 downto 0);
    signal osc2_note        : std_logic_vector(31 downto 0);
    signal osc2_out         : signed(31 downto 0);
    -- registers for oscillator instance osc3
    signal osc3_note_step   : unsigned(31 downto 0);
    signal osc3_note_period : unsigned(31 downto 0);
    signal osc3_note        : std_logic_vector(31 downto 0);
    signal osc3_out         : signed(31 downto 0);
    -- registers for oscillator instance osc4
    signal osc4_note_step   : unsigned(31 downto 0);
    signal osc4_note_period : unsigned(31 downto 0);
    signal osc4_note        : std_logic_vector(31 downto 0);
    signal osc4_out         : signed(31 downto 0);
    -- registers for oscillator instance osc5
    signal osc5_note_step   : unsigned(31 downto 0);
    signal osc5_note_period : unsigned(31 downto 0);
    signal osc5_note        : std_logic_vector(31 downto 0);
    signal osc5_out         : signed(31 downto 0);
    -- registers for oscillator instance osc6
    signal osc6_note_step   : unsigned(31 downto 0);
    signal osc6_note_period : unsigned(31 downto 0);
    signal osc6_note        : std_logic_vector(31 downto 0);
    signal osc6_out         : signed(31 downto 0);
    -- registers for oscillator instance osc7
    signal osc7_note_step   : unsigned(31 downto 0);
    signal osc7_note_period : unsigned(31 downto 0);
    signal osc7_note        : std_logic_vector(31 downto 0);
    signal osc7_out         : signed(31 downto 0);
    -- registers for oscillator instance osc8
    signal osc8_note_step   : unsigned(31 downto 0);
    signal osc8_note_period : unsigned(31 downto 0);
    signal osc8_note        : std_logic_vector(31 downto 0);
    signal osc8_out         : signed(31 downto 0);
    -- registers for oscillator instance osc9
    signal osc9_note_step   : unsigned(31 downto 0);
    signal osc9_note_period : unsigned(31 downto 0);
    signal osc9_note        : std_logic_vector(31 downto 0);
    signal osc9_out         : signed(31 downto 0);
    -- registers for oscillator instance osc10
    signal osc10_note_step   : unsigned(31 downto 0);
    signal osc10_note_period : unsigned(31 downto 0);
    signal osc10_note        : std_logic_vector(31 downto 0);
    signal osc10_out         : signed(31 downto 0);
    -- registers for oscillator instance osc11
    signal osc11_note_step   : unsigned(31 downto 0);
    signal osc11_note_period : unsigned(31 downto 0);
    signal osc11_note        : std_logic_vector(31 downto 0);
    signal osc11_out         : signed(31 downto 0);
    -- registers for oscillator instance osc12
    signal osc12_note_step   : unsigned(31 downto 0);
    signal osc12_note_period : unsigned(31 downto 0);
    signal osc12_note        : std_logic_vector(31 downto 0);
    signal osc12_out         : signed(31 downto 0);
    -- registers for oscillator instance osc13
    signal osc13_note_step   : unsigned(31 downto 0);
    signal osc13_note_period : unsigned(31 downto 0);
    signal osc13_note        : std_logic_vector(31 downto 0);
    signal osc13_out         : signed(31 downto 0);
    -- registers for oscillator instance osc14
    signal osc14_note_step   : unsigned(31 downto 0);
    signal osc14_note_period : unsigned(31 downto 0);
    signal osc14_note        : std_logic_vector(31 downto 0);
    signal osc14_out         : signed(31 downto 0);
    -- registers for oscillator instance osc15
    signal osc15_note_step   : unsigned(31 downto 0);
    signal osc15_note_period : unsigned(31 downto 0);
    signal osc15_note        : std_logic_vector(31 downto 0);
    signal osc15_out         : signed(31 downto 0);
begin
    -- instantiate linear diff computation
    linear_diff0 : linear_diff port map(
        midi_note_code      => as_writedata(15 downto 8),
        note_linear_diff    => linear_diff_result,
        note_period_samples => period_samples_result
    );

    -- writes to the status registers on Avalon writes
    as_write_process : process (clk, reset_n)
    begin
        if reset_n = '0' then
            reg_on           <= '0';
            reg_osc_mode     <= (others => '0');
            osc0_note        <= (others => '0');
            osc0_note_step   <= to_unsigned(0, osc0_note_step'length);
            osc0_note_period <= to_unsigned(0, osc0_note_period'length);
            osc1_note        <= (others => '0');
            osc1_note_step   <= to_unsigned(0, osc1_note_step'length);
            osc1_note_period <= to_unsigned(0, osc1_note_period'length);
            osc2_note        <= (others => '0');
            osc2_note_step   <= to_unsigned(0, osc2_note_step'length);
            osc2_note_period <= to_unsigned(0, osc2_note_period'length);
            osc3_note        <= (others => '0');
            osc3_note_step   <= to_unsigned(0, osc3_note_step'length);
            osc3_note_period <= to_unsigned(0, osc3_note_period'length);
            osc4_note        <= (others => '0');
            osc4_note_step   <= to_unsigned(0, osc4_note_step'length);
            osc4_note_period <= to_unsigned(0, osc4_note_period'length);
            osc5_note        <= (others => '0');
            osc5_note_step   <= to_unsigned(0, osc5_note_step'length);
            osc5_note_period <= to_unsigned(0, osc5_note_period'length);
            osc6_note        <= (others => '0');
            osc6_note_step   <= to_unsigned(0, osc6_note_step'length);
            osc6_note_period <= to_unsigned(0, osc6_note_period'length);
            osc7_note        <= (others => '0');
            osc7_note_step   <= to_unsigned(0, osc7_note_step'length);
            osc7_note_period <= to_unsigned(0, osc7_note_period'length);
            osc8_note        <= (others => '0');
            osc8_note_step   <= to_unsigned(0, osc8_note_step'length);
            osc8_note_period <= to_unsigned(0, osc8_note_period'length);
            osc9_note        <= (others => '0');
            osc9_note_step   <= to_unsigned(0, osc9_note_step'length);
            osc9_note_period <= to_unsigned(0, osc9_note_period'length);
            osc10_note        <= (others => '0');
            osc10_note_step   <= to_unsigned(0, osc10_note_step'length);
            osc10_note_period <= to_unsigned(0, osc10_note_period'length);
            osc11_note        <= (others => '0');
            osc11_note_step   <= to_unsigned(0, osc11_note_step'length);
            osc11_note_period <= to_unsigned(0, osc11_note_period'length);
            osc12_note        <= (others => '0');
            osc12_note_step   <= to_unsigned(0, osc12_note_step'length);
            osc12_note_period <= to_unsigned(0, osc12_note_period'length);
            osc13_note        <= (others => '0');
            osc13_note_step   <= to_unsigned(0, osc13_note_step'length);
            osc13_note_period <= to_unsigned(0, osc13_note_period'length);
            osc14_note        <= (others => '0');
            osc14_note_step   <= to_unsigned(0, osc14_note_step'length);
            osc14_note_period <= to_unsigned(0, osc14_note_period'length);
            osc15_note        <= (others => '0');
            osc15_note_step   <= to_unsigned(0, osc15_note_step'length);
            osc15_note_period <= to_unsigned(0, osc15_note_period'length);

        elsif rising_edge(clk) then
            if as_write = '1' then
                case as_address is
                    when REG_START_OFFSET =>
                        reg_on <= '1';

                    when REG_STOP_OFFSET =>
                        reg_on           <= '0';
                        osc0_note        <= (others => '0');
                        osc0_note_step   <= to_unsigned(0, osc0_note_step'length);
                        osc0_note_period <= to_unsigned(0, osc0_note_period'length);
                        osc1_note        <= (others => '0');
                        osc1_note_step   <= to_unsigned(0, osc1_note_step'length);
                        osc1_note_period <= to_unsigned(0, osc1_note_period'length);
                        osc2_note        <= (others => '0');
                        osc2_note_step   <= to_unsigned(0, osc2_note_step'length);
                        osc2_note_period <= to_unsigned(0, osc2_note_period'length);
                        osc3_note        <= (others => '0');
                        osc3_note_step   <= to_unsigned(0, osc3_note_step'length);
                        osc3_note_period <= to_unsigned(0, osc3_note_period'length);
                        osc4_note        <= (others => '0');
                        osc4_note_step   <= to_unsigned(0, osc4_note_step'length);
                        osc4_note_period <= to_unsigned(0, osc4_note_period'length);
                        osc5_note        <= (others => '0');
                        osc5_note_step   <= to_unsigned(0, osc5_note_step'length);
                        osc5_note_period <= to_unsigned(0, osc5_note_period'length);
                        osc6_note        <= (others => '0');
                        osc6_note_step   <= to_unsigned(0, osc6_note_step'length);
                        osc6_note_period <= to_unsigned(0, osc6_note_period'length);
                        osc7_note        <= (others => '0');
                        osc7_note_step   <= to_unsigned(0, osc7_note_step'length);
                        osc7_note_period <= to_unsigned(0, osc7_note_period'length);
                        osc8_note        <= (others => '0');
                        osc8_note_step   <= to_unsigned(0, osc8_note_step'length);
                        osc8_note_period <= to_unsigned(0, osc8_note_period'length);
                        osc9_note        <= (others => '0');
                        osc9_note_step   <= to_unsigned(0, osc9_note_step'length);
                        osc9_note_period <= to_unsigned(0, osc9_note_period'length);
                        osc10_note        <= (others => '0');
                        osc10_note_step   <= to_unsigned(0, osc10_note_step'length);
                        osc10_note_period <= to_unsigned(0, osc10_note_period'length);
                        osc11_note        <= (others => '0');
                        osc11_note_step   <= to_unsigned(0, osc11_note_step'length);
                        osc11_note_period <= to_unsigned(0, osc11_note_period'length);
                        osc12_note        <= (others => '0');
                        osc12_note_step   <= to_unsigned(0, osc12_note_step'length);
                        osc12_note_period <= to_unsigned(0, osc12_note_period'length);
                        osc13_note        <= (others => '0');
                        osc13_note_step   <= to_unsigned(0, osc13_note_step'length);
                        osc13_note_period <= to_unsigned(0, osc13_note_period'length);
                        osc14_note        <= (others => '0');
                        osc14_note_step   <= to_unsigned(0, osc14_note_step'length);
                        osc14_note_period <= to_unsigned(0, osc14_note_period'length);
                        osc15_note        <= (others => '0');
                        osc15_note_step   <= to_unsigned(0, osc15_note_step'length);
                        osc15_note_period <= to_unsigned(0, osc15_note_period'length);

                    when REG_MIDI_MSG_OFFSET =>
                        case to_integer(unsigned(as_writedata(23 downto 16))) is
                            when 16#90# =>
                                -- save note_step if MIDI event is note ON (0x90)
                                if to_integer(unsigned(osc0_note(15 downto 8))) = 0 then
                                    -- this osc0 is empty, play the note on it
                                    osc0_note        <= as_writedata;
                                    osc0_note_step   <= linear_diff_result;
                                    osc0_note_period <= period_samples_result;

                                elsif to_integer(unsigned(osc1_note(15 downto 8))) = 0 then
                                    -- this osc1 is empty, play the note on it
                                    osc1_note        <= as_writedata;
                                    osc1_note_step   <= linear_diff_result;
                                    osc1_note_period <= period_samples_result;

                                elsif to_integer(unsigned(osc2_note(15 downto 8))) = 0 then
                                    -- this osc2 is empty, play the note on it
                                    osc2_note        <= as_writedata;
                                    osc2_note_step   <= linear_diff_result;
                                    osc2_note_period <= period_samples_result;

                                elsif to_integer(unsigned(osc3_note(15 downto 8))) = 0 then
                                    -- this osc3 is empty, play the note on it
                                    osc3_note        <= as_writedata;
                                    osc3_note_step   <= linear_diff_result;
                                    osc3_note_period <= period_samples_result;

                                elsif to_integer(unsigned(osc4_note(15 downto 8))) = 0 then
                                    -- this osc4 is empty, play the note on it
                                    osc4_note        <= as_writedata;
                                    osc4_note_step   <= linear_diff_result;
                                    osc4_note_period <= period_samples_result;

                                elsif to_integer(unsigned(osc5_note(15 downto 8))) = 0 then
                                    -- this osc5 is empty, play the note on it
                                    osc5_note        <= as_writedata;
                                    osc5_note_step   <= linear_diff_result;
                                    osc5_note_period <= period_samples_result;

                                elsif to_integer(unsigned(osc6_note(15 downto 8))) = 0 then
                                    -- this osc6 is empty, play the note on it
                                    osc6_note        <= as_writedata;
                                    osc6_note_step   <= linear_diff_result;
                                    osc6_note_period <= period_samples_result;

                                elsif to_integer(unsigned(osc7_note(15 downto 8))) = 0 then
                                    -- this osc7 is empty, play the note on it
                                    osc7_note        <= as_writedata;
                                    osc7_note_step   <= linear_diff_result;
                                    osc7_note_period <= period_samples_result;

                                elsif to_integer(unsigned(osc8_note(15 downto 8))) = 0 then
                                    -- this osc8 is empty, play the note on it
                                    osc8_note        <= as_writedata;
                                    osc8_note_step   <= linear_diff_result;
                                    osc8_note_period <= period_samples_result;

                                elsif to_integer(unsigned(osc9_note(15 downto 8))) = 0 then
                                    -- this osc9 is empty, play the note on it
                                    osc9_note        <= as_writedata;
                                    osc9_note_step   <= linear_diff_result;
                                    osc9_note_period <= period_samples_result;

                                elsif to_integer(unsigned(osc10_note(15 downto 8))) = 0 then
                                    -- this osc10 is empty, play the note on it
                                    osc10_note        <= as_writedata;
                                    osc10_note_step   <= linear_diff_result;
                                    osc10_note_period <= period_samples_result;

                                elsif to_integer(unsigned(osc11_note(15 downto 8))) = 0 then
                                    -- this osc11 is empty, play the note on it
                                    osc11_note        <= as_writedata;
                                    osc11_note_step   <= linear_diff_result;
                                    osc11_note_period <= period_samples_result;

                                elsif to_integer(unsigned(osc12_note(15 downto 8))) = 0 then
                                    -- this osc12 is empty, play the note on it
                                    osc12_note        <= as_writedata;
                                    osc12_note_step   <= linear_diff_result;
                                    osc12_note_period <= period_samples_result;

                                elsif to_integer(unsigned(osc13_note(15 downto 8))) = 0 then
                                    -- this osc13 is empty, play the note on it
                                    osc13_note        <= as_writedata;
                                    osc13_note_step   <= linear_diff_result;
                                    osc13_note_period <= period_samples_result;

                                elsif to_integer(unsigned(osc14_note(15 downto 8))) = 0 then
                                    -- this osc14 is empty, play the note on it
                                    osc14_note        <= as_writedata;
                                    osc14_note_step   <= linear_diff_result;
                                    osc14_note_period <= period_samples_result;

                                elsif to_integer(unsigned(osc15_note(15 downto 8))) = 0 then
                                    -- this osc15 is empty, play the note on it
                                    osc15_note        <= as_writedata;
                                    osc15_note_step   <= linear_diff_result;
                                    osc15_note_period <= period_samples_result;

                                end if;

                            when 16#80# =>
                                -- find all oscillators playing this note and stop them
                                -- if MIDI event is note OFF (0x80)
                                if osc0_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc0 is playing this note, stop it
                                    osc0_note        <= (others => '0');
                                    osc0_note_step   <= to_unsigned(0, osc0_note_step'length);
                                    osc0_note_period <= to_unsigned(0, osc0_note_step'length);
                                end if;

                                if osc1_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc1 is playing this note, stop it
                                    osc1_note        <= (others => '0');
                                    osc1_note_step   <= to_unsigned(0, osc1_note_step'length);
                                    osc1_note_period <= to_unsigned(0, osc1_note_step'length);
                                end if;

                                if osc2_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc2 is playing this note, stop it
                                    osc2_note        <= (others => '0');
                                    osc2_note_step   <= to_unsigned(0, osc2_note_step'length);
                                    osc2_note_period <= to_unsigned(0, osc2_note_step'length);
                                end if;

                                if osc3_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc3 is playing this note, stop it
                                    osc3_note        <= (others => '0');
                                    osc3_note_step   <= to_unsigned(0, osc3_note_step'length);
                                    osc3_note_period <= to_unsigned(0, osc3_note_step'length);
                                end if;

                                if osc4_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc4 is playing this note, stop it
                                    osc4_note        <= (others => '0');
                                    osc4_note_step   <= to_unsigned(0, osc4_note_step'length);
                                    osc4_note_period <= to_unsigned(0, osc4_note_step'length);
                                end if;

                                if osc5_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc5 is playing this note, stop it
                                    osc5_note        <= (others => '0');
                                    osc5_note_step   <= to_unsigned(0, osc5_note_step'length);
                                    osc5_note_period <= to_unsigned(0, osc5_note_step'length);
                                end if;

                                if osc6_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc6 is playing this note, stop it
                                    osc6_note        <= (others => '0');
                                    osc6_note_step   <= to_unsigned(0, osc6_note_step'length);
                                    osc6_note_period <= to_unsigned(0, osc6_note_step'length);
                                end if;

                                if osc7_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc7 is playing this note, stop it
                                    osc7_note        <= (others => '0');
                                    osc7_note_step   <= to_unsigned(0, osc7_note_step'length);
                                    osc7_note_period <= to_unsigned(0, osc7_note_step'length);
                                end if;

                                if osc8_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc8 is playing this note, stop it
                                    osc8_note        <= (others => '0');
                                    osc8_note_step   <= to_unsigned(0, osc8_note_step'length);
                                    osc8_note_period <= to_unsigned(0, osc8_note_step'length);
                                end if;

                                if osc9_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc9 is playing this note, stop it
                                    osc9_note        <= (others => '0');
                                    osc9_note_step   <= to_unsigned(0, osc9_note_step'length);
                                    osc9_note_period <= to_unsigned(0, osc9_note_step'length);
                                end if;

                                if osc10_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc10 is playing this note, stop it
                                    osc10_note        <= (others => '0');
                                    osc10_note_step   <= to_unsigned(0, osc10_note_step'length);
                                    osc10_note_period <= to_unsigned(0, osc10_note_step'length);
                                end if;

                                if osc11_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc11 is playing this note, stop it
                                    osc11_note        <= (others => '0');
                                    osc11_note_step   <= to_unsigned(0, osc11_note_step'length);
                                    osc11_note_period <= to_unsigned(0, osc11_note_step'length);
                                end if;

                                if osc12_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc12 is playing this note, stop it
                                    osc12_note        <= (others => '0');
                                    osc12_note_step   <= to_unsigned(0, osc12_note_step'length);
                                    osc12_note_period <= to_unsigned(0, osc12_note_step'length);
                                end if;

                                if osc13_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc13 is playing this note, stop it
                                    osc13_note        <= (others => '0');
                                    osc13_note_step   <= to_unsigned(0, osc13_note_step'length);
                                    osc13_note_period <= to_unsigned(0, osc13_note_step'length);
                                end if;

                                if osc14_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc14 is playing this note, stop it
                                    osc14_note        <= (others => '0');
                                    osc14_note_step   <= to_unsigned(0, osc14_note_step'length);
                                    osc14_note_period <= to_unsigned(0, osc14_note_step'length);
                                end if;

                                if osc15_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc15 is playing this note, stop it
                                    osc15_note        <= (others => '0');
                                    osc15_note_step   <= to_unsigned(0, osc15_note_step'length);
                                    osc15_note_period <= to_unsigned(0, osc15_note_step'length);
                                end if;

                            when others =>
                                null;
                        end case;

                    when REG_OSC_MODE_OFFSET =>
                        reg_osc_mode <= unsigned(as_writedata);

                    when others =>
                        null;
                end case;
            end if;
        end if;
    end process as_write_process;

    -- generates the 96000 Hz pulse slow "clock"
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

            if (sclk_counter < 125) then
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
                        sample_bits_counter <= 63;
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
        aud_clk12   => aud_clk12,
        sclk_en     => sclk_en,
        reset_n     => reset_n,
        reg_on      => reg_on,
        osc_mode    => reg_osc_mode,
        note        => osc0_note,
        note_step   => osc0_note_step,
        note_period => osc0_note_period,
        osc_out     => osc0_out
    );
    -- oscillator osc1 instance
    osc1 : osc port map(
        aud_clk12   => aud_clk12,
        sclk_en     => sclk_en,
        reset_n     => reset_n,
        reg_on      => reg_on,
        osc_mode    => reg_osc_mode,
        note        => osc1_note,
        note_step   => osc1_note_step,
        note_period => osc1_note_period,
        osc_out     => osc1_out
    );
    -- oscillator osc2 instance
    osc2 : osc port map(
        aud_clk12   => aud_clk12,
        sclk_en     => sclk_en,
        reset_n     => reset_n,
        reg_on      => reg_on,
        osc_mode    => reg_osc_mode,
        note        => osc2_note,
        note_step   => osc2_note_step,
        note_period => osc2_note_period,
        osc_out     => osc2_out
    );
    -- oscillator osc3 instance
    osc3 : osc port map(
        aud_clk12   => aud_clk12,
        sclk_en     => sclk_en,
        reset_n     => reset_n,
        reg_on      => reg_on,
        osc_mode    => reg_osc_mode,
        note        => osc3_note,
        note_step   => osc3_note_step,
        note_period => osc3_note_period,
        osc_out     => osc3_out
    );
    -- oscillator osc4 instance
    osc4 : osc port map(
        aud_clk12   => aud_clk12,
        sclk_en     => sclk_en,
        reset_n     => reset_n,
        reg_on      => reg_on,
        osc_mode    => reg_osc_mode,
        note        => osc4_note,
        note_step   => osc4_note_step,
        note_period => osc4_note_period,
        osc_out     => osc4_out
    );
    -- oscillator osc5 instance
    osc5 : osc port map(
        aud_clk12   => aud_clk12,
        sclk_en     => sclk_en,
        reset_n     => reset_n,
        reg_on      => reg_on,
        osc_mode    => reg_osc_mode,
        note        => osc5_note,
        note_step   => osc5_note_step,
        note_period => osc5_note_period,
        osc_out     => osc5_out
    );
    -- oscillator osc6 instance
    osc6 : osc port map(
        aud_clk12   => aud_clk12,
        sclk_en     => sclk_en,
        reset_n     => reset_n,
        reg_on      => reg_on,
        osc_mode    => reg_osc_mode,
        note        => osc6_note,
        note_step   => osc6_note_step,
        note_period => osc6_note_period,
        osc_out     => osc6_out
    );
    -- oscillator osc7 instance
    osc7 : osc port map(
        aud_clk12   => aud_clk12,
        sclk_en     => sclk_en,
        reset_n     => reset_n,
        reg_on      => reg_on,
        osc_mode    => reg_osc_mode,
        note        => osc7_note,
        note_step   => osc7_note_step,
        note_period => osc7_note_period,
        osc_out     => osc7_out
    );
    -- oscillator osc8 instance
    osc8 : osc port map(
        aud_clk12   => aud_clk12,
        sclk_en     => sclk_en,
        reset_n     => reset_n,
        reg_on      => reg_on,
        osc_mode    => reg_osc_mode,
        note        => osc8_note,
        note_step   => osc8_note_step,
        note_period => osc8_note_period,
        osc_out     => osc8_out
    );
    -- oscillator osc9 instance
    osc9 : osc port map(
        aud_clk12   => aud_clk12,
        sclk_en     => sclk_en,
        reset_n     => reset_n,
        reg_on      => reg_on,
        osc_mode    => reg_osc_mode,
        note        => osc9_note,
        note_step   => osc9_note_step,
        note_period => osc9_note_period,
        osc_out     => osc9_out
    );
    -- oscillator osc10 instance
    osc10 : osc port map(
        aud_clk12   => aud_clk12,
        sclk_en     => sclk_en,
        reset_n     => reset_n,
        reg_on      => reg_on,
        osc_mode    => reg_osc_mode,
        note        => osc10_note,
        note_step   => osc10_note_step,
        note_period => osc10_note_period,
        osc_out     => osc10_out
    );
    -- oscillator osc11 instance
    osc11 : osc port map(
        aud_clk12   => aud_clk12,
        sclk_en     => sclk_en,
        reset_n     => reset_n,
        reg_on      => reg_on,
        osc_mode    => reg_osc_mode,
        note        => osc11_note,
        note_step   => osc11_note_step,
        note_period => osc11_note_period,
        osc_out     => osc11_out
    );
    -- oscillator osc12 instance
    osc12 : osc port map(
        aud_clk12   => aud_clk12,
        sclk_en     => sclk_en,
        reset_n     => reset_n,
        reg_on      => reg_on,
        osc_mode    => reg_osc_mode,
        note        => osc12_note,
        note_step   => osc12_note_step,
        note_period => osc12_note_period,
        osc_out     => osc12_out
    );
    -- oscillator osc13 instance
    osc13 : osc port map(
        aud_clk12   => aud_clk12,
        sclk_en     => sclk_en,
        reset_n     => reset_n,
        reg_on      => reg_on,
        osc_mode    => reg_osc_mode,
        note        => osc13_note,
        note_step   => osc13_note_step,
        note_period => osc13_note_period,
        osc_out     => osc13_out
    );
    -- oscillator osc14 instance
    osc14 : osc port map(
        aud_clk12   => aud_clk12,
        sclk_en     => sclk_en,
        reset_n     => reset_n,
        reg_on      => reg_on,
        osc_mode    => reg_osc_mode,
        note        => osc14_note,
        note_step   => osc14_note_step,
        note_period => osc14_note_period,
        osc_out     => osc14_out
    );
    -- oscillator osc15 instance
    osc15 : osc port map(
        aud_clk12   => aud_clk12,
        sclk_en     => sclk_en,
        reset_n     => reset_n,
        reg_on      => reg_on,
        osc_mode    => reg_osc_mode,
        note        => osc15_note,
        note_step   => osc15_note_step,
        note_period => osc15_note_period,
        osc_out     => osc15_out
    );

    -- mixes sound from generators into the final audio sample
    mixer : process (aud_clk12, reset_n)
    begin
        if reset_n = '0' then
            audio  <= (others => '0');
            sample <= to_signed(0, sample'length);

        elsif falling_edge(aud_clk12) then
            if reg_on = '1' and sclk_en = '1' then
                sample <= osc0_out + osc1_out + osc2_out + osc3_out + osc4_out + osc5_out + osc6_out + osc7_out + osc8_out + osc9_out + osc10_out + osc11_out + osc12_out + osc13_out + osc14_out + osc15_out;

                -- mix samples in mono: left and right channels get assigned the same sample
                audio(63 downto 32) <= std_logic_vector(sample);
                audio(31 downto 0)  <= std_logic_vector(sample);

            elsif reg_on = '0' then
                sample <= to_signed(0, sample'length);
            end if;
        end if;
    end process mixer;

    -- VU meter expnonential smoothing update process
    vu_meter_smoothing : process (aud_clk12, reset_n)
        variable prev_vu_meter_dec : signed(vu_meter_value'length - 1 downto 0) := (others => '0');
        variable sample_dec        : signed(sample'length - 1 downto 0)         := (others => '0');
    begin
        if reset_n = '0' then
            vu_meter_value <= (others => '0');
        elsif falling_edge(aud_clk12) then
            if sclk_en = '1' then
                -- compute (1 - decay) * previous vu_meter
                prev_vu_meter_dec := vu_meter_value - shift_right(vu_meter_value, 2);
                -- compute abs(decay * current sample)
                sample_dec := shift_right(sample, 2);
                if sample_dec < 0 then
                    sample_dec := - sample_dec;
                end if;
                -- compute exponential smoothing
                if sample'length >= vu_meter'length then
                    vu_meter_value <= prev_vu_meter_dec + sample_dec(sample_dec'length - 1 downto sample_dec'length - vu_meter'length);
                else
                    vu_meter_value(sample'length - 1 downto 0)                     <= prev_vu_meter_dec(prev_vu_meter_dec'length - 1 downto prev_vu_meter_dec'length - sample'length) + sample_dec;
                    vu_meter_value(vu_meter_value'length - 1 downto sample'length) <= (others => '0');
                end if;
            end if;
        end if;
    end process vu_meter_smoothing;

    -- VU meter conversion to unary process
    vu_meter_unary_conversion : process (aud_clk12, reset_n)
    begin
        if reset_n = '0' then
            vu_meter <= (others => '0');
        elsif falling_edge(aud_clk12) then
            if sclk_en = '1' then
                if to_integer(vu_meter_value) < 1 then
                    vu_meter <= "0000000001";
                elsif to_integer(vu_meter_value) < 2 then
                    vu_meter <= "0000000011";
                elsif to_integer(vu_meter_value) < 4 then
                    vu_meter <= "0000000111";
                elsif to_integer(vu_meter_value) < 8 then
                    vu_meter <= "0000001111";
                elsif to_integer(vu_meter_value) < 16 then
                    vu_meter <= "0000011111";
                elsif to_integer(vu_meter_value) < 32 then
                    vu_meter <= "0000111111";
                elsif to_integer(vu_meter_value) < 64 then
                    vu_meter <= "0001111111";
                elsif to_integer(vu_meter_value) < 128 then
                    vu_meter <= "0011111111";
                elsif to_integer(vu_meter_value) < 256 then
                    vu_meter <= "0111111111";
                elsif to_integer(vu_meter_value) < 512 then
                    vu_meter <= "1111111111";
                end if;
            end if;
        end if;
    end process vu_meter_unary_conversion;

end architecture rtl;

-- DO NOT CHANGE THIS FILE DIRECTLY, INSTEAD CHANGE sound_gen.py!