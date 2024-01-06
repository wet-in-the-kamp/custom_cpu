# Add all signals
add wave -position end  sim:/ir/Clk
add wave -position end  sim:/ir/Reset
add wave -position end  sim:/ir/busOut
add wave -position end  sim:/ir/busIn
add wave -position end  sim:/ir/decodeOut
add wave -position end  sim:/ir/register_in
add wave -position end  sim:/ir/iValue

# Reset cycle
force -freeze sim:/ir/Clk 1 0, 0 {10000 ps} -r 20ns
force -freeze sim:/ir/Reset 1 0
run 40ns

# Load value
force -freeze sim:/ir/Reset 0 0
force -freeze sim:/ir/busIn 10101010101010101111111111111111 0
force -freeze sim:/ir/register_in 1 0
run 40ns