restart -f

-- 50 MHz master clock and reset
force clk 0 0ns, 1 10ns -repeat 20ns
force reset_n 1 0ns, 0 20ns, 1 40ns

-- 12 MHz clock
force aud_clk12 0 0ns, 1 41.666ns -repeat 83.333ns

-- Send start signal from Avalon
force as_address 16#0 60ns
force as_write 0 0ns, 1 60ns, 0 80ns

-- Send stop signal from Avalon
force as_address 16#1 6000000ns
force as_write 1 6000000ns, 0 6000020ns

-- Run long enough to see a few periods of 440 Hz A
run 10ms
