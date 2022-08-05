module serializer (
    input wire [7:0] p_data,
    input wire [1:0] fsm_control,
    input wire       clk,
    input wire       rst,
    input wire       busy,
    output reg [3:0] serial_count,
    output reg       serial_out
);

reg [7:0] p_data_reg;

always @(posedge clk or negedge rst) 
    begin
        if (!rst)
            begin
                serial_count<=4'b0;
            end
        else
            begin
                if (busy)
                    begin
                        serial_count=serial_count+1; 
                    end
                else
                    begin
                        serial_count<=4'b0;
                    end
            end    
    end


always @(posedge clk or negedge rst) 
    begin
        if (!rst)
            begin
                p_data_reg=8'b0;  
            end
        else
            begin
                case (fsm_control)
                    2'b1:
                        begin 
                            p_data_reg<=p_data;
                        end
                    2'b0:
                        begin 
                            serial_out<=p_data_reg[0];
                            p_data_reg=p_data_reg>>1;
                        end
                    default:serial_out<=1'b1;
                endcase
            end
    end

endmodule