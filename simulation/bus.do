# Add all signals
add wave -position end  sim:/my_bus/pc_data_in
add wave -position end  sim:/my_bus/pc_data_out
add wave -position end  sim:/my_bus/a_data_in
add wave -position end  sim:/my_bus/a_data_out
add wave -position end  sim:/my_bus/b_data_in
add wave -position end  sim:/my_bus/b_data_out
add wave -position end  sim:/my_bus/alu_data_out
add wave -position end  sim:/my_bus/output_data_in
add wave -position end  sim:/my_bus/mar_data_in
add wave -position end  sim:/my_bus/ram_data_in
add wave -position end  sim:/my_bus/ram_data_out
add wave -position end  sim:/my_bus/ir_data_in
add wave -position end  sim:/my_bus/ir_data_out
add wave -position end  sim:/my_bus/pc_in
add wave -position end  sim:/my_bus/pc_out
add wave -position end  sim:/my_bus/a_in
add wave -position end  sim:/my_bus/a_out
add wave -position end  sim:/my_bus/b_in
add wave -position end  sim:/my_bus/b_out
add wave -position end  sim:/my_bus/output_in
add wave -position end  sim:/my_bus/alu_out
add wave -position end  sim:/my_bus/mar_in
add wave -position end  sim:/my_bus/ram_wren
add wave -position end  sim:/my_bus/ram_out
add wave -position end  sim:/my_bus/ir_in
add wave -position end  sim:/my_bus/ir_out
add wave -position end  sim:/my_bus/iBus
add wave -position end  sim:/my_bus/iOutSignals
add wave -position end  sim:/my_bus/iInSignals

# Define random data values
force -freeze sim:/my_bus/pc_data_out 0000000000000000 0
force -freeze sim:/my_bus/a_data_out 00000000000000000000000000000001 0
force -freeze sim:/my_bus/b_data_out 00000000000000000000000000000010 0
force -freeze sim:/my_bus/alu_data_out 00000000000000000000000000000101 0
force -freeze sim:/my_bus/ram_data_out 00000000000000000000000000011001 0
force -freeze sim:/my_bus/ir_data_out 0000000000000011 0

# Set all control signals to zero to start
force -freeze sim:/my_bus/pc_out 0 0
force -freeze sim:/my_bus/a_out 0 0
force -freeze sim:/my_bus/b_out 0 0
force -freeze sim:/my_bus/alu_out 0 0
force -freeze sim:/my_bus/ram_out 0 0
force -freeze sim:/my_bus/ir_out 0 0
force -freeze sim:/my_bus/pc_in 0 0
force -freeze sim:/my_bus/a_in 0 0
force -freeze sim:/my_bus/b_in 0 0
force -freeze sim:/my_bus/output_in 0 0
force -freeze sim:/my_bus/mar_in 0 0
force -freeze sim:/my_bus/ram_wren 0 0
force -freeze sim:/my_bus/ir_in 0 0

# Check all output control signals (internal iBus should hold each value)
force -freeze sim:/my_bus/pc_out 1 0
run 20ns
force -freeze sim:/my_bus/pc_out 0 0

force -freeze sim:/my_bus/a_out 1 0
run 20ns
force -freeze sim:/my_bus/a_out 0 0

force -freeze sim:/my_bus/b_out 1 0
run 20ns
force -freeze sim:/my_bus/b_out 0 0

force -freeze sim:/my_bus/alu_out 1 0
run 20ns
force -freeze sim:/my_bus/alu_out 0 0

force -freeze sim:/my_bus/ram_out 1 0
run 20ns
force -freeze sim:/my_bus/ram_out 0 0

force -freeze sim:/my_bus/ir_out 1 0
run 20ns
force -freeze sim:/my_bus/ir_out 0 0

# Check all input control signals (each line should hold the bus value)
force -freeze sim:/my_bus/pc_in 1 0
run 20ns
force -freeze sim:/my_bus/pc_in 0 0

force -freeze sim:/my_bus/a_in 1 0
run 20ns
force -freeze sim:/my_bus/a_in 0 0

force -freeze sim:/my_bus/b_in 1 0
run 20ns
force -freeze sim:/my_bus/b_in 0 0

force -freeze sim:/my_bus/output_in 1 0
run 20ns
force -freeze sim:/my_bus/output_in 0 0

force -freeze sim:/my_bus/mar_in 1 0
run 20ns
force -freeze sim:/my_bus/mar_in 0 0

force -freeze sim:/my_bus/ram_wren 1 0
run 20ns
force -freeze sim:/my_bus/ram_wren 0 0

force -freeze sim:/my_bus/ir_in 1 0
run 20ns
force -freeze sim:/my_bus/ir_in 0 0

# Check output and input at the same time for a register to b
force -freeze sim:/my_bus/a_out 1 0
force -freeze sim:/my_bus/b_in 1 0
run 20ns