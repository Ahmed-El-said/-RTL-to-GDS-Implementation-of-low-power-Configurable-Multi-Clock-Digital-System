module FSMD (
    input wire       clk,
    input wire       rst,
    input wire       data_valid,
    input wire       parity_switch,
    input wire [3:0] serial_count,
    output reg       busy,
    output reg [1:0] serial_in,
    output reg [1:0] sel
);
    
localparam  idle=3'b0,//idle wait for data_valid then accept
            s0=3'b1,//start bit and serializing
            s1=3'b10,//payload stream wait for 8 cycles
            s2=3'b11,//without parity and end bit
            s3=3'b100;//parity stream

reg [2:0] state,next_state;

always @(posedge clk or negedge rst) 
    begin
        if (!rst) 
            begin
                state<=idle;
            end
        else
            begin
                state<=next_state;                
            end
    end

always @(*) 
    begin
        case (state)
            idle:
                begin
                    busy=1'b0;
                    serial_in=2'b10;
                    sel=2'b1;
                    if (data_valid) 
                        begin
                            next_state=s0;
                            serial_in=2'b1;
                        end
                    else
                        begin
                            next_state=idle;
                        end
                end
            s0:
                begin
                    busy=1'b1;
                    serial_in=2'b0;
                    sel=2'b0;
                    next_state=s1;
                end
            s1:
                begin
                    busy=1'b1;
                    serial_in=2'b0;
                    sel=2'b1;
                    if (serial_count==4'b1000) 
                        begin
                            if (parity_switch) 
                                begin
                                    next_state=s3;
                                end
                            else
                                begin
                                    next_state=s2;
                                end
                        end
                    else
                        begin
                            next_state=s1;
                        end
                end
            s2:
                begin
                    busy=1'b1;
                    serial_in=2'b10;
                    sel=2'b11;
                    next_state=idle;
                end
            s3:
                begin
                    busy=1'b1;
                    serial_in=2'b10;
                    sel=2'b10;
                    next_state=s3;
                end
        endcase
    end

endmodule