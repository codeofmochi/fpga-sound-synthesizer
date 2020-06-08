--
-- Sound synthesizer master generator
-- Computes final audio samples to be sent to the WM8731 audio codec
--
-- file: sound_gen.vhd
-- author: Alexandre CHAU & Loïc DROZ
-- date: 08/06/2020
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

architecture fsm of sound_gen is
    -- register map
    constant REG_START_OFFSET : std_logic_vector(as_address'length - 1 downto 0) := "00";
    constant REG_STOP_OFFSET  : std_logic_vector(as_address'length - 1 downto 0) := "01";
    constant REG_NOTE_OFFSET  : std_logic_vector(as_address'length - 1 downto 0) := "10";

    -- internal register
    signal reg_on    : std_logic;
    signal note_step : unsigned(31 downto 0);

    -- slow clock at 48 KHz
    signal sclk_counter : integer range 0 to 255;
    signal sclk_en      : std_logic;

    -- sound fsm
    type state_type is (Q_IDLE, Q_SEND);
    signal state               : state_type;
    signal sample_bits_counter : integer range 0 to 31;

    -- oscillator
    signal audio  : std_logic_vector(31 downto 0);
    signal sample : integer range 0 to integer'high;
begin
    -- writes to the status registers on Avalon writes
    as_write_process : process (clk, reset_n)
        variable octave_shift : integer range -3 to 2;
    begin
        if reset_n = '0' then
            reg_on    <= '0';
            note_step <= to_unsigned(0, note_step'length);

        elsif rising_edge(clk) then
            if as_write = '1' then
                case as_address is
                    when REG_START_OFFSET =>
                        reg_on <= '1';
                    when REG_STOP_OFFSET =>
                        reg_on <= '0';
                    when REG_NOTE_OFFSET =>
                        octave_shift := to_integer(unsigned(as_writedata(6 downto 4))) - 5;
                        -- if note is A, A# or B, must compensate for lower octave 
                        if to_integer(unsigned(as_writedata(3 downto 0))) <= 2 then
                            octave_shift := octave_shift + 1;
                        end if;

                        -- assign note step given shift and sample value delta
                        case to_integer(unsigned(as_writedata(3 downto 0))) is
                            when 0 =>
                                if octave_shift < 0 then
                                    note_step <= shift_right(to_unsigned(601, note_step'length), 0 - octave_shift);
                                elsif octave_shift > 0 then
                                    note_step <= shift_left(to_unsigned(601, note_step'length), octave_shift);
                                else
                                    note_step <= to_unsigned(601, note_step'length);
                                end if;
                            when 1 =>
                                if octave_shift < 0 then
                                    note_step <= shift_right(to_unsigned(636, note_step'length), 0 - octave_shift);
                                elsif octave_shift > 0 then
                                    note_step <= shift_left(to_unsigned(636, note_step'length), octave_shift);
                                else
                                    note_step <= to_unsigned(636, note_step'length);
                                end if;
                            when 2 =>
                                if octave_shift < 0 then
                                    note_step <= shift_right(to_unsigned(674, note_step'length), 0 - octave_shift);
                                elsif octave_shift > 0 then
                                    note_step <= shift_left(to_unsigned(674, note_step'length), octave_shift);
                                else
                                    note_step <= to_unsigned(674, note_step'length);
                                end if;
                            when 3 =>
                                if octave_shift < 0 then
                                    note_step <= shift_right(to_unsigned(714, note_step'length), 0 - octave_shift);
                                elsif octave_shift > 0 then
                                    note_step <= shift_left(to_unsigned(714, note_step'length), octave_shift);
                                else
                                    note_step <= to_unsigned(714, note_step'length);
                                end if;
                            when 4 =>
                                if octave_shift < 0 then
                                    note_step <= shift_right(to_unsigned(757, note_step'length), 0 - octave_shift);
                                elsif octave_shift > 0 then
                                    note_step <= shift_left(to_unsigned(757, note_step'length), octave_shift);
                                else
                                    note_step <= to_unsigned(757, note_step'length);
                                end if;
                            when 5 =>
                                if octave_shift < 0 then
                                    note_step <= shift_right(to_unsigned(802, note_step'length), 0 - octave_shift);
                                elsif octave_shift > 0 then
                                    note_step <= shift_left(to_unsigned(802, note_step'length), octave_shift);
                                else
                                    note_step <= to_unsigned(802, note_step'length);
                                end if;
                            when 6 =>
                                if octave_shift < 0 then
                                    note_step <= shift_right(to_unsigned(850, note_step'length), 0 - octave_shift);
                                elsif octave_shift > 0 then
                                    note_step <= shift_left(to_unsigned(850, note_step'length), octave_shift);
                                else
                                    note_step <= to_unsigned(850, note_step'length);
                                end if;
                            when 7 =>
                                if octave_shift < 0 then
                                    note_step <= shift_right(to_unsigned(900, note_step'length), 0 - octave_shift);
                                elsif octave_shift > 0 then
                                    note_step <= shift_left(to_unsigned(900, note_step'length), octave_shift);
                                else
                                    note_step <= to_unsigned(900, note_step'length);
                                end if;
                            when 8 =>
                                if octave_shift < 0 then
                                    note_step <= shift_right(to_unsigned(954, note_step'length), 0 - octave_shift);
                                elsif octave_shift > 0 then
                                    note_step <= shift_left(to_unsigned(954, note_step'length), octave_shift);
                                else
                                    note_step <= to_unsigned(954, note_step'length);
                                end if;
                            when 9 =>
                                if octave_shift < 0 then
                                    note_step <= shift_right(to_unsigned(1010, note_step'length), 0 - octave_shift);
                                elsif octave_shift > 0 then
                                    note_step <= shift_left(to_unsigned(1010, note_step'length), octave_shift);
                                else
                                    note_step <= to_unsigned(1010, note_step'length);
                                end if;
                            when 10 =>
                                if octave_shift < 0 then
                                    note_step <= shift_right(to_unsigned(1070, note_step'length), 0 - octave_shift);
                                elsif octave_shift > 0 then
                                    note_step <= shift_left(to_unsigned(1070, note_step'length), octave_shift);
                                else
                                    note_step <= to_unsigned(1070, note_step'length);
                                end if;
                            when 11 =>
                                if octave_shift < 0 then
                                    note_step <= shift_right(to_unsigned(1134, note_step'length), 0 - octave_shift);
                                elsif octave_shift > 0 then
                                    note_step <= shift_left(to_unsigned(1134, note_step'length), octave_shift);
                                else
                                    note_step <= to_unsigned(1134, note_step'length);
                                end if;
                            when others =>
                                note_step <= to_unsigned(222222, note_step'length);
                        end case;
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

    -- generate sound to audio output
    sound_fsm : process (aud_clk12, reset_n)
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
    end process sound_fsm;

    -- generates a sound at the given note frequency
    osc : process (aud_clk12, reset_n)
    begin
        if reset_n = '0' then
            audio  <= (others => '0');
            sample <= 0;

        elsif falling_edge(aud_clk12) then
            if reg_on = '1' and sclk_en = '1' then
                if sample >= 65535 then
                    sample <= 0;
                else
                    sample <= sample + to_integer(note_step);
                end if;

                audio(31 downto 16) <= std_logic_vector(to_unsigned(sample, 16));
                audio(15 downto 0)  <= std_logic_vector(to_unsigned(sample, 16));
            end if;
        end if;
    end process osc;

end architecture fsm;