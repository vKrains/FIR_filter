`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2024 21:54:52
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb();

    localparam WIDTH        = 16;
    localparam TAPS         = 20;
    localparam FRACTION     = 15;
    localparam COEFF_FILE         = "coe.txt";

    localparam CLK_PERIOD   = 10;

    localparam NUM_SUMPLES  = 100;

    logic                    clk;
    logic                    rst;
    logic                    i_valid;
    logic                    o_valid;
    logic signed [WIDTH-1:0] i_data;
    logic signed [WIDTH-1:0] o_data;

    integer sample_count;

    FIR #(
        .WIDTH      (WIDTH),
        .TAPS       (TAPS),
        .FRACTION   (FRACTION),
        .COEFF_FILE       (COEFF_FILE)
    ) DUT (
        .clk        (clk),
        .rst        (rst),
        .i_valid    (i_valid),
        .i_data     (i_data),
        .o_valid    (o_valid),
        .o_data     (o_data)
    );

    always #(CLK_PERIOD/2) clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        i_data = 0;
        i_valid = 0;
        sample_count =  1;

        #15
        rst = 0;
        repeat (500) begin
            i_data = $rtoi($sin(2 * 3.14159 * 11000 * sample_count / 48000) * (2 ** FRACTION));
            i_valid = 1;
            sample_count += 1;
            #10;
        end
        repeat (500) begin
            i_data = $rtoi($sin(2 * 3.14159 * 13000 * sample_count / 48000) * (2 ** FRACTION)); 
            i_valid = 1;
            sample_count += 1;
            #10;
        end
        rst = 1;
        #10;
        rst = 0;
        #10;
        repeat (500) begin
            i_data = $rtoi($sin(2 * 3.14159 * 5000 * sample_count / 48000) * (2 ** FRACTION));
            i_valid = 1;
            sample_count += 1;
            #10;
        end
        repeat (500) begin
            i_data = $rtoi($sin(2 * 3.14159 * 10000 * sample_count / 48000) * (2 ** FRACTION)); 
            i_valid = 1;
            sample_count += 1;
            #10;
        end
        repeat (500) begin
            i_data = $rtoi($sin(2 * 3.14159 * 15000 * sample_count / 48000) * (2 ** FRACTION)); 
            i_valid = 1;
            sample_count += 1;
            #10;
        end
        repeat (500) begin
            i_data = $rtoi($sin(2 * 3.14159 * 17000 * sample_count / 48000) * (2 ** FRACTION)); 
            i_valid = 1;
            sample_count += 1;
            #10;
        end
        i_valid = 0;
        sample_count =  1;
        #10;
        repeat (500) begin
            i_data = $rtoi($sin(2 * 3.14159 * 20000 * sample_count / 48000) * (2 ** FRACTION)); 
            i_valid = 1;
            sample_count += 1;
            #10;
        end
        i_valid = 0;
        sample_count =  1;
        #10;
        
    end

endmodule
