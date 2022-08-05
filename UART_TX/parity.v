module parity (
    input wire [7:0] p_data,
    input wire       parity_type,
    input wire       parity_switch,
    output reg       parity_b
);

always @(*)
    begin
        if (parity_switch) 
            begin
                case (parity_type)
                    1'b0:parity_b=^p_data[7:0];//even parity
                    1'b1:parity_b=~^p_data[7:0];//odd parity
                endcase    
            end
        else 
            begin
                parity_b=1'b0;
            end
    end

endmodule