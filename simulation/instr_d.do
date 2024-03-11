# Add signals
add wave -position end  sim:/instr_d/Clk
add wave -position end  sim:/instr_d/Reset
add wave -position end  sim:/instr_d/IRin
add wave -position end  sim:/instr_d/neg_pos_n
add wave -position end  sim:/instr_d/zero
add wave -position end  sim:/instr_d/iCount
add wave -position end  sim:/instr_d/iControl

# Define Clock and Reset
force -freeze sim:/instr_d/Clk 1 0, 0 {10000 ps} -r 20ns
force -freeze sim:/instr_d/Reset 1 0
run 40ns
force -freeze sim:/instr_d/Reset 0 0

# Try each OpCode
# NOP
force -freeze sim:/instr_d/IRin 0000000000000000 0
run 100ns
# LDA
force -freeze sim:/instr_d/IRin 0000000000000001 0
run 100ns
# ADD
force -freeze sim:/instr_d/IRin 0000000000000010 0
run 100ns
# SUB
force -freeze sim:/instr_d/IRin 0000000000000011 0
run 100ns
# STA
force -freeze sim:/instr_d/IRin 0000000000000100 0
run 100ns
# LDI
force -freeze sim:/instr_d/IRin 0000000000000101 0
run 100ns
# JMP
force -freeze sim:/instr_d/IRin 0000000000000110 0
run 100ns
# OUT
force -freeze sim:/instr_d/IRin 0000000000000111 0
run 100ns
# LDB
force -freeze sim:/instr_d/IRin 0000000000001000 0
run 100ns
# JPN with flag high
force -freeze sim:/instr_d/IRin 0000000000001001 0
force -freeze sim:/instr_d/neg_pos_n 1 0
run 100ns
# JPN with flag low
force -freeze sim:/instr_d/IRin 0000000000001001 0
force -freeze sim:/instr_d/neg_pos_n 0 0
run 100ns
# JPZ with flag high
force -freeze sim:/instr_d/IRin 0000000000001010 0
force -freeze sim:/instr_d/zero 1 0
run 100ns
# JPZ with flag low
force -freeze sim:/instr_d/IRin 0000000000001010 0
force -freeze sim:/instr_d/zero 0 0
run 100ns