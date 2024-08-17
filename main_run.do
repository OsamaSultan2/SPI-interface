vlib work 
vlog Slave_interface.v SinglePort_Ram.v spi_slave_with_single_port_ram.v SPI_tb.v
vsim -voptargs=+acc work.SPI_tb 
add wave -position insertpoint  \
sim:SPI_tb/dut/ram/mem \
sim:SPI_tb/dut/slave/cs \
sim:SPI_tb/dut/slave/ns 

add wave *
run -all



