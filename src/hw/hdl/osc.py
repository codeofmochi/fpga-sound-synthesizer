#
# This file is a helper to generate the oscillator component
#
# file:         osc.py
# generates:    osc.vhd
# author:       Alexandre CHAU
import datetime
from sound_gen import OSC_DEPTH, OSC_MAX, OSC_MIN

header = f"""--
-- Sound synthesizer oscillator module
-- Computes an audio wave given a note frequency
--
-- DO NOT CHANGE THIS FILE DIRECTLY, INSTEAD CHANGE osc.py!
--
-- file:                osc.vhd
-- auto-generated from: osc.py
-- last generated:      {datetime.date.today()}
-- author:              Alexandre CHAU & Loïc DROZ
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
"""

entity = f"""
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
        note_step   : in unsigned({OSC_DEPTH - 1} downto 0);
        note_period : in unsigned({OSC_DEPTH - 1} downto 0);
        -- output sample
        osc_out : out signed({OSC_DEPTH - 1} downto 0)
    );
end entity osc;
"""

architecture = f"""
architecture arith of osc is
    signal sample_counter : unsigned(note_period'length - 1 downto 0);
    signal saw_wave       : signed({OSC_DEPTH - 1} downto 0);
    signal sqr_wave       : signed({OSC_DEPTH - 1} downto 0);
    signal tri_wave       : signed({OSC_DEPTH - 1} downto 0);
begin
    saw_gen : process (aud_clk12, reset_n)
        variable note_period_half : unsigned({OSC_DEPTH - 2} downto 0); -- 2x smaller thus 1 less bit
        variable note_step_double : unsigned({OSC_DEPTH - 1} downto 0);
    begin
        if reset_n = '0' then
            sample_counter <= to_unsigned(0, sample_counter'length);
            saw_wave       <= to_signed(0, saw_wave'length);
            sqr_wave       <= to_signed(0, sqr_wave'length);
            tri_wave       <= to_signed(0, tri_wave'length);
            osc_out        <= to_signed(0, osc_out'length);
            note_period_half := to_unsigned(0, note_period_half'length);
            note_step_double := to_unsigned(0, note_step_double'length);

        elsif falling_edge(aud_clk12) then
            if sclk_en = '1' then
                -- half of period is period >> 1
                note_period_half := note_period(note_period'length - 1 downto 1);
                -- double of step is step << 1
                note_step_double := note_step(note_step'length - 2 downto 0) & '0';

                -- note period reached for this oscillator
                if sample_counter >= note_period then
                    sample_counter <= to_unsigned(0, sample_counter'length);
                    saw_wave       <= to_signed({OSC_MIN}, saw_wave'length);
                    sqr_wave       <= to_signed({OSC_MIN}, sqr_wave'length);
                    tri_wave       <= to_signed({OSC_MIN}, tri_wave'length);
                else
                    if to_integer(sample_counter) < to_integer(note_period_half) then
                        tri_wave <= tri_wave + signed(std_logic_vector(note_step_double));
                    elsif to_integer(sample_counter) = to_integer(note_period_half) then
                        sqr_wave <= to_signed({OSC_MAX}, saw_wave'length);
                        tri_wave <= to_signed({OSC_MAX}, tri_wave'length);
                    else -- to_integer(sample_counter) > to_integer(note_period_half)
                        tri_wave <= tri_wave - signed(std_logic_vector(note_step_double));
                    end if;
                    sample_counter <= sample_counter + 1;
                    saw_wave       <= saw_wave + signed(std_logic_vector(note_step));
                end if;

                -- stop sound if device has been stopped or note is 0
                if reg_on = '0' or to_integer(unsigned(note(15 downto 8))) = 0 then
                    osc_out <= to_signed(0, osc_out'length);
                else
                    case to_integer(osc_mode) is
                        when 0 =>
                            osc_out <= saw_wave;
                        when 1 =>
                            osc_out <= sqr_wave;
                        when 2 =>
                            osc_out <= tri_wave;
                        when others =>
                            osc_out <= saw_wave;
                    end case;
                end if;
            end if;
        end if;
    end process saw_gen;
end architecture arith;

-- DO NOT CHANGE THIS FILE DIRECTLY, INSTEAD CHANGE osc.py!"""

vhdl = header + entity + architecture

FILENAME = "osc.vhd"
with open(FILENAME, "w") as file:
    file.write(vhdl)
    print(f"Wrote generated osc component to {FILENAME}")