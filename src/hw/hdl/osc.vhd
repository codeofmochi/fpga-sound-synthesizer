--
-- Sound synthesizer oscillator module
-- Computes an audio wave given a note frequency
--
-- DO NOT CHANGE THIS FILE DIRECTLY, INSTEAD CHANGE osc.py!
--
-- file:                osc.vhd
-- auto-generated from: osc.py
-- last generated:      2020-06-10
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
        reg_on    : in std_logic;
        -- note_step register for this osc
        note_step : in unsigned(15 downto 0);
        -- output sample
        osc_out : out signed(15 downto 0)
    );
end entity osc;

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
                if to_integer(sample) >= 32767 then
                    sample <= to_signed(-32767, sample'length);
                else
                    sample <= sample + signed(std_logic_vector(note_step));
                end if;

                osc_out <= resize(sample, osc_out'length);
            end if;
        end if;
    end process saw_gen;
end architecture arith;

-- DO NOT CHANGE THIS FILE DIRECTLY, INSTEAD CHANGE osc.py!