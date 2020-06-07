restart -f

-- 50 MHz clock and reset
force clk 0 0ns, 1 10ns -repeat 20ns
force reset_n 1 0ns, 0 20ns, 1 40ns

-- Set I2C register address (8 bits)
force as_address 16#0 60ns
force as_write 0 0ns, 1 60ns, 0 80ns
force as_writedata 16#0000009A 60ns

-- Set I2C data (16 bits)
force as_address 16#1 100ns
force as_write 1 100ns, 0 120ns
force as_writedata 16#0000CAFE 100ns

-- Send start signal
force as_address 16#2 140ns
force as_write 1 140ns, 0 160ns

-- Simulate address ack
force i2c_sdat 0 54010ns, Z 57000ns

-- Simulate MSB ack
force i2c_sdat 0 99190ns, Z 102000ns

-- Simulate LSB ack
force i2c_sdat 0 144370ns, Z 147000ns

-- Check busy = 1 while device is running
force as_address 16#3 80000ns
force as_read 1 80000ns, 0 80020ns

-- Check busy = 0 after device has stopped
force as_address 16#3 170000ns
force as_read 1 170000ns, 0 170020ns

run 200us
