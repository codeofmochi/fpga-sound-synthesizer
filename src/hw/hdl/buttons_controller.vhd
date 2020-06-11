--
-- Physical buttons controller
-- An Avalon slave to interface with human interactions through buttons and switches
--
-- file:    buttons_controller.vhd
-- author:  Alexandre CHAU & Loïc DROZ
-- date:    11/06/2020
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity buttons_controller is
    port (
        clk     : in std_logic;
        reset_n : in std_logic;

        -- Avalon slave
        as_address   : in std_logic_vector(1 downto 0);
        as_read      : in std_logic;
        as_readdata  : out std_logic_vector(31 downto 0);
        as_write     : in std_logic;
        as_writedata : in std_logic_vector(31 downto 0);

        -- Interrupt line
        irq : out std_logic;

        -- Lines to physical buttons
        switch  : in std_logic_vector(9 downto 0);
        buttons : in std_logic_vector(2 downto 0)
    );
end entity buttons_controller;

architecture rtl of buttons_controller is
    -- register map
    constant REG_STATUS_OFFSET : std_logic_vector(as_address'length - 1 downto 0) := "00";
    constant REG_IRQ_OFFSET    : std_logic_vector(as_address'length - 1 downto 0) := "01";

    -- internal registers
    signal reg_status : std_logic_vector(switch'length + buttons'length - 1 downto 0);
    signal reg_irq    : std_logic;
begin
    -- Assign IRQ line
    irq <= reg_irq;

    -- Avalon read process
    as_read_process : process (clk, reset_n)
    begin
        if rising_edge(clk) then
            if as_read = '1' then
                case as_address is
                    when REG_STATUS_OFFSET => as_readdata <= (31 downto reg_status'length => '0') & reg_status;
                    when others => null;
                end case;
            end if;
        end if;
    end process as_read_process;

    -- Avalon write process
    as_write_process : process (clk, reset_n)
    begin
        if reset_n = '0' then
            reg_status <= (others => '0');
            reg_irq    <= '0';

        elsif rising_edge(clk) then
            if as_write = '1' then
                case as_address is
                    when REG_IRQ_OFFSET =>
                        reg_irq <= '0';
                    when others =>
                        null;
                end case;
            end if;
        end if;

        -- detect any button press
        if falling_edge(buttons(2)) or falling_edge(buttons(1)) or falling_edge(buttons(0)) then
            reg_irq    <= '1';
            reg_status <= switch & buttons;
        end if;
    end process as_write_process;
end architecture rtl;