module mux (
    input wire       i1,
    input wire       i2,
    input wire [1:0] sel,
    output reg       mux_out
);

always @(*) 
    begin
        case (sel)
            2'b00:
                begin
                    mux_out=1'b0;
                end
            2'b01:
                begin
                    mux_out=i1;
                end
            2'b10:
                begin
                    mux_out=i2;
                end
            2'b11:
                begin
                    mux_out=1'b0;
                end
        endcase    
    end
endmodule