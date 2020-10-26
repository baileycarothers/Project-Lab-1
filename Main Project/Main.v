`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2020 10:34:08 PM
// Design Name: 
// Module Name: Main
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


module Main(
    input JA0,
    input JA1,
    input JA2,
    input JA3,
    output LED0,
    output LED1,
    output LED2,
    output LED3

    );
    
    assign LED0 = ~JA0;
    assign LED1 = ~JA1;
    assign LED2 = ~JA2;
    assign LED3 = ~JA3;
endmodule
