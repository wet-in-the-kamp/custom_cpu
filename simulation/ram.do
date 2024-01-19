# Load all signals
add wave -position end  sim:/ram/address
add wave -position end  sim:/ram/clock
add wave -position end  sim:/ram/data
add wave -position end  sim:/ram/wren
add wave -position end  sim:/ram/q

# Set up clock
force -freeze sim:/ram/clock 1 0, 0 {10000 ps} -r 20ns

# Write enable and write to first address
force -freeze sim:/ram/wren 1 0
force -freeze sim:/ram/address 0000000000000 0
force -freeze sim:/ram/data 01010101010101010101010101010101 0

# Run
run 60ns

# Write disable and read first address (read is automatic)
force -freeze sim:/ram/wren 0 0
force -freeze sim:/ram/address 0000000000000 0
force -freeze sim:/ram/data 11111111111111111111111111111111 0

# Run
run 60ns