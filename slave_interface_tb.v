module slave_interface_tb ();
  reg clk,rst_n,tx_valid,ss_n,MOSI;
  reg [7:0] tx_data;
  wire   MISO,rx_valid;
  wire [9:0] rx_data;
//================= DUT INIT. ===================
Slave_iterface dut (.clk(clk),.rst_n(rst_n),.tx_valid(tx_valid),.ss_n(ss_n),.MOSI(MOSI),.MISO(MISO),
.tx_data(tx_data),.rx_data(rx_data),.rx_valid(rx_valid));
//================ clock generation ========================
initial begin
  clk=0;
  forever begin
    #1 clk=~clk;
  end
end
//==========================t testbench =================================
initial begin
  rst_n=0; tx_valid=0; ss_n=1; MOSI=0;tx_data=0;
  @(negedge clk);
  rst_n=1;
  ss_n=0;
  @(negedge clk);
  @(negedge clk);
// 10 bits are being sent through MOSI (address sent)
  MOSI=0;
  @(negedge clk);
  @(negedge clk);
  MOSI=1;
  repeat(8) begin
  @(negedge clk);
  end
  @(negedge clk);
  ss_n=1;
  @(negedge clk);
//===================================================================
// at idle state 
  ss_n=0;
  @(negedge clk);
  MOSI=0;
  @(negedge clk);
//===================================================================
// sending the 10 bits through MOSI (data is being sent)
  @(negedge clk);
  MOSI=1;
  @(negedge clk);
  repeat(8) begin
    MOSI=$random;
  @(negedge clk);
  end
  @(negedge clk);
  ss_n=1;
  @(negedge clk);
//=====================================================================
//idle state 
  ss_n=0;
  @(negedge clk);
  MOSI=1;
  @(negedge clk);
//=====================================================================
//sending address to read from
  MOSI=1;
  @(negedge clk);
  MOSI=0;
  @(negedge clk);
  repeat(8) begin
    MOSI=$random;
  @(negedge clk);
  end
  @(negedge clk);
  ss_n=1;
  @(negedge clk);

//==========================================================
//idle state 
ss_n=0;
@(negedge clk);
MOSI=1;
@(negedge clk);
//==========================================================
tx_valid=1;
tx_data=8'b1000_1011;
repeat(8) begin
  @(negedge clk);
end
@(negedge clk);
ss_n=1;
@(negedge clk);
$stop;
end
endmodule