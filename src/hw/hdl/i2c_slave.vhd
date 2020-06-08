--
-- I2C custom slave
-- An Avalon slave to interface with I2C components
-- Inspired from https://github.com/AntonZero/WM8731-Audio-codec-on-DE10Standard-FPGA-board/blob/master/project/i2c.vhd
--
-- file: i2c_slave.vhd
-- author: Alexandre CHAU & Loïc DROZ
-- date: 07/06/2020
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity i2c_slave is
    port (
        clk     : in std_logic;
        reset_n : in std_logic;

        -- Avalon
        as_address   : in std_logic_vector(1 downto 0);
        as_write     : in std_logic;
        as_writedata : in std_logic_vector(31 downto 0);
        as_read      : in std_logic;
        as_readdata  : out std_logic_vector(31 downto 0);

        -- I2C
        i2c_sclk : out std_logic;
        i2c_sdat : inout std_logic;

        -- Debug
        debug_sclk : out std_logic;
        debug_sdat : out std_logic
    );
end entity i2c_slave;

architecture fsm of i2c_slave is
    -- register map offsets
    constant REG_I2C_ADDRESS_OFFSET : std_logic_vector(as_address'length - 1 downto 0) := "00";
    constant REG_I2C_DATA_OFFSET    : std_logic_vector(as_address'length - 1 downto 0) := "01";
    constant REG_START_OFFSET       : std_logic_vector(as_address'length - 1 downto 0) := "10";
    constant REG_BUSY_OFFSET        : std_logic_vector(as_address'length - 1 downto 0) := "11";

    -- internal registers
    signal reg_i2c_address : std_logic_vector(7 downto 0);
    signal reg_i2c_data    : std_logic_vector(15 downto 0);
    signal reg_busy        : std_logic;

    -- control signals
    signal pulse_done   : std_logic;
    signal sclk_counter : integer range 0 to 255;
    signal sclk         : std_logic;
    signal sclk_en      : std_logic;
    signal high_en      : std_logic; -- used for ack checks
    signal low_en       : std_logic; -- used for data changes
    signal index        : integer range -1 to 15;

    -- FSM
    type state_type is (
        Q_IDLE,
        Q_START,
        Q_SEND_ADDRESS,
        Q_WAIT_ADDRESS_ACK,
        Q_SEND_MSB,
        Q_WAIT_MSB_ACK,
        Q_SEND_LSB,
        Q_WAIT_LSB_ACK,
        Q_STOP,
        Q_DONE,
        Q_END
    );
    signal state : state_type;
begin

    -- Avalon slave read
    as_read_process : process (clk, reset_n)
    begin
        if reset_n = '0' then
            as_readdata <= (others => '0');
        elsif rising_edge(clk) then
            if as_read = '1' then
                case as_address is
                    when REG_BUSY_OFFSET => as_readdata <= (31 downto 1 => '0') & reg_busy;
                    when others => -- do nothing
                end case;
            end if;
        end if;
    end process as_read_process;

    -- Avalon slave write
    as_write_process : process (clk, reset_n)
    begin
        if reset_n = '0' then
            reg_busy <= '0';
        elsif rising_edge(clk) then
            if as_write = '1' and reg_busy = '0' then
                case as_address is
                    when REG_I2C_ADDRESS_OFFSET =>
                        reg_i2c_address <= as_writedata(reg_i2c_address'length - 1 downto 0);
                    when REG_I2C_DATA_OFFSET =>
                        reg_i2c_data <= as_writedata(reg_i2c_data'length - 1 downto 0);
                    when REG_START_OFFSET =>
                        reg_busy <= '1';
                    when others =>
                        -- do nothing
                end case;
            end if;

            if pulse_done = '1' then
                reg_busy <= '0';
            end if;
        end if;
    end process as_write_process;

    sclk_gen : process (clk, reset_n)
    begin
        if reset_n = '0' then
            sclk_counter <= 0;
            sclk         <= '0';
            high_en      <= '0';
            low_en       <= '0';

        elsif rising_edge(clk) then
            -- slow clock counter ref
            if sclk_counter < 250 then
                sclk_counter <= sclk_counter + 1;
            else
                sclk_counter <= 0;
            end if;

            -- slow clock generation
            if sclk_counter < 125 then
                sclk <= '1';
            else
                sclk <= '0';
            end if;

            -- slow high enable
            if sclk_counter = 62 then
                high_en <= '1';
            else
                high_en <= '0';
            end if;

            -- low high enable
            if sclk_counter = 187 then
                low_en <= '1';
            else
                low_en <= '0';
            end if;
        end if;
    end process sclk_gen;

    i2c_fsm : process (clk, reset_n)
    begin
        if reset_n = '0' then
            i2c_sclk   <= '1'; -- active low
            debug_sclk <= '1';
            i2c_sdat   <= '1'; -- active low
            debug_sdat <= '1';
            sclk_en    <= '0';
            pulse_done <= '0';
            index      <= 0;
            state      <= Q_IDLE;

        elsif rising_edge(clk) then

            -- assert either sclk or high disable on I2C_SCLK
            if sclk_en = '1' then
                i2c_sclk   <= sclk;
                debug_sclk <= sclk;
            else
                i2c_sclk   <= '1';
                debug_sclk <= '1';
            end if;

            -- wait for acks on high enable
            if high_en = '1' then
                case state is
                    when Q_WAIT_ADDRESS_ACK =>
                        if i2c_sdat = '0' then
                            index <= 15;
                            state <= Q_SEND_MSB;
                        else
                            -- NACK, go back to idle
                            sclk_en <= '0';
                            state   <= Q_IDLE;
                        end if;

                    when Q_WAIT_MSB_ACK =>
                        if i2c_sdat = '0' then
                            index <= 7;
                            state <= Q_SEND_LSB;
                        else
                            -- NACK, go back to idle
                            sclk_en <= '0';
                            state   <= Q_IDLE;
                        end if;

                    when Q_WAIT_LSB_ACK =>
                        if i2c_sdat = '0' then
                            state <= Q_STOP;
                        else
                            -- NACK, go back to idle
                            sclk_en <= '0';
                            state   <= Q_IDLE;
                        end if;

                    when others =>
                        -- do nothing
                end case;
            end if;

            -- assert data changes on low enable
            if low_en = '1' then
                case state is
                    when Q_IDLE =>
                        -- wait for reg_busy to start operation
                        i2c_sdat   <= '1';
                        debug_sdat <= '1';
                        pulse_done <= '0';
                        index      <= 0;
                        if reg_busy = '1' then
                            state <= Q_START;
                        end if;

                    when Q_START =>
                        -- assert start condition
                        i2c_sdat   <= '0';
                        debug_sdat <= '0';
                        index      <= 7;
                        state      <= Q_SEND_ADDRESS;

                    when Q_SEND_ADDRESS =>
                        -- send 7 bits of address
                        sclk_en <= '1';

                        if index >= 0 then
                            index      <= index - 1;
                            i2c_sdat   <= reg_i2c_address(index);
                            debug_sdat <= reg_i2c_address(index);
                        else
                            i2c_sdat   <= 'Z';
                            debug_sdat <= 'Z';
                            state      <= Q_WAIT_ADDRESS_ACK;
                        end if;

                    when Q_SEND_MSB =>
                        if index >= 8 then
                            index      <= index - 1;
                            i2c_sdat   <= reg_i2c_data(index);
                            debug_sdat <= reg_i2c_data(index);
                        else
                            i2c_sdat   <= 'Z';
                            debug_sdat <= 'Z';
                            state      <= Q_WAIT_MSB_ACK;
                        end if;

                    when Q_SEND_LSB =>
                        if index >= 0 then
                            index      <= index - 1;
                            i2c_sdat   <= reg_i2c_data(index);
                            debug_sdat <= reg_i2c_data(index);
                        else
                            i2c_sdat   <= 'Z';
                            debug_sdat <= 'Z';
                            state      <= Q_WAIT_LSB_ACK;
                        end if;

                    when Q_STOP =>
                        -- assert stop condition
                        sclk_en    <= '0';
                        i2c_sdat   <= '0';
                        debug_sdat <= '0';
                        pulse_done <= '1';
                        state      <= Q_DONE;

                    when Q_DONE =>
                        -- de-assert done pulse
                        pulse_done <= '0';
                        state      <= Q_END;

                    when Q_END =>
                        -- wait for reg_busy to be 0
                        state <= Q_IDLE;

                    when others =>
                        -- do nothing
                end case;
            end if;
        end if;
    end process i2c_fsm;

end architecture fsm;