# Add all signals
add wave -position end  sim:/general_register/Clk
add wave -position end  sim:/general_register/Reset
add wave -position end  sim:/general_register/busOut
add wave -position end  sim:/general_register/busIn
add wave -position end  sim:/general_register/register_in
add wave -position end  sim:/general_register/iValue

# Reset
force -freeze sim:/general_register/Clk 1 0, 0 {10000 ps} -r 20ns
force -freeze sim:/general_register/Reset 1 0
run 40ns

# Bus in signal defined but register_in low
force -freeze sim:/general_register/Reset 0 0
force -freeze sim:/general_register/busIn 10101010101010101010101010101010 0
force -freeze sim:/general_register/register_in 0 0
run 40ns

# Store value in register
force -freeze sim:/general_register/register_in 1 0
run 40ns