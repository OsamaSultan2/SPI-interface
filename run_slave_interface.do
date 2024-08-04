vlib work 
vlog slave_interface.v slave_interface_tb.v
vsim -voptargs=+acc work.slave_interface_tb
add wave *
add wave -position insertpoint  \
sim:/slave_interface_tb/dut/cs \
sim:/slave_interface_tb/dut/ns \
sim:/slave_interface_tb/dut/address_sent
run -all
