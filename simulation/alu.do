# Add all signals
add wave -position end  sim:/alu/Clk
add wave -position end  sim:/alu/Reset
add wave -position end  sim:/alu/busOut
add wave -position end  sim:/alu/aIn
add wave -position end  sim:/alu/bIn
add wave -position end  sim:/alu/add_sub_n
add wave -position end  sim:/alu/carry
add wave -position end  sim:/alu/iSum
add wave -position end  sim:/alu/iAextend
add wave -position end  sim:/alu/iBextend

# Reset
force -freeze sim:/alu/Clk 1 0, 0 {10000 ps} -r 20ns
force -freeze sim:/alu/Reset 1 0
run 40ns

# Simple add
force -freeze sim:/alu/Reset 0 0
force -freeze sim:/alu/aIn 00000000000000000000000000000001 0
force -freeze sim:/alu/bIn 00000000000000000000000000000001 0
force -freeze sim:/alu/add_sub_n 1 0
run 60ns

# Test overflow
force -freeze sim:/alu/aIn 11111111111111111111111111111111 0
run 60ns