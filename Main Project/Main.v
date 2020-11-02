//Do not change timescale please :)
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Texas Tech University
// Engineer: Bailey Carothers
//
// Most updated version: github.com/baileycarothers/Project-Lab-1
// 
// Create Date: 10/25/2020 10:34:08 PM
// Design Name: Project Lab 1
// Module Name: Main
// Project Name: Autonomous Rover
// Target Devices: Basys 3
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Revision 0.1  - IO and constraints created
// Additional Comments: If something doesn't work, verify your constraints file.
// IPS sensors output a logic high signal when nothing is detected.
// 
//////////////////////////////////////////////////////////////////////////////////


module Main(
    input clock,
    //IPS Sensors
    input JA0, JA1, JA2, JA3,
    //IPS LEDs
    output LED0, LED1, LED2, LED3,
    //Comparator control
    //input JA4, JA5,
    //Electromagnet Control
    output JA6,
    //Electromagnet testing
    input SW0,
    //Motor control
    output JC0, JC1, JC2, JC3, JC4, JC5,
    //Motor LEDs
    output LED12, LED13, LED14, LED15
);
    
//LEDs turn on when corresponding IPS detects metal
assign LED0 = ~JA0;
assign LED1 = ~JA1;
assign LED2 = ~JA2;
assign LED3 = ~JA3;

//Electromagnet testing
assign SW0 = JA6;

//Declare variables
reg motorStop;
reg currentProtection;

//Initialize variables
initial begin
    motorStop = 0;
    currentProtection = 0;
end

//Set up clock to control speed
reg [15:0] speedControl;
always @ (posedge clock)
    begin
        if (speedControl < 32767)
            speedControl <= speedControl + 1;
        else
            speedControl <= 0;
    end

//Two possible speeds using wires
wire speed1;
    assign speed1 = (speedControl < 23550) ? 1:0;

wire speed2;
    assign speed2 = (speedControl < 26555) ? 1:0;

//Put IPS sensors into an array for case statement
reg [3:0] IPSInput;
always @ (*)
    begin
        IPSInput[3] = ~JA3;
        IPSInput[2] = ~JA2;
        IPSInput[1] = ~JA1;
        IPSInput[0] = ~JA0;
    end
 
//Used to control speed of each side 
reg [1:0] MotorSides;
assign JC4 = MotorSides[1]; //Left side
assign JC5 = MotorSides[0]; //Right side

//Used to control direction of each side
reg [3:0] MotorPolarity = 4'b0000;
assign JC0 = MotorPolarity[0]; //Right side forward
assign JC1 = MotorPolarity[1]; //Right side backward
assign JC2 = MotorPolarity[2]; //Left side forward
assign JC3 = MotorPolarity[3]; //Left side backward

//Motor direction testing
assign LED15 = MotorPolarity[2];
assign LED14 = MotorPolarity[3];
assign LED13 = MotorPolarity[0];
assign LED12 = MotorPolarity[1];

always @ (*)
    if(currentProtection==0)begin
        case(IPSInput)
            4'b0000: 
                begin
                    MotorSides[1] = speed1;
                    MotorSides[0] = speed1;
                    MotorPolarity[2] = 1;
                    MotorPolarity[0] = 1;
                    MotorPolarity[1] = 0;
                    MotorPolarity[3] = 0;
                end
            4'b0001: 
                begin
                    MotorSides[1] = speed1;
                    MotorSides[0] = motorStop;
                    MotorPolarity[2] = 1;
                    MotorPolarity[0] = 1;
                    MotorPolarity[1] = 0;
                    MotorPolarity[3] = 0;
                end
            4'b0010: 
                begin
                    MotorSides[1] = speed2;
                    MotorSides[0] = speed1;
                    MotorPolarity[2] = 1;
                    MotorPolarity[0] = 1;
                    MotorPolarity[1] = 0;
                    MotorPolarity[3] = 0;
                end
            4'b0011: 
                begin
                    MotorSides[1] = speed1;
                    MotorSides[0] = motorStop;
                    MotorPolarity[2] = 1;
                    MotorPolarity[0] = 1;
                    MotorPolarity[1] = 0;
                    MotorPolarity[3] = 0;
                end
            4'b0100: 
                begin
                    MotorSides[1] = speed1;
                    MotorSides[0] = speed2;
                    MotorPolarity[2] = 1;
                    MotorPolarity[0] = 1;
                    MotorPolarity[1] = 0;
                    MotorPolarity[3] = 0;
                end
            4'b0101: 
                begin
                    MotorSides[1] = speed1;
                    MotorSides[0] = motorStop;
                    MotorPolarity[2] = 1;
                    MotorPolarity[0] = 1;
                    MotorPolarity[1] = 0;
                    MotorPolarity[3] = 0;
                end
            4'b0110: 
                begin
                    MotorSides[1] = speed1;
                    MotorSides[0] = speed1;
                    MotorPolarity[2] = 1;
                    MotorPolarity[0] = 1;
                    MotorPolarity[1] = 0;
                    MotorPolarity[3] = 0;
                end
            4'b0111: 
                begin
                    MotorSides[1] = speed1;
                    MotorSides[0] = motorStop;
                    MotorPolarity[2] = 1;
                    MotorPolarity[0] = 1;
                    MotorPolarity[1] = 0;
                    MotorPolarity[3] = 0;
                end
            4'b1000: 
                begin
                    MotorSides[1] = motorStop;
                    MotorSides[0] = speed1;
                    MotorPolarity[2] = 1;
                    MotorPolarity[0] = 1;
                    MotorPolarity[1] = 0;
                    MotorPolarity[3] = 0;
                end
            4'b1001: 
                begin
                    MotorSides[1] = speed1;
                    MotorSides[0] = speed1;
                    MotorPolarity[2] = 1;
                    MotorPolarity[0] = 1;
                    MotorPolarity[1] = 0;
                    MotorPolarity[3] = 0;
                end
            4'b1010: 
                begin
                    MotorSides[1] = motorStop;
                    MotorSides[0] = speed1;
                    MotorPolarity[2] = 1;
                    MotorPolarity[0] = 1;
                    MotorPolarity[1] = 0;
                    MotorPolarity[3] = 0;
                end
            4'b1011: 
                begin
                    MotorSides[1] = speed1;
                    MotorSides[0] = speed1;
                    MotorPolarity[2] = 1;
                    MotorPolarity[0] = 1;
                    MotorPolarity[1] = 0;
                    MotorPolarity[3] = 0;
                end
            4'b1100: 
                begin
                    MotorSides[1] = motorStop;
                    MotorSides[0] = speed1;
                    MotorPolarity[2] = 1;
                    MotorPolarity[0] = 1;
                    MotorPolarity[1] = 0;
                    MotorPolarity[3] = 0;
                end
            4'b1101: 
                begin
                    MotorSides[1] = speed1;
                    MotorSides[0] = speed1;
                    MotorPolarity[2] = 1;
                    MotorPolarity[0] = 1;
                    MotorPolarity[1] = 0;
                    MotorPolarity[3] = 0;
                end
            4'b1110: 
                begin
                    MotorSides[1] = motorStop;
                    MotorSides[0] = speed1;
                    MotorPolarity[2] = 1;
                    MotorPolarity[0] = 1;
                    MotorPolarity[1] = 0;
                    MotorPolarity[3] = 0;
                end
            4'b1111: 
                begin
                    MotorSides[1] = speed1;
                    MotorSides[0] = speed1;
                    MotorPolarity[2] = 1;
                    MotorPolarity[0] = 1;
                    MotorPolarity[1] = 0;
                    MotorPolarity[3] = 0;
                end  
        endcase
    end
                
endmodule
