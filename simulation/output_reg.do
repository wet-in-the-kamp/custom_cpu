# Add all signals
add wave -position end  sim:/output_register/Clk
add wave -position end  sim:/output_register/Reset
add wave -position end  sim:/output_register/busIn
add wave -position end  sim:/output_register/dataOut
add wave -position end  sim:/output_register/register_in
add wave -position end  sim:/output_register/iValue

# Reset and define clock
force -freeze sim:/output_register/Clk 1 0, 0 {10000 ps} -r 20ns
force -freeze sim:/output_register/Reset 1 0
run 40ns

# Define busIn but do not load value
force -freeze sim:/output_register/busIn 10101010101010101010101010101010 0
force -freeze sim:/output_register/register_in 0 0
force -freeze sim:/output_register/Reset 0 0
run 40ns

# Output data and store in register
force -freeze sim:/output_register/register_in 1 0
run 40ns