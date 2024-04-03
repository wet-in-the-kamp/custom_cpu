# Add all signals
add wave -position end  sim:/custom_cpu/Clk
add wave -position end  sim:/custom_cpu/Reset
add wave -position end  sim:/custom_cpu/Output
add wave -position end  sim:/custom_cpu/ipc_out
add wave -position end  sim:/custom_cpu/i_c_pc_in
add wave -position end  sim:/custom_cpu/i_c_pc_en
add wave -position end  sim:/custom_cpu/ia_out
add wave -position end  sim:/custom_cpu/i_c_a_in
add wave -position end  sim:/custom_cpu/ib_out
add wave -position end  sim:/custom_cpu/i_c_b_in
add wave -position end  sim:/custom_cpu/i_c_out_in
add wave -position end  sim:/custom_cpu/ialu_out
add wave -position end  sim:/custom_cpu/i_c_asn
add wave -position end  sim:/custom_cpu/i_f_npn
add wave -position end  sim:/custom_cpu/i_f_zero
add wave -position end  sim:/custom_cpu/i_c_mar_in
add wave -position end  sim:/custom_cpu/imar_ram
add wave -position end  sim:/custom_cpu/iir_out
add wave -position end  sim:/custom_cpu/iir_decode
add wave -position end  sim:/custom_cpu/i_c_ir_in
add wave -position end  sim:/custom_cpu/iram_in
add wave -position end  sim:/custom_cpu/i_c_wren
add wave -position end  sim:/custom_cpu/iram_out
add wave -position end  sim:/custom_cpu/i_c_pc_out
add wave -position end  sim:/custom_cpu/i_c_a_out
add wave -position end  sim:/custom_cpu/i_c_b_out
add wave -position end  sim:/custom_cpu/i_c_alu_out
add wave -position end  sim:/custom_cpu/i_c_ram_out
add wave -position end  sim:/custom_cpu/i_c_ir_out

# Set clock and reset
force -freeze sim:/custom_cpu/Clk 1 0, 0 {10000 ps} -r 20ns
force -freeze sim:/custom_cpu/Reset 1 0
run 40ns

# Run program
force -freeze sim:/custom_cpu/Reset 0 0
run 2400ns