--
-- Sound synthesizer master generator
-- Computes final audio samples to be sent to the WM8731 audio codec
--
-- DO NOT CHANGE THIS FILE DIRECTLY, INSTEAD CHANGE sound_gen.py!
--
-- file:                sound_gen.vhd
-- auto-generated from: sound_gen.py
-- last generated:      2020-06-13
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

    -- internal register
    signal reg_on : std_logic;

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
    signal linear_diff_result : unsigned(31 downto 0);
    component linear_diff
        port (
            midi_note_code   : in std_logic_vector(7 downto 0);
            note_linear_diff : out unsigned(31 downto 0)
        );
    end component linear_diff;

    -- oscillator component
    component osc
        port (
            aud_clk12 : in std_logic;
            sclk_en   : in std_logic;
            reset_n   : in std_logic;
            reg_on    : in std_logic;
            note      : in std_logic_vector(31 downto 0);
            note_step : in unsigned(31 downto 0);
            osc_out   : out signed(31 downto 0)
        );
    end component osc;

    -- registers for oscillator instance osc0
    signal osc0_note_step : unsigned(31 downto 0);
    signal osc0_note      : std_logic_vector(31 downto 0);
    signal osc0_out       : signed(31 downto 0);
    -- registers for oscillator instance osc1
    signal osc1_note_step : unsigned(31 downto 0);
    signal osc1_note      : std_logic_vector(31 downto 0);
    signal osc1_out       : signed(31 downto 0);
    -- registers for oscillator instance osc2
    signal osc2_note_step : unsigned(31 downto 0);
    signal osc2_note      : std_logic_vector(31 downto 0);
    signal osc2_out       : signed(31 downto 0);
    -- registers for oscillator instance osc3
    signal osc3_note_step : unsigned(31 downto 0);
    signal osc3_note      : std_logic_vector(31 downto 0);
    signal osc3_out       : signed(31 downto 0);
    -- registers for oscillator instance osc4
    signal osc4_note_step : unsigned(31 downto 0);
    signal osc4_note      : std_logic_vector(31 downto 0);
    signal osc4_out       : signed(31 downto 0);
    -- registers for oscillator instance osc5
    signal osc5_note_step : unsigned(31 downto 0);
    signal osc5_note      : std_logic_vector(31 downto 0);
    signal osc5_out       : signed(31 downto 0);
    -- registers for oscillator instance osc6
    signal osc6_note_step : unsigned(31 downto 0);
    signal osc6_note      : std_logic_vector(31 downto 0);
    signal osc6_out       : signed(31 downto 0);
    -- registers for oscillator instance osc7
    signal osc7_note_step : unsigned(31 downto 0);
    signal osc7_note      : std_logic_vector(31 downto 0);
    signal osc7_out       : signed(31 downto 0);
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
            osc1_note      <= (others => '0');
            osc1_note_step <= to_unsigned(0, osc1_note_step'length);
            osc2_note      <= (others => '0');
            osc2_note_step <= to_unsigned(0, osc2_note_step'length);
            osc3_note      <= (others => '0');
            osc3_note_step <= to_unsigned(0, osc3_note_step'length);
            osc4_note      <= (others => '0');
            osc4_note_step <= to_unsigned(0, osc4_note_step'length);
            osc5_note      <= (others => '0');
            osc5_note_step <= to_unsigned(0, osc5_note_step'length);
            osc6_note      <= (others => '0');
            osc6_note_step <= to_unsigned(0, osc6_note_step'length);
            osc7_note      <= (others => '0');
            osc7_note_step <= to_unsigned(0, osc7_note_step'length);

        elsif rising_edge(clk) then
            if as_write = '1' then
                case as_address is
                    when REG_START_OFFSET =>
                        reg_on <= '1';
                    when REG_STOP_OFFSET =>
                        reg_on <= '0';
                        osc0_note      <= (others => '0');
                        osc0_note_step <= to_unsigned(0, osc0_note_step'length);
                        osc1_note      <= (others => '0');
                        osc1_note_step <= to_unsigned(0, osc1_note_step'length);
                        osc2_note      <= (others => '0');
                        osc2_note_step <= to_unsigned(0, osc2_note_step'length);
                        osc3_note      <= (others => '0');
                        osc3_note_step <= to_unsigned(0, osc3_note_step'length);
                        osc4_note      <= (others => '0');
                        osc4_note_step <= to_unsigned(0, osc4_note_step'length);
                        osc5_note      <= (others => '0');
                        osc5_note_step <= to_unsigned(0, osc5_note_step'length);
                        osc6_note      <= (others => '0');
                        osc6_note_step <= to_unsigned(0, osc6_note_step'length);
                        osc7_note      <= (others => '0');
                        osc7_note_step <= to_unsigned(0, osc7_note_step'length);

                    when REG_MIDI_MSG_OFFSET =>
                        case to_integer(unsigned(as_writedata(23 downto 16))) is
                            when 16#90# =>
                                -- save note_step if MIDI event is note ON (0x90)
                                if to_integer(unsigned(osc0_note(15 downto 8))) = 0 then
                                    -- this osc0 is empty, play the note on it
                                    osc0_note      <= as_writedata;
                                    osc0_note_step <= linear_diff_result;

                                elsif to_integer(unsigned(osc1_note(15 downto 8))) = 0 then
                                    -- this osc1 is empty, play the note on it
                                    osc1_note      <= as_writedata;
                                    osc1_note_step <= linear_diff_result;

                                elsif to_integer(unsigned(osc2_note(15 downto 8))) = 0 then
                                    -- this osc2 is empty, play the note on it
                                    osc2_note      <= as_writedata;
                                    osc2_note_step <= linear_diff_result;

                                elsif to_integer(unsigned(osc3_note(15 downto 8))) = 0 then
                                    -- this osc3 is empty, play the note on it
                                    osc3_note      <= as_writedata;
                                    osc3_note_step <= linear_diff_result;

                                elsif to_integer(unsigned(osc4_note(15 downto 8))) = 0 then
                                    -- this osc4 is empty, play the note on it
                                    osc4_note      <= as_writedata;
                                    osc4_note_step <= linear_diff_result;

                                elsif to_integer(unsigned(osc5_note(15 downto 8))) = 0 then
                                    -- this osc5 is empty, play the note on it
                                    osc5_note      <= as_writedata;
                                    osc5_note_step <= linear_diff_result;

                                elsif to_integer(unsigned(osc6_note(15 downto 8))) = 0 then
                                    -- this osc6 is empty, play the note on it
                                    osc6_note      <= as_writedata;
                                    osc6_note_step <= linear_diff_result;

                                elsif to_integer(unsigned(osc7_note(15 downto 8))) = 0 then
                                    -- this osc7 is empty, play the note on it
                                    osc7_note      <= as_writedata;
                                    osc7_note_step <= linear_diff_result;

                                end if;

                            when 16#80# =>
                                -- find all oscillators playing this note and stop them
                                -- if MIDI event is note OFF (0x80)
                                if osc0_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc0 is playing this note, stop it
                                    osc0_note      <= (others => '0');
                                    osc0_note_step <= to_unsigned(0, osc0_note_step'length);
                                end if;

                                if osc1_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc1 is playing this note, stop it
                                    osc1_note      <= (others => '0');
                                    osc1_note_step <= to_unsigned(0, osc1_note_step'length);
                                end if;

                                if osc2_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc2 is playing this note, stop it
                                    osc2_note      <= (others => '0');
                                    osc2_note_step <= to_unsigned(0, osc2_note_step'length);
                                end if;

                                if osc3_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc3 is playing this note, stop it
                                    osc3_note      <= (others => '0');
                                    osc3_note_step <= to_unsigned(0, osc3_note_step'length);
                                end if;

                                if osc4_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc4 is playing this note, stop it
                                    osc4_note      <= (others => '0');
                                    osc4_note_step <= to_unsigned(0, osc4_note_step'length);
                                end if;

                                if osc5_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc5 is playing this note, stop it
                                    osc5_note      <= (others => '0');
                                    osc5_note_step <= to_unsigned(0, osc5_note_step'length);
                                end if;

                                if osc6_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc6 is playing this note, stop it
                                    osc6_note      <= (others => '0');
                                    osc6_note_step <= to_unsigned(0, osc6_note_step'length);
                                end if;

                                if osc7_note(15 downto 8) = as_writedata(15 downto 8) then
                                    -- this osc7 is playing this note, stop it
                                    osc7_note      <= (others => '0');
                                    osc7_note_step <= to_unsigned(0, osc7_note_step'length);
                                end if;

                            when others =>
                                null;
                        end case;
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
        aud_clk12 => aud_clk12,
        sclk_en   => sclk_en,
        reset_n   => reset_n,
        reg_on    => reg_on,
        note      => osc0_note,
        note_step => osc0_note_step,
        osc_out   => osc0_out
    );
    -- oscillator osc1 instance
    osc1 : osc port map(
        aud_clk12 => aud_clk12,
        sclk_en   => sclk_en,
        reset_n   => reset_n,
        reg_on    => reg_on,
        note      => osc1_note,
        note_step => osc1_note_step,
        osc_out   => osc1_out
    );
    -- oscillator osc2 instance
    osc2 : osc port map(
        aud_clk12 => aud_clk12,
        sclk_en   => sclk_en,
        reset_n   => reset_n,
        reg_on    => reg_on,
        note      => osc2_note,
        note_step => osc2_note_step,
        osc_out   => osc2_out
    );
    -- oscillator osc3 instance
    osc3 : osc port map(
        aud_clk12 => aud_clk12,
        sclk_en   => sclk_en,
        reset_n   => reset_n,
        reg_on    => reg_on,
        note      => osc3_note,
        note_step => osc3_note_step,
        osc_out   => osc3_out
    );
    -- oscillator osc4 instance
    osc4 : osc port map(
        aud_clk12 => aud_clk12,
        sclk_en   => sclk_en,
        reset_n   => reset_n,
        reg_on    => reg_on,
        note      => osc4_note,
        note_step => osc4_note_step,
        osc_out   => osc4_out
    );
    -- oscillator osc5 instance
    osc5 : osc port map(
        aud_clk12 => aud_clk12,
        sclk_en   => sclk_en,
        reset_n   => reset_n,
        reg_on    => reg_on,
        note      => osc5_note,
        note_step => osc5_note_step,
        osc_out   => osc5_out
    );
    -- oscillator osc6 instance
    osc6 : osc port map(
        aud_clk12 => aud_clk12,
        sclk_en   => sclk_en,
        reset_n   => reset_n,
        reg_on    => reg_on,
        note      => osc6_note,
        note_step => osc6_note_step,
        osc_out   => osc6_out
    );
    -- oscillator osc7 instance
    osc7 : osc port map(
        aud_clk12 => aud_clk12,
        sclk_en   => sclk_en,
        reset_n   => reset_n,
        reg_on    => reg_on,
        note      => osc7_note,
        note_step => osc7_note_step,
        osc_out   => osc7_out
    );

    -- mixes sound from generators into the final audio sample
    mixer : process (aud_clk12, reset_n)
    begin
        if reset_n = '0' then
            audio  <= (others => '0');
            sample <= to_signed(0, sample'length);

        elsif falling_edge(aud_clk12) then
            if reg_on = '1' and sclk_en = '1' then
                sample <= osc0_out + osc1_out + osc2_out + osc3_out + osc4_out + osc5_out + osc6_out + osc7_out;

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
        variable sample_dec        : signed(sample'length - 1 downto 0)            := (others => '0');
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
                    sample_dec := -sample_dec;
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
                    vu_meter <= "0000000000";
                elsif to_integer(vu_meter_value) < 2 then
                    vu_meter <= "0000000001";
                elsif to_integer(vu_meter_value) < 4 then
                    vu_meter <= "0000000011";
                elsif to_integer(vu_meter_value) < 8 then
                    vu_meter <= "0000000111";
                elsif to_integer(vu_meter_value) < 16 then
                    vu_meter <= "0000001111";
                elsif to_integer(vu_meter_value) < 32 then
                    vu_meter <= "0000011111";
                elsif to_integer(vu_meter_value) < 64 then
                    vu_meter <= "0000111111";
                elsif to_integer(vu_meter_value) < 128 then
                    vu_meter <= "0001111111";
                end if;
            end if;
        end if;
    end process vu_meter_unary_conversion;

end architecture rtl;

-- DO NOT CHANGE THIS FILE DIRECTLY, INSTEAD CHANGE sound_gen.py!