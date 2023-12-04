# Add all signals
add wave -position end  sim:/alu/Clk
add wave -position end  sim:/alu/Reset
add wave -position end  sim:/alu/busOut
add wave -position end  sim:/alu/aIn
add wave -position end  sim:/alu/bIn
add wave -position end  sim:/alu/add_sub_n
add wave -position end  sim:/alu/neg_pos_n
add wave -position end  sim:/alu/zero
add wave -position end  sim:/alu/iSum

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

# 1 + -1
force -freeze sim:/alu/aIn 11111111111111111111111111111111 0
run 60ns

# Simple subtract
force -freeze sim:/alu/aIn 00000000000000000000000000000001 0
force -freeze sim:/alu/bIn 00000000000000000000000000000001 0
force -freeze sim:/alu/add_sub_n 0 0
run 60ns

# Subtract with negative result
force -freeze sim:/alu/aIn 00000000000000000000000000000001 0
force -freeze sim:/alu/bIn 00000000000000000000000000000010 0
force -freeze sim:/alu/add_sub_n 0 0
run 60ns

# Add negative numbers, negative result
force -freeze sim:/alu/aIn 11111111111110000000000000000001 0
force -freeze sim:/alu/bIn 11111111111111000000000000000010 0
force -freeze sim:/alu/add_sub_n 0 0
run 60ns

# Test case for subtracting a larger number from a smaller number
force -freeze sim:/alu/aIn 00000000000000000000000000001000 0
force -freeze sim:/alu/bIn 00000000000000000000000000000100 0
force -freeze sim:/alu/add_sub_n 0 0
run 60ns

# Test case for adding two large positive numbers (overflow)
force -freeze sim:/alu/aIn 01111111111111111111111111111111 0
force -freeze sim:/alu/bIn 00000000000000000000000000011111 0
force -freeze sim:/alu/add_sub_n 1 0
run 60ns

# Test case for subtracting a negative number from a positive number
force -freeze sim:/alu/aIn 00000000000000000000000000000100 0
force -freeze sim:/alu/bIn 11111111111111111111111111111000 0
force -freeze sim:/alu/add_sub_n 0 0
run 60ns

# Test case for adding two negative numbers
force -freeze sim:/alu/aIn 11111111111111111111111111110000 0
force -freeze sim:/alu/bIn 11111111111111111111111111101010 0
force -freeze sim:/alu/add_sub_n 1 0
run 60ns

# Test case for subtracting zero
force -freeze sim:/alu/aIn 00000000000000000000000000010000 0
force -freeze sim:/alu/bIn 00000000000000000000000000000000 0
force -freeze sim:/alu/add_sub_n 0 0
run 60ns

# Test case for adding zero
force -freeze sim:/alu/aIn 00000000000000000000000000000000 0
force -freeze sim:/alu/bIn 00000000000000000000000000011011 0
force -freeze sim:/alu/add_sub_n 1 0
run 60ns