module uart_TX (
    input wire       clk,
    input wire       rst,
    input wire [7:0] p_data,
    input wire       data_valid,
    input wire       par_en,
    input wire       par_type,
    output wire      S_data,
    output wire      BUSY
);

//internal connections
wire [1:0] fsm_control_wire;
wire       mux_i1;
wire       mux_i2;
wire [1:0] mux_sel;
wire [3:0] count;

FSMD fsm (
    .clk(clk),
    .rst(rst),
    .data_valid(data_valid),
    .parity_switch(par_en),
    .serial_count(count),
    .busy(BUSY),
    .serial_in(fsm_control_wire),
    .sel(mux_sel)
);
    
serializer serial (
    .p_data(p_data),
    .busy(BUSY),
    .fsm_control(fsm_control_wire),
    .serial_count(count),
    .clk(clk),
    .rst(rst),
    .serial_out(mux_i1)
);

parity p (
    .p_data(p_data),
    .parity_type(par_type),
    .parity_switch(par_en),
    .parity_b(mux_i2)
);

mux m (
    .i1(mux_i1),
    .i2(mux_i2),
    .sel(mux_sel),
    .mux_out(S_data)
);

endmodule