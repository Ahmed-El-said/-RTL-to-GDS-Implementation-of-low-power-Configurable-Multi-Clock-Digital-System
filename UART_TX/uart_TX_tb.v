module uart_TX_tb ();

 //declare testbench signals
reg         clk_tb;
reg         rst_tb;
reg  [7:0]  p_data_tb;
reg         data_valid_tb;
reg         par_en_tb;
reg         par_type_tb;
wire        S_data_tb;
wire        BUSY_tb;

//initial block
 initial
    begin
        $dumpfile("uart_TX.vcd");      
        $dumpvars;
        clk_tb=0;
        rst_tb=1;
        p_data_tb=8'b0;
        data_valid_tb=0;
        par_en_tb=0;
        par_type_tb=0;
        #16
        rst_tb=1;
        p_data_tb=8'b11001010;
        data_valid_tb=1;
        par_en_tb=0;
        par_type_tb=0;
    end

//clock generator
always #5 clk_tb = ~ clk_tb;

//design instantiation
uart_TX DUT (
.clk(clk_tb),
.rst(rst_tb),
.p_data(p_data_tb),
.data_valid(data_valid_Tb),
.par_en(par_en_tb),
.par_type(par_type_tb),
.S_data(S_data_tb),
.BUSY(BUSY_tb)
);

endmodule