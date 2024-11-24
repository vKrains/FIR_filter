`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2024 21:54:26
// Design Name: 
// Module Name: FIR
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


module FIR #(
    parameter WIDTH = 16,
    parameter TAPS  = 20,
    parameter FRACTION = 15,
    parameter string COEFF_FILE = "coe.txt"
)(
    input logic                     clk,
    input logic                     rst,
    input logic                     i_valid,
    input logic  signed [WIDTH-1:0] i_data,
    output logic signed [WIDTH-1:0] o_data,
    output logic                    o_valid
    );

    logic signed [WIDTH-1:0] coef_reg  [TAPS-1:0];
    logic signed [WIDTH-1:0] shift_reg [TAPS-1:0];
    logic signed [(2*WIDTH)-1:0] result;
    integer i;
    integer j;
    integer k;

    initial begin
        $readmemb(COEFF_FILE, coef_reg); 
        $display("Coefficients loaded:");
        for (int i = 0; i < TAPS; i++) begin
            $display("coef_reg[%0d] = %f", i, coef_reg[i]);
        end
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < TAPS; i += 1) begin
                shift_reg[i] <= 0;
            end
        end else if (i_valid) begin
            shift_reg[0] <= i_data;
            for (j = TAPS-1; j > 0; j-=1) begin
                shift_reg[j] <= shift_reg[j-1];
            end
        end
    end

    always_ff @(posedge clk or posedge rst) begin
        if(rst) begin
            o_valid <= 0;
        end else if (i_valid) begin
            o_valid <= 1;
        end else begin
            o_valid <= 0;
        end
    end
    

    always_comb begin
        result = 0;
        for (k = 0; k < TAPS; k += 1) begin
            result += shift_reg[k] * coef_reg[k];
        end
        o_data = result >>> FRACTION;
    end
    
endmodule
