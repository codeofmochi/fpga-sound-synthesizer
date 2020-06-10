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
        reg_on : in std_logic;
        -- notes register for this osc
        note      : in std_logic_vector(31 downto 0);
        note_step : in unsigned({OSC_DEPTH - 1} downto 0);
        -- output sample
        osc_out : out signed({OSC_DEPTH - 1} downto 0)
    );
end entity osc;
"""

architecture = f"""
architecture arith of osc is
    signal sample : signed(31 downto 0); -- full 32-bit register to allow clipping
begin
    saw_gen : process (aud_clk12, reset_n)
    begin
        if reset_n = '0' then
            sample  <= to_signed(0, sample'length);
            osc_out <= to_signed(0, osc_out'length);

        elsif falling_edge(aud_clk12) then
            if reg_on = '1' and sclk_en = '1' then
                if to_integer(unsigned(note(15 downto 8))) = 0 then
                    sample <= to_signed(0, sample'length);
                elsif to_integer(sample) >= {OSC_MAX} then
                    sample <= to_signed({OSC_MIN}, sample'length);
                else
                    sample <= sample + signed(std_logic_vector(note_step));
                end if;

                osc_out <= resize(sample, osc_out'length);
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