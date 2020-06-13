--
-- Sound synthesizer oscillator module
-- Computes an audio wave given a note frequency
--
-- DO NOT CHANGE THIS FILE DIRECTLY, INSTEAD CHANGE osc.py!
--
-- file:                osc.vhd
-- auto-generated from: osc.py
-- last generated:      2020-06-13
-- author:              Alexandre CHAU & Loïc DROZ
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity osc is
    port (
        -- audio timing inputs
        aud_clk12 : in std_logic;
        sclk_en   : in std_logic;
        reset_n   : in std_logic;
        -- global on/off register
        reg_on   : in std_logic;
        osc_mode : in unsigned(31 downto 0);
        -- notes register for this osc
        note        : in std_logic_vector(31 downto 0);
        note_step   : in unsigned(31 downto 0);
        note_period : in unsigned(31 downto 0);
        -- output sample
        osc_out : out signed(31 downto 0)
    );
end entity osc;

architecture arith of osc is
    signal sample_counter : unsigned(note_period'length - 1 downto 0);
    signal saw_wave       : signed(31 downto 0);
    signal sqr_wave       : signed(31 downto 0);
begin
    saw_gen : process (aud_clk12, reset_n)
    begin
        if reset_n = '0' then
            sample_counter <= to_unsigned(0, sample_counter'length);
            saw_wave       <= to_signed(0, saw_wave'length);
            sqr_wave       <= to_signed(0, sqr_wave'length); 
            osc_out        <= to_signed(0, osc_out'length);

        elsif falling_edge(aud_clk12) then
            if sclk_en = '1' then
                -- note period reached for this oscillator
                if sample_counter >= note_period then
                    sample_counter <= to_unsigned(0, sample_counter'length);
                    saw_wave       <= to_signed(-268435455, saw_wave'length);
                    sqr_wave       <= to_signed(-268435455, sqr_wave'length);
                else
                    if to_integer(sample_counter) = to_integer(note_period(note_period'length - 1 downto 1)) then
                        sqr_wave <= to_signed(268435455, saw_wave'length);
                    end if;
                    sample_counter <= sample_counter + 1;
                    saw_wave       <= saw_wave + signed(std_logic_vector(note_step));
                end if;

                -- stop sound if device has been stopped or note is 0
                if reg_on = '0' or to_integer(unsigned(note(15 downto 8))) = 0 then
                    osc_out <= to_signed(0, osc_out'length);
                else
                    case to_integer(osc_mode) is
                        when 0      => osc_out <= saw_wave;
                        when 1      => osc_out <= sqr_wave;
                        when others => osc_out <= saw_wave;
                    end case;
                end if;
            end if;
        end if;
    end process saw_gen;
end architecture arith;

-- DO NOT CHANGE THIS FILE DIRECTLY, INSTEAD CHANGE osc.py!