# Add all waves
add wave -position end  sim:/pc/Clk
add wave -position end  sim:/pc/Reset
add wave -position end  sim:/pc/busOut
add wave -position end  sim:/pc/busIn
add wave -position end  sim:/pc/pc_in
add wave -position end  sim:/pc/pc_enable
add wave -position end  sim:/pc/iPCValue

# Reset
force -freeze sim:/pc/Clk 1 0, 0 {10000 ps} -r 20ns
force -freeze sim:/pc/Reset 1 0
run 40ns

# Let the PC count
force -freeze sim:/pc/Reset 0 0
force -freeze sim:/pc/pc_enable 1 0
run 70ns

# Stop the PC and load a value
force -freeze sim:/pc/pc_enable 0 0
force -freeze sim:/pc/pc_in 1 0
force -freeze sim:/pc/busIn 1010101010101010 0
run 60ns

# See what happens when the PC reaches last value (overflow)
force -freeze sim:/pc/busIn 1111111111111111 0
run 40ns
force -freeze sim:/pc/pc_in 0 0
force -freeze sim:/pc/pc_enable 1 0
run 80ns