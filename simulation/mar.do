# Add all signals
add wave -position end  sim:/mar/Clk
add wave -position end  sim:/mar/Reset
add wave -position end  sim:/mar/busIn
add wave -position end  sim:/mar/register_in
add wave -position end  sim:/mar/ramOut
add wave -position end  sim:/mar/iValue

# Clock and reset
force -freeze sim:/mar/Clk 1 0, 0 {10000 ps} -r 20ns
force -freeze sim:/mar/Reset 1 0
run 40ns

# Define busIn and register_in
force -freeze sim:/mar/Reset 0 0
force -freeze sim:/mar/busIn 1010101010101010 0
force -freeze sim:/mar/register_in 0 0
run 60ns

# Load value into register
force -freeze sim:/mar/register_in 1 0
run 60ns