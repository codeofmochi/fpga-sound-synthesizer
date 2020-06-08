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
    constant REG_PERIOD_OFFSET : std_logic_vector(as_address'length - 1 downto 0) := "10";

    -- internal register
    signal reg_on : std_logic;

    -- slow clock at 48 KHz
    signal sclk_counter : integer range 0 to 255;
    signal sclk_en      : std_logic;

    -- sound fsm
    type state_type is (Q_IDLE, Q_SEND);
    signal state               : state_type;
    signal sample_bits_counter : integer range 0 to 31;

    -- oscillator
    signal audio        : std_logic;
    signal wave_counter : integer range 0 to 4095;
    signal half_period  : std_logic_vector(31 downto 0);
begin
    -- writes to the status registers on Avalon writes
    as_write_process : process (clk, reset_n)
    begin
        if reset_n = '0' then
            reg_on <= '0';
            half_period <= std_logic_vector(to_unsigned(54, half_period'length)); -- default is A440Hz
        elsif rising_edge(clk) then
            if as_write = '1' then
                case as_address is
                    when REG_START_OFFSET =>
                        reg_on <= '1';
                    when REG_STOP_OFFSET =>
                        reg_on <= '0';
                    when REG_PERIOD_OFFSET =>
                        half_period <= as_writedata;
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
                    aud_dacdat   <= audio;
                    debug_dacdat <= audio;

                when others =>
                    null;
            end case;
        end if;
    end process sound_fsm;

    -- generates a square wave of an A note at 440 Hz
    osc : process (aud_clk12, reset_n)
    begin
        if reset_n = '0' then
            audio        <= '0';
            wave_counter <= 0;

        elsif falling_edge(aud_clk12) then
            if reg_on = '1' and sclk_en = '1' then
                if wave_counter >= to_integer(unsigned(half_period)) then
                    wave_counter <= 0;
                    audio        <= not audio;
                else
                    wave_counter <= wave_counter + 1;
                end if;
            end if;
        end if;
    end process osc;

end architecture fsm;